//
//  UIViewExtensions.swift
//  SnoozerLibrary
//
//  Created by admin on 14/01/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Foundation

//extension Date
//{
//    func currentTimeInSeconds() -> Int?
//    {
//        let date = Date()
//        let calendar = Calendar.current
//        let comp = calendar.dateComponents([.hour, .minute, .second], from: date)
//        let totalSeconds = comp.second
//        return totalSeconds
//    }
//
//
//}

extension Date {
  public  var currentSeconds:Int {
        return Int(self.timeIntervalSince1970)
    }
//    init(seconds:Int) {
//        self = Date(timeIntervalSince1970: TimeInterval(seconds))
//    }
}
