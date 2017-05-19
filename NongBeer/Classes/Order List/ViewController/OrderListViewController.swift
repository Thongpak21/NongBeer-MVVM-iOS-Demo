//
//  OrderListViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/7/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit
import EZSwiftExtensions
import SwiftEventBus
class OrderListViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var confirmOrderButton: BaseButton!
    @IBOutlet weak var totalPrice: UILabel!
    lazy var viewModel: OrderListViewModelProtocol = OrderListViewModel(delegate: self)
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width * 0.8, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        confirmOrderButton.setButtonNormal()
        self.confirmOrderButton.addTarget(self, action: #selector(pushConfirm), for: .touchUpInside)
        setEventBus()
    }
    
    func updateOrder() {
        self.adapter.performUpdates(animated: true, completion: nil)
        self.updateTotalPrice()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SwiftEventBus.post("postFromOrderVC")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateOrder()
    }
    
    func pushConfirm() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ConfirmDestinationViewController") as! ConfirmDestinationViewController
        vc.delegate = self
        vc.orderList = self.viewModel.order
        let navController = UINavigationController(rootViewController: vc)
        self.presentVC(navController)
    }
    
    func setCollectionView() {
        self.containerView.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let frame = self.containerView.bounds
        collectionView.frame = frame
    }

    
    func updateTotalPrice() {
        if viewModel.order.isEmpty {
            self.confirmOrderButton.disableButton()
        } else {
            self.confirmOrderButton.setButtonNormal()
        }
        self.totalPrice.text = viewModel.totalPrice()
    }
    
    func setEventBus() {
        SwiftEventBus.onBackgroundThread(self, name: "postToOrderVC") { (result) in
            let order = result.object as! [BeerModel]
            self.viewModel.order = order
        }
    }
    
    
}

extension OrderListViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.order
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = OrderListSectionViewController()
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let emptyView = Bundle.main.loadNibNamed("EmptyOrderView", owner: nil, options: nil)!.first
        return emptyView as? UIView
    }
}

extension OrderListViewController: OrderSuccessViewControllerDelegate {
    func reloadOrder() {
        SwiftEventBus.post("removeOrderFromOrderVC", sender: "removeAll")
        _ = self.viewModel.order.map({ $0.isAddtoCart = false })
        self.viewModel.order = [BeerModel]()
        updateTotalPrice()
        adapter.performUpdates(animated: true, completion: nil)
    }
}


extension OrderListViewController: OrderListSectionViewControllerDelegate {
    func updateAmount() {
        self.updateTotalPrice()
    }
    
    func removeOrder(id: String, section: Int) {
        self.viewModel.order[section].isAddtoCart = false
        SwiftEventBus.post("removeOrderFromOrderVC", sender: self.viewModel.order[section])
        self.viewModel.order.remove(at: section)
        updateTotalPrice()
        adapter.performUpdates(animated: true, completion: nil)
    }
}
