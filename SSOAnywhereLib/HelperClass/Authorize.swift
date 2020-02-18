//
//  Authorize.swift
//  SnoozerLibrary
//
//  Created by admin on 16/01/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Authorize
{

    /// The Reponse type from Alamofire is Any

     func saveAuthDataKeyChain(for json: Any, isFromRefreshAPI : Bool)
    {
        if let json = json as? [String : Any]
        {
            let token_expired_time = json["expires_in"] as? Int
            let currentSeconds = Date().currentSeconds
            if !isFromRefreshAPI
            {
                if let tokenExp = token_expired_time
                {
                     SSOAnyWhere.shared.sessionObject.setTokenExpiredTime(currentSeconds + tokenExp)
                }

                SSOAnyWhere.shared.sessionObject.setAccessToken(json["access_token"] as? String ?? "")
                SSOAnyWhere.shared.sessionObject.setRefreshAccessToken(json["refresh_token"] as? String ?? "")
                SSOAnyWhere.shared.sessionObject.setIsRefresh(isFromRefreshAPI)
                print(json)
                print(SSOAnyWhere.shared.sessionObject.Token_Expired_Time)
                print(SSOAnyWhere.shared.sessionObject.refreshToken)
                print(SSOAnyWhere.shared.sessionObject.accessToken)
                print(SSOAnyWhere.shared.sessionObject.isFromRefresh)
            }

            else
            {
                // from refreshCall
                SSOAnyWhere.shared.sessionObject.DeleteKeyInSession(withKey: "ACCESS_TOKEN")
                SSOAnyWhere.shared.sessionObject.DeleteKeyInSession(withKey: "REFRESH_TOKEN")
                SSOAnyWhere.shared.sessionObject.DeleteKeyInSession(withKey: "TOKEN_EXPIRED_TIME")
                if let tokenExp = token_expired_time
                {
                    SSOAnyWhere.shared.sessionObject.setTokenExpiredTime(currentSeconds + tokenExp)
                }
                SSOAnyWhere.shared.sessionObject.setAccessToken(json["access_token"] as? String ?? "")
                SSOAnyWhere.shared.sessionObject.setRefreshAccessToken(json["refresh_token"] as? String ?? "")
                SSOAnyWhere.shared.sessionObject.setIsRefresh(isFromRefreshAPI)
                print(json)
                print(SSOAnyWhere.shared.sessionObject.Token_Expired_Time)
                print(SSOAnyWhere.shared.sessionObject.refreshToken)
                print(SSOAnyWhere.shared.sessionObject.accessToken)
                print(SSOAnyWhere.shared.sessionObject.isFromRefresh)
            }
        }
    }

    typealias AlamofireJSONCompletionHandler = (Any , Result)->()

     func makeAPICall(to endPoint: AlamofireEndPoint, isFromRefreshAPI:Bool, completionHandler:@escaping AlamofireJSONCompletionHandler) {
            Alamofire.request(endPoint.url, method: .post, parameters: endPoint.parameters,encoding: endPoint.encoding, headers: endPoint.httpHeaders).validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    self.saveAuthDataKeyChain(for: value, isFromRefreshAPI: isFromRefreshAPI)
                    completionHandler(value,Result.success)
                case .failure(let error):
                    completionHandler(error,Result.failure)
                }
            }
        }
}



