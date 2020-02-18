//
//  AuthorizeAPIPostSettings.swift
//  SnoozerLibrary
//
//  Created by admin on 22/01/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Alamofire
enum AuthorizeAPIPostSettings: AlamofireEndPoint {
    
    case Authorize(userName: String, password: String)
    case Refresh

    //TODO: create constant files to handle constant
    func provideValues()->(url: String, httpMethod: HTTPMethod, parameters:[String:Any]?,encoding: ParameterEncoding ,httpHeaders: HTTPHeaders) {
        let baseURL = "https://cloudsso.saint-gobain.com/openam/oauth2/access_token"
        let header = PostHeaders()
        switch self
        {
          case .Refresh:
            let params = parameters()
            return (url:  baseURL, httpMethod: .post, parameters: params, encoding: URLEncoding.default,httpHeaders: header)
        case let .Authorize(userName: userName, password: password):
            let params = parameters(for: userName, for: password)
            return (url: baseURL, httpMethod: .post, parameters: params, encoding: URLEncoding.default ,httpHeaders: header)
          }
    }
    
    
    private func parameters(for userName: String ,for password: String)->[String : String] {
        return [
            "grant_type"   : "password",
            "client_id"    :  SSOAnyWhere.shared.sessionObject.client_ID ,
            "client_secret":  SSOAnyWhere.shared.sessionObject.client_Secret ,
            "username"     :  userName,
            "password"     :  password,
        ]
    }
    
    private func parameters()->[String : String] {
        return [
            "grant_type" :      "refresh_token",
            "client_id"  :      SSOAnyWhere.shared.sessionObject.client_ID ,
            "client_secret":    SSOAnyWhere.shared.sessionObject.client_Secret ,
            "refresh_token"  :  SSOAnyWhere.shared.sessionObject.refreshToken,
        ]
    }
    private func PostHeaders()->[String : String] {
        return [
             "Content-Type": "application/x-www-form-urlencoded",
        ]
    }
    
}

