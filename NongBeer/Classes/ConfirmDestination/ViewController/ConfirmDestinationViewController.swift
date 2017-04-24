//
//  ConfirmDestinationViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/9/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
class ConfirmDestinationViewController: BaseViewController, GMSMapViewDelegate {
    @IBOutlet weak var markerView: UIImageView!
    @IBOutlet weak var confirmDesButton: BaseButton!
    var orderList = [BeerModel]()
    var position: CLLocationCoordinate2D?

    weak var delegate: OrderSuccessViewControllerDelegate?
    var viewModel: ConfirmDestinationViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationButton()
        self.confirmDesButton.addTarget(self, action: #selector(orderSuccess), for: .touchUpInside)
        self.confirmDesButton.setButtonNormal()
        setNavigationBarProperties()
        viewModel = ConfirmDestinationViewModel(delegate: self)
    }
    
    func orderSuccess() {
        let mapOrder = self.orderList.map({ ["id": $0.id!, "amount": $0.amount] })
        self.viewModel.requestOrderService(order: mapOrder, location: position!)
    }
    
    override func onDataDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateVC(OrderSuccessViewController.self)
        vc?.delegate = delegate
        self.pushVC(vc!)
    }
    
    func setNavigationBarProperties() {
        self.navigationBarColor = UIColor(hexString: "FFBC00")
    }
    
    func setNavigationButton() {
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = #selector(didTabBackNavigation)
    }
    
    func didTabBackNavigation() {
        dismissVC(completion: nil)
    }
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: 13.7453729, longitude: 100.5348983, zoom: 15)
        var frame = self.view.bounds
        frame.h = frame.h - 60
        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        self.view.addSubview(mapView)
        self.view.addSubview(markerView)

    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print(position.target)
        self.position = position.target
    }
}
