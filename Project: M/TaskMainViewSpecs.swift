//
//  TaskMainViewSpecs.swift
//  Project: M
//
//  Created by Murillo Nicacio de Maraes on 6/19/14.
//  Copyright (c) 2014 Super Unreasonable. All rights reserved.
//

import UIKit

struct TaskMainLayout: Spec {
    //General Metrics
    let topMargin: CGFloat = 20
    let leftMargin: CGFloat = 8
    let rightMargin: CGFloat = 8
    let bottomMargin: CGFloat = 8
    
    let padding: CGFloat = 2
    
    var horizontalMargin: CGFloat {
    get{
        return leftMargin + rightMargin
    }
    }
    
    //NameLabel Metrics
    let nameHeight: CGFloat = 40
    
    //DetailLabel Metrics
    var detailsTopMargin: CGFloat {
    get {
        return topMargin + nameHeight + padding
    }
    }
    
    let detailsHeight: CGFloat = 32
    
    //ControlView Metrics
    var controlTopMargin: CGFloat {
    get{
        return detailsTopMargin + detailsHeight + padding
    }
    }
    
    let controlHeight: CGFloat = 44
    
    //TableView Metrics
    var tableTopMargin: CGFloat {
    get{
        return controlTopMargin + controlHeight + padding
    }
    }
    var tableVerticalMargin: CGFloat {
    get {
        return tableTopMargin + bottomMargin
    }
    }
    
    func bindToFrame(signal: RACSignal, view: UIView, transform: (CGRect) -> CGRect) {
        signal.map {
            return NSValue(CGRect: transform($0.CGRectValue()))
            } .setKeyPath("frame", onObject: view)
    }
    
    func apply(To view: UIView) {
        if let taskView = view as? TaskMainView {
            let boundsSignal = taskView.layer.rac_valuesForKeyPath("bounds", observer: taskView)
            
            self.bindToFrame(boundsSignal, view: taskView.nameLabel!) {
                return CGRectMake(self.leftMargin, self.topMargin, $0.width - self.horizontalMargin, self.nameHeight)
            }
            
            self.bindToFrame(boundsSignal, view: taskView.detailLabel!) {
                return CGRectMake(self.leftMargin, self.detailsTopMargin, $0.width - self.horizontalMargin, self.detailsHeight)
            }
            
            self.bindToFrame(boundsSignal, view: taskView.controlView!) {
                return CGRectMake(0, self.controlTopMargin, $0.width, self.controlHeight)
            }
            
            self.bindToFrame(boundsSignal, view: taskView.listView!) {
                return CGRectMake(self.leftMargin, self.tableTopMargin, $0.width - self.horizontalMargin, $0.height - self.tableVerticalMargin)
            }
        }
    }
}