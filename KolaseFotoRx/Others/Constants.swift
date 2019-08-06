//
//  Constants.swift
//  KolaseFotoRx
//
//  Created by Luthfi Fathur Rahman on 05/08/19.
//  Copyright © 2019 HOOQ. All rights reserved.
//

import Foundation
import UIKit

class Constant:NSObject {
    
    static let shared = Constant()
    
    let purpleColor = UIColor(red: 217/255, green: 21/255, blue: 141/255, alpha: 1.0)
    let redBtnClearColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)
    let disabledBtnColor = UIColor.lightGray
    
    let photoLimit = 4
    
    let imgPreviewBorderWidth: CGFloat = 2
}
