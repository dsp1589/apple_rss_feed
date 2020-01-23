//
//  RoundedImageView.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/23/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    func createRoundedImageView(with cornerRadius : CGFloat, borderColor : CGColor = UIColor.clear.cgColor,  borderWidth : CGFloat = 0.0,  contentMode : UIView.ContentMode = .scaleAspectFit){
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
}
