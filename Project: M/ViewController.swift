//
//  ViewController.swift
//  Project: M
//
//  Created by Murillo Nicacio de Maraes on 6/18/14.
//  Copyright (c) 2014 Super Unreasonable. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView()
    {
        self.view = TaskMainView(viewModel: TaskViewModel(model: toySet()))
    }
    
}