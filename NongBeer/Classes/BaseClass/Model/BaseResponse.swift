//
//  BaseResponse.swift
//  youtube
//
//  Created by Thongpak on 3/25/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation


public class BaseModel: NSObject {
    var status: String?
    var message: String?
    public required init(withDictionary dict: AnyObject) {
        self.status = dict["status"] as? String
        self.message = dict["message"] as? String
    }
}

