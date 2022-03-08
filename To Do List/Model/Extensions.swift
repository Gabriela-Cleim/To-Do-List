//
//  Extensions.swift
//  To Do List
//
//  Created by Gabriela Cleim on 08/03/22.
//

import Foundation
import UIKit

extension UIColor
{
    static let strongCiano = UIColor().colorFromHex(hex: "2ED2C8")
    func colorFromHex( hex  : String) -> UIColor
    {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#")
        {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6
        {
            return UIColor.black
        }
        
        var rgb: UInt32 = 0
        Scanner (string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                           green: CGFloat ((rgb & 0x00FF00) >> 8) / 255.0,
                           blue: CGFloat(rgb & 0x0000FF) / 255,
                           alpha: 1.0)
    }
}
