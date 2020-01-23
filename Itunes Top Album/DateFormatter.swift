//
//  DateFormatter.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/22/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation


extension String{
    
    var formattedReleaseDateStringFromYYYYMMDD : Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self){
            if date.timeIntervalSinceNow < 0 {
                return "Released on " + self
            }else{
                return "Expected on " + self
            }
        }
        return ""
    }
    
}
