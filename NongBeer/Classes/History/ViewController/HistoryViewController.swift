//
//  SecondViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/5/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit
class HistoryViewController: BaseViewController {
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    lazy var viewModel: HistoryViewModelProtocol = HistoryViewModel(delegate: self)
    let collectionView: IGListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 60)
        let collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        self.viewModel.getListHistoryService()
    }
    
    override func onDataDidLoad() {
        if self.viewModel.isPullToRefresh == true {
            self.viewModel.isPullToRefresh = false
            if #available(iOS 10.0, *) {
                self.adapter.collectionView?.refreshControl?.endRefreshing()
            }
        }
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    func setCollectionView() {
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        if #available(iOS 10.0, *) {
            adapter.collectionView?.refreshControl = UIRefreshControl()
            adapter.collectionView?.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        }
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    func pullToRefresh() {
        self.viewModel = HistoryViewModel(delegate: self)
        self.viewModel.isPullToRefresh = true
        self.viewModel.getListHistoryService()
    }
}


extension HistoryViewController: IGListAdapterDataSource {
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.viewModel.history
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        switch object {
        case is String:
            return LoadingSectionController()
        case is HistoryModel:
            return HistorySectionController()
        default:
            return IGListSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        let nibView = Bundle.main.loadNibNamed("EmptyView", owner: nil, options: nil)!.first as! EmptyView
        return nibView
    }
    
}

extension HistoryViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        let nextOrderAvailable = (self.viewModel.history as? [HistoryModel])?.last?.nextOrderAvailable
        if nextOrderAvailable == true && distance < 200 {
            self.viewModel.history.append(LoadingType.loadmore.rawValue as IGListDiffable)
            self.viewModel.getListHistoryService()
            adapter.performUpdates(animated: true, completion: nil)
        }
    }
}
