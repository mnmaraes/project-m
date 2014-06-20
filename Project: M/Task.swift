//
//  Data.swift
//  Project: M
//
//  Created by Murillo Nicacio de Maraes on 6/19/14.
//  Copyright (c) 2014 Super Unreasonable. All rights reserved.
//

import Foundation

class Task {
    var name: String = ""
    var details: String = ""
    var list: Array<Task> = []
    
    init(name: String, details: String, list: Array<Task>)
    {
        self.name = name
        self.details = details
        self.list = list
    }
    
    convenience init(name: String, details: String)
    {
        self.init(name: name, details: details, list: Array<Task>())
    }
}

func toySet() -> Task{
    let profit = Task(name: "Profit", details: "All Done")
    
    let reading = Task(name: "Reading", details: "I have a long list of books to read")
    let catcher = Task(name: "The Catcher in the Rye", details: "Who is Holden Caulfield and Why should I care?")
    
    reading.list.append(catcher)
    
    let writing = Task(name: "Writing", details: "Writing things is fun")
    
    let bestseller = Task(name: "Write A Best-Seller", details: "Making money is also fun")
    let plot = Task(name: "Come up with the plot", details: "What do I want to talk about?")
    bestseller.list.append(plot)
    
    let nyt = Task(name: "Write for the New York Times", details: "People need to hear this")
    
    writing.list.extend([bestseller, nyt])
    
    let master = Task(name: "Master List", details: "One List to rule them all")
    
    master.list.extend([writing, reading, profit])
    
    return master
}