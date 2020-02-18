//
//  Response.swift
//  SnoozerLibrary
//
//  Created by admin on 16/01/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

public typealias JSONCompletionHandler = ([String : Any] , Result)->()
protocol ResponseHandler {

    static func handle(result: Result, data: Any? , completionHandler: JSONCompletionHandler )
    static func handleSuccessfulAPICall(for json: Any, completionHandler: JSONCompletionHandler)
    static func handleFailedAPICall(for error: Error, completionHandler: JSONCompletionHandler)
}

extension ResponseHandler {

    static func handle(result: Result , data: Any , completionHandler: JSONCompletionHandler) {
        switch result {

        case .success:
           if let json = data as? [String : Any]{
        self.handleSuccessfulAPICall(for: json, completionHandler: completionHandler)}

        case .failure:
             let error = NetworkingError.badJSON
            self.handleFailedAPICall(for: error, completionHandler: completionHandler)
    }
}

    static func handleSuccessfulAPICall(for json: Any, completionHandler: JSONCompletionHandler) {
        guard let json = json as? [String : Any] else {
            let error = NetworkingError.badJSON
            handleFailedAPICall(for: error, completionHandler: completionHandler)
            return
        }
        completionHandler(json ,.success)
    }

    static func handleFailedAPICall(for error: Error, completionHandler: JSONCompletionHandler) {
        completionHandler([:],Result.failure)
    }
}
