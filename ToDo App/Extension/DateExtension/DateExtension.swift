//
//  DateExtension.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 29/01/22.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
