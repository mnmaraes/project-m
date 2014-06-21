//
//  TaskMainViewSpecs.swift
//  Project: M
//
//  Created by Murillo Nicacio de Maraes on 6/19/14.
//  Copyright (c) 2014 Super Unreasonable. All rights reserved.
//

import UIKit

class TaskMainMetrics: Spec {
    let taskMetrics: UIViewMetrics
    let nameMetrics: UILabelMetrics
    let detailMetrics: UILabelMetrics
    let controlMetrics: UIViewMetrics
    let listMetrics: UIScrollViewMetrics
    
    init() {
        taskMetrics = UIViewMetrics()
        taskMetrics.backgroundColor = UIColor.whiteColor()
        
        nameMetrics = UILabelMetrics()
        nameMetrics.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        nameMetrics.textAlignment = NSTextAlignment.Center
        
        detailMetrics = UILabelMetrics()
        detailMetrics.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        detailMetrics.numberOfLines = 0
        
        controlMetrics = UIViewMetrics()
        
        listMetrics = UIScrollViewMetrics()
        listMetrics.backgroundColor = UIColor.whiteColor()
        listMetrics.cornerRadius = 8.0
        listMetrics.borderWidth = 0.3
        listMetrics.scrollEnabled = false
    }
    
    func apply(To view: UIView)
    {
        if let taskView = view as? TaskMainView {
            taskMetrics.apply(To: taskView)
            nameMetrics.apply(To: taskView.nameLabel!)
            detailMetrics.apply(To: taskView.detailLabel!)
            controlMetrics.apply(To: taskView.controlView!)
            listMetrics.apply(To: taskView.listView!)
        }
    }
}

class TaskMainLayout: Spec {
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
    
    //There must a better/more functional way of doing this.
    func bindToFrame(signal: RACSignal, view: UIView, transform: (CGRect) -> CGRect) {
        signal.map {
            return NSValue(CGRect: transform($0.CGRectValue()))
            } .setKeyPath("frame", onObject: view)
    }
    
    func apply(To view: UIView) {
        if let taskView = view as? TaskMainView {
            let boundsSignal = taskView.layer.rac_valuesForKeyPath("bounds", observer: taskView)
            
            weak var w_self = self
            
            self.bindToFrame(boundsSignal, view: taskView.nameLabel!) {
                return CGRectMake(w_self!.leftMargin, w_self!.topMargin, $0.width - w_self!.horizontalMargin, w_self!.nameHeight)
            }
            
            self.bindToFrame(boundsSignal, view: taskView.detailLabel!) {
                return CGRectMake(w_self!.leftMargin, w_self!.detailsTopMargin, $0.width - w_self!.horizontalMargin, w_self!.detailsHeight)
            }
            
            self.bindToFrame(boundsSignal, view: taskView.controlView!) {
                return CGRectMake(0, w_self!.controlTopMargin, $0.width, w_self!.controlHeight)
            }
            
            self.bindToFrame(boundsSignal, view: taskView.listView!) {
                return CGRectMake(w_self!.leftMargin, w_self!.tableTopMargin, $0.width, $0.height)
            }
        }
    }
}