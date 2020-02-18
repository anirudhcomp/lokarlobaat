//
//  TheSessionHelper.swift
//  SnoozerLibrary
//
//  Created by admin on 14/01/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

protocol sessionKeysHelperProtocol
{
    func isLoggedIn() -> Bool
    func deleteAllKeysInSession()
}

class Session {

    var isFromRefresh : Bool
    {
        get {
            return KeychainWrapper.standard.bool(forKey: "IS_FROMREFRESH") ?? false
        }
    }

    var refreshToken: String
    {
        get {
            return KeychainWrapper.standard.string(forKey: "REFRESH_TOKEN") ?? ""
        }
    }

    var accessToken :String
    {
        get {
            return KeychainWrapper.standard.string(forKey: "ACCESS_TOKEN") ?? ""
        }
    }

    var client_ID:String
    {
        get {
            return KeychainWrapper.standard.string(forKey: "CLIENT_ID") ?? ""
        }
    }
    var client_Secret:String
    {
        get {
            return KeychainWrapper.standard.string(forKey: "CLIENT_SECRET") ?? ""
        }
    }

    var Token_Expired_Time: Int
    {
        get {
            return KeychainWrapper.standard.integer(forKey: "TOKEN_EXPIRED_TIME") ?? -1
        }
    }

    func setIsRefresh(_ Is_FromRefresh:Bool) {
        KeychainWrapper.standard.set(Is_FromRefresh, forKey: "IS_FROMREFRESH")
    }

    func setTokenExpiredTime(_ token_expired_time:Int) {
        KeychainWrapper.standard.set(token_expired_time, forKey: "TOKEN_EXPIRED_TIME")
    }

    func setAccessToken(_ accessToken:String) {
        KeychainWrapper.standard.set(accessToken, forKey: "ACCESS_TOKEN")
    }

    func setRefreshAccessToken(_ refreshToken:String) {
        KeychainWrapper.standard.set(refreshToken, forKey: "REFRESH_TOKEN")
    }

    func setCLientID(_ clientID:String) {
        KeychainWrapper.standard.set(clientID, forKey: "CLIENT_ID")
    }

    func setClientSecret(_ clientSecret:String) {
        KeychainWrapper.standard.set(clientSecret, forKey: "CLIENT_SECRET")
    }

    func DeleteKeyInSession(withKey key:String)
    {
        KeychainWrapper.standard.removeObject(forKey: key)
    }

    func deleteKeys()
    {
        DeleteKeyInSession(withKey: "ACCESS_TOKEN")
        DeleteKeyInSession(withKey: "REFRESHTOKEN")
        DeleteKeyInSession(withKey: "TOKEN_EXPIRED_TIME")
    }




//    func GetTokenExpiredTime(_ expiredTime:String) {
//
//        guard let Token_Expired_Time = KeychainWrapper.standard.string(forKey: "TOKEN_EXPIRED_TIME") else {
//            print("no expired time found/nil")
//            return ""
//        }
//        return Token_Expired_Time
//    }
//
//    func GetAccessToken() {
//        guard let accessToken = KeychainWrapper.standard.string(forKey: "ACCESS_TOKEN") else {
//            print("no token found/nil")
//            return ""
//        }
//        return accessToken
//    }
//
//    func GetRefreshAccessToken() {
//        guard let refreshToken = KeychainWrapper.standard.string(forKey: "REFRESH_TOKEN") else {
//            print("no refresh token found/nil")
//            return ""
//        }
//        return refreshToken
//    }
//
//    func GetCLientID() {
//        guard let clientID = KeychainWrapper.standard.string(forKey: "CLIENT_ID") else {
//            print("no client id found/nil")
//            return ""
//        }
//        return clientID
//    }
//
//    func GetClientSecret(_ GetClientSecret:String) {
//        guard let client_Secret = KeychainWrapper.standard.string(forKey: "CLIENT_SECRET") else {
//            print("no client secret found/nil")
//            return ""
//        }
//        return client_Secret
//    }


}


