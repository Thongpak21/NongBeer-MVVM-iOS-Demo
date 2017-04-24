//
//  Router.swift
//  youtube
//
//  Created by Thongpak on 3/25/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation
import Alamofire
public protocol NongBeerRouter: URLRequestConvertible {
    
    var url: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: AnyObject]? { get }
    var responseClass: BaseModel.Type { get }
    func asURLRequest() throws -> URLRequest
}


public enum Router: NongBeerRouter {

    case getListBeer(page: Int)
    case getHistory(page: Int)
    case addNewOrder(latitude: String, longitude: String, beers: Array<Any>)
}

extension Router {
    public var url: String {
            return "http://demo6264771.mockable.io"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getListBeer:
            return .get
        case .getHistory:
            return .get
        case .addNewOrder:
            return .post
        }
    }
    
    public var path: String {
        switch self {
        case .getListBeer:
            return "/api/v1/beer"
        case .getHistory:
            return "/api/v1/order"
        case .addNewOrder:
            return "/api/v1/order"
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .getListBeer(let page):
            let params = ["page": page]
            return params as [String : AnyObject]
    
        case .getHistory(let page):
            let params = ["page": page]
            return params as [String : AnyObject]
            
        case .addNewOrder(let data):
            let params = [
                "location" : ["latitude": data.latitude, "longitude": data.longitude ],
                "beers": data.beers
            ] as [String : Any]

            return params as [String : AnyObject]

        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var responseClass: BaseModel.Type {
        switch self {
        case .getListBeer:
            return BeerModel.self
        case .getHistory:
            return HistoryModel.self
        default:
            return BaseModel.self
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let baseUrl = try url.asURL()
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getListBeer:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .getHistory:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .addNewOrder:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
    
}


enum asd: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {

        return urlRequest!
    }
}
