//
//  Utilities.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation
import UIKit

class Utilities {
    
   class func heightForView(text:String, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        let font = UIFont(name: "Helvetica", size: 17.0)
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

}
