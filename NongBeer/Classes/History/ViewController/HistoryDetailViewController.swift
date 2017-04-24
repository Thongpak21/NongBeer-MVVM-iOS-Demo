//
//  HistoryDetailViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/11/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit
class HistoryDetailViewController: BaseViewController {
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    var viewModel: HistoryViewModel!
    var object = [HistoryModel]()
    let collectionView: IGListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 60)
        let collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HistoryViewModel(delegate: self)
        setCollectionView()
    }
    
    func setCollectionView() {
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension HistoryDetailViewController: IGListAdapterDataSource {
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.object
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        let sectionController = HistoryDetailSectionController()
        return sectionController
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        let nibView = Bundle.main.loadNibNamed("EmptyView", owner: nil, options: nil)!.first as! EmptyView
        return nibView
    }
}
