//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Ammar Ali on 2/24/21.
//

import Foundation

extension Date{
    
    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
