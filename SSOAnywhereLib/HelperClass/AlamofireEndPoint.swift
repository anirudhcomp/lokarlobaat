//
//  AlamofireEndPoint.swift
//  SnoozerLibrary
//
//  Created by admin on 22/01/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Alamofire
protocol AlamofireEndPoint {
    
    /// Provides all the information required to make the API call from Alamofire
    func provideValues()-> (url: String, httpMethod: HTTPMethod, parameters:[String:Any]?,encoding: ParameterEncoding , httpHeaders: HTTPHeaders)
    
    var url: URLConvertible         { get }
    var httpMethod: HTTPMethod      { get }
    var parameters: [String: Any]?  { get }
    var encoding: ParameterEncoding { get }
    var httpHeaders : HTTPHeaders   { get }
    
}

extension AlamofireEndPoint {
    
    var url: URLConvertible         { return provideValues().url }
    var httpMethod: HTTPMethod      { return provideValues().httpMethod }
    var parameters: [String: Any]?  { return provideValues().parameters }
    var encoding: ParameterEncoding { return provideValues().encoding }
    var httpHeaders: HTTPHeaders    { return provideValues().httpHeaders }
}
