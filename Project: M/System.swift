//
//  System.swift
//  Project: M
//
//  Created by Murillo Nicacio de Maraes on 6/19/14.
//  Copyright (c) 2014 Super Unreasonable. All rights reserved.
//

import UIKit
import QuartzCore

protocol Spec {
    func apply(To view: UIView)
}

class UIViewMetrics: NSObject {
    var backgroundColor: UIColor = UIColor.clearColor()
    
    var cornerRadius: CGFloat = 0.0
    
    var borderWidth: CGFloat = 0.0
    var borderColor: UIColor = UIColor.blackColor()
    
    var shadowOpacity: CFloat = 0.0
    var shadowRadius: CGFloat = 3.0
    var shadowOffset: CGSize = CGSize(width: 0.0, height: -3.0)
    var shadowColor: UIColor = UIColor.blackColor()
}

extension UIViewMetrics: Spec {
    func apply(To view: UIView) {
        let vpaths = ["backgroundColor"]
        let lpaths = ["cornerRadius", "borderWidth",
            "shadowOpacity", "shadowRadius", "shadowOffset"]
        
        for path in vpaths {
            bind(path, toView: view)
        }
        
        for path in lpaths {
            bind(path, toLayer: view.layer)
        }
        
        view.layer.borderColor = self.borderColor.CGColor
        view.layer.shadowColor = self.shadowColor.CGColor
    }
    
    func bind(keyPath: String, toView view: UIView) {
        self.rac_valuesForKeyPath(keyPath, observer: self).setKeyPath(keyPath, onObject: view)
    }
    
    func bind(keyPath: String, toLayer layer: CALayer) {
        self.rac_valuesForKeyPath(keyPath, observer: self).setKeyPath(keyPath, onObject: layer)
        
    }
}

class UIScrollViewMetrics: UIViewMetrics {
    var scrollEnabled: Bool = true
}

extension UIScrollViewMetrics: Spec {
    override func apply(To view: UIView) {
        super.apply(To: view)
        
        if let scrollView = view as? UIScrollView {
            let paths = ["scrollEnabled"]
            
            for path in paths {
                bind(path, toScrollView: scrollView)
            }
        }
    }
    
    func bind(keyPath: String, toScrollView scrollView: UIScrollView) {
        self.rac_valuesForKeyPath(keyPath, observer: self).setKeyPath(keyPath, onObject: scrollView)
    }
}

class UILabelMetrics: UIViewMetrics {
    var font: UIFont = UIFont.systemFontOfSize(17.0)
    var textColor: UIColor = UIColor.blackColor()
    var textAlignment: NSTextAlignment = NSTextAlignment.Left
    var numberOfLines: Int = 1
}

extension UILabelMetrics: Spec {
    override func apply(To view: UIView) {
        
        super.apply(To: view)
        
        if let label = view as? UILabel {
            let paths = ["font", "textColor", "textAlignment", "numberOfLines"]
            
            for path in paths {
                bind(path, toLabel: label)
            }
        }
    }
    
    func bind(keyPath: String, toLabel label: UILabel) {
        self.rac_valuesForKeyPath(keyPath, observer: self).setKeyPath(keyPath, onObject: label)
    }
}