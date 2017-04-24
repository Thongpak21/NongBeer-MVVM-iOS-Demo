//
//  BaseViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import MBProgressHUD
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension BaseViewController: BaseViewModelDelegate {
    public func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = .indeterminate
    }
    
    public func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    public func onDataDidLoad() {
        
    }
    
    public func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
    }
}
