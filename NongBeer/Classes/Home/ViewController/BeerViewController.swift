//
//  FirstViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/4/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import SWRevealViewController
import IGListKit
import EZSwiftExtensions
import SwiftEventBus

class BeerViewController: BaseViewController {
    lazy var viewModel: BeerViewModelProtocol = BeerViewModel(delegate: self)

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestureRecognizer()
        viewModel.getListBeerService()
        setCollectionView()
        setButtonNavigationBar()
        setEventBus()
        
    }

    override func onDataDidLoad() {
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    override func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
    }

    func setCollectionView() {
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.scrollViewDelegate = self
        adapter.dataSource = self
        collectionView.frame = view.bounds

    }
    
    func setButtonNavigationBar() {
        self.navigationItem.rightBarButtonItem?.target = revealViewController()
        self.navigationItem.rightBarButtonItem?.action = #selector(SWRevealViewController.rightRevealToggle(_:))
    }
    
    func setGestureRecognizer() {
        self.revealViewController().delegate = self
        if (self.revealViewController() != nil) {
            let revealWidth = UIScreen.main.bounds.width * 0.8
            let overdrawWidth = UIScreen.main.bounds.width - revealWidth
            self.revealViewController().rightViewRevealOverdraw = overdrawWidth
            self.revealViewController().rightViewRevealWidth = revealWidth
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func setEventBus() {
        SwiftEventBus.onBackgroundThread(self, name: "postFromOrderVC") { (notification) in
            SwiftEventBus.post("postToOrderVC", sender: self.viewModel.listOrder)
        }
        
        SwiftEventBus.onBackgroundThread(self, name: "removeOrderFromOrderVC") { (result) in
            if let order = result.object, order as? String == "removeAll" {
                self.viewModel.listOrder = [BeerModel]()
            } else {
                let order = result.object as! BeerModel
                self.viewModel.listOrder.removeAll(order)
            }
            SwiftEventBus.postToMainThread("perFormUpdate")
        }
        SwiftEventBus.onMainThread(self, name: "perFormUpdate") { (notification) in
            self.adapter.reloadObjects(self.viewModel.beer)
        }
    }
}


extension BeerViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.viewModel.beer
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is String:
            return LoadingSectionController()
        case is BeerModel:
            let sectionController = BeerSectionController()
            sectionController.delegate = self
            return sectionController
        default:
            return ListSectionController()
        }

    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let nibView = Bundle.main.loadNibNamed("EmptyView", owner: nil, options: nil)!.first as! EmptyView
        nibView.delegate = self
        return nibView
    }
    
}


extension BeerViewController: SWRevealViewControllerDelegate {
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if position == FrontViewPosition.leftSide {
            self.adapter.collectionView?.isUserInteractionEnabled = false
            self.tabBarController?.tabBar.isUserInteractionEnabled = false
        } else {
            self.adapter.collectionView?.isUserInteractionEnabled = true
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        }
    }
}

extension BeerViewController: UIScrollViewDelegate, EmptyViewDelegate {
    
    func didReload() {
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        let nextBeerAvailable = (self.viewModel.beer as? [BeerModel])?.last?.nextBeerAvailable
        if nextBeerAvailable == true && distance < 200 {
            self.viewModel.beer.append(LoadingType.loadmore.rawValue as ListDiffable)
            self.viewModel.getListBeerService()
            adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
}

extension BeerViewController: BeerSectionControllerDelegate {

    func addOrder(item: BeerModel?) {
        viewModel.listOrder.append(item!)
    }
    
    func removeOrder(item: BeerModel?) {
        viewModel.listOrder.removeAll(item!)
    }

}
