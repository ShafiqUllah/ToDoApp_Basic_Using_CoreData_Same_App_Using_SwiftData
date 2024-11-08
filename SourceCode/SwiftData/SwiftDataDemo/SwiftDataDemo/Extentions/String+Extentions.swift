//
//  String+Extentions.swift
//  SwiftDataDemo
//
//  Created by test on 11/7/24.
//

import Foundation

extension String{
    var isEmptyOrWhiteSpace:Bool{
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
