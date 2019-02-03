//
//  BaseView.swift
//  HOME
//
//  Created by TT Nguyen on 1/21/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

@IBDesignable class BaseView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffSetWidth: CGFloat = 0
    @IBInspectable var shadowOffSetHeight: CGFloat = 5
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOpacity: CGFloat = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInit()
    }
    
    fileprivate func didInit() {
        self.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.968627451, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 20
    }
    
}


