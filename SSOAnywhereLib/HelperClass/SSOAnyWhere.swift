//
//  SSOAnyWhere.swift
//  SnoozerLibrary
//
//  Created by admin on 16/01/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

@objcMembers public class SSOAnyWhere:NSObject,ResponseHandler
{
    public static func handle(result: Result, data: Any?, completionHandler: ([String : Any], Result) -> ()) {
        
    }

     let sessionObject = Session()
     let AuthoriseObj = Authorize()
    public var current_expiredTime : Int
    {
        return self.sessionObject.Token_Expired_Time
    }
    public var getAccessToken : String
    {
        return self.sessionObject.accessToken
    }
    public var getRefreshToken : String
    {
        return self.sessionObject.refreshToken
    }
    public var is_FromRefresh : Bool
    {
        return self.sessionObject.isFromRefresh
    }

    //var onComplete: ((_ result: [String:Any])->())?
    var dictResult = [String:Any]()
   public static let shared = SSOAnyWhere()
    private override init() {
        print("initialize only once")
    }

  public func Setup(clientID:String, clientSecret:String)
    {
        sessionObject.setCLientID(clientID)
        sessionObject.setClientSecret(clientSecret)
    }

    public func isLoggedIn() -> Bool
     {
        let TotalSeconds = Date().currentSeconds
        if  SSOAnyWhere.shared.sessionObject.Token_Expired_Time > 0
        {
            if ((SSOAnyWhere.shared.sessionObject.Token_Expired_Time == 0) || (SSOAnyWhere.shared.sessionObject.Token_Expired_Time < TotalSeconds) || (SSOAnyWhere.shared.sessionObject.Token_Expired_Time - TotalSeconds == 60))
            {
              return false
            }
            else
            {
              return true
            }
        }
        return false
     }

   public func deleteAllKeysInSession()  {
        SSOAnyWhere.shared.sessionObject.DeleteKeyInSession(withKey: "ACCESS_TOKEN")
        SSOAnyWhere.shared.sessionObject.DeleteKeyInSession(withKey: "REFRESHTOKEN")
        SSOAnyWhere.shared.sessionObject.DeleteKeyInSession(withKey: "TOKEN_EXPIRED_TIME")
    }
    public func checkIfLoginCredentialsIsEmpty(userName: String, password: String) -> Bool {
        
        if (!userName.isEmpty && !password.isEmpty)
        {
            return true
        }
        return false
    }
    
    public static func callingAutherizeAPI(userName: String, password: String, _ completionHandler: @escaping JSONCompletionHandler)
    {
        if (SSOAnyWhere.shared.checkIfLoginCredentialsIsEmpty(userName : userName , password: password))
        {
            SSOAnyWhere.shared.AuthoriseObj.makeAPICall(to: AuthorizeAPIPostSettings.Authorize(userName: userName, password: password), isFromRefreshAPI: false) { result,resultType  in
                self.handle(result: resultType, data: result, completionHandler: completionHandler)
            }
        }
        else
        {
            let userInfo: [String : Any] =
                [
                    NSLocalizedDescriptionKey  :  NSLocalizedString("Unauthorized", value: NSLocalizedString("invalid_credentials", comment:""), comment: "") ,
                    NSLocalizedFailureReasonErrorKey  : NSLocalizedString("Unauthorized", value:  NSLocalizedString("invalid_credentials", comment:""), comment: "")
            ]
            let error = NSError(domain: "HttpResponseErrorDomain", code: 401, userInfo: userInfo)
            self.handleFailedAPICall(for: error, completionHandler: completionHandler)
        }
    }
    
    
    public static func callingRefreshAutherizeAPI( _ completionHandler: @escaping JSONCompletionHandler)
    {
        SSOAnyWhere.shared.AuthoriseObj.makeAPICall(to: AuthorizeAPIPostSettings.Refresh, isFromRefreshAPI: true) { result, resultType in
            self.handle(result: resultType, data:result , completionHandler: completionHandler)
        }
    }

}
