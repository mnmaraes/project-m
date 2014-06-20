//
//  TaskMainView.swift
//  Project: M
//
//  Created by Murillo Nicacio de Maraes on 6/19/14.
//  Copyright (c) 2014 Super Unreasonable. All rights reserved.
//

import UIKit

class TaskMainView: UIView {
    var viewModel: TaskViewModel {
    didSet{
        self.bindToViewModel()
    }
    }
    
    var tableViewManager: TaskTableViewManager
    var specs: Array<Spec>
    
    //Subviews
    weak var nameLabel: UILabel?
    weak var detailLabel: UILabel?
    weak var controlView: UIView?
    weak var listView: UITableView?
    
    init(viewModel: TaskViewModel) {
        self.viewModel = viewModel
        self.tableViewManager = TaskTableViewManager(viewModel: viewModel)
        self.specs = [TaskMainLayout()]
        super.init(frame: CGRectZero)
        
        self.backgroundColor = UIColor.whiteColor()
        
        createSubviews()
        bindToViewModel()
        applySpecs()
    }
    
    //Init Methods
    func createSubviews(){
        let nLabel = UILabel(), dLabel = UILabel(), cView = UIView(), lView = UITableView()
        self.nameLabel = nLabel; self.detailLabel = dLabel; self.controlView = cView; self.listView = lView
        
        self.addSubview(nLabel); self.addSubview(dLabel); self.addSubview(cView); self.addSubview(lView)
    }
    
    func bindToViewModel() {
        nameLabel!.text = viewModel.name
        detailLabel!.text = viewModel.details
        listView!.delegate = self //TOBE: TableViewManager
        listView!.dataSource = self //TOBE: TableViewManager
        listView!.reloadData()
    }
    
    func applySpecs () {
        for spec in specs {
            spec.apply(To: self)
        }
    }
}

//Debug Behavior: Temporary
extension TaskMainView: UITableViewDataSource {
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.list.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "")
        let item = self.viewModel.list[indexPath.row]
        
        cell.text = item.name
        cell.detailTextLabel.text = item.details
        
        return cell
    }
    
}

extension TaskMainView: UITableViewDelegate {
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.viewModel = self.viewModel.list[indexPath.row]
    }
}

//To Be Replaced by:
class TaskTableViewManager: NSObject {
    weak var viewModel: TaskViewModel?
    
    init(viewModel: TaskViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}
extension TaskTableViewManager: UITableViewDataSource {
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        return UITableViewCell()
    }
    
}

extension TaskTableViewManager: UITableViewDelegate {
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
}
