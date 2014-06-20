//
//  TaskViewModel.swift
//  Project: M
//
//  Created by Murillo Nicacio de Maraes on 6/19/14.
//  Copyright (c) 2014 Super Unreasonable. All rights reserved.
//

import Foundation

class TaskViewModel{
    var model: Task
    var list: Array<TaskViewModel>
    
    var isExpanded: Bool = false
    
    var name: String {
    get {
        return self.model.name
    }
    }
    
    var details: String {
    get {
        return self.model.details
    }
    }
    
    init(model: Task) {
        self.model = model
        self.list = model.list.map {
            return TaskViewModel(model: $0)
        }
    }
}