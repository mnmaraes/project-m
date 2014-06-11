// Playground - noun: a place where people can play

import UIKit

//Model Object Definitions
class Task {
    var name: String
    var details: String
    var list: Array<Task>
    
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
    
    func description()-> String
    {
        return name + "\n" + details + "\n" + list.reduce("") {
            acc, val in
            return acc + val.description()
            }.componentsSeparatedByString("\n").map {
                (str: String) -> String in
                return "\t" + str
            }.filter{
                str in
                return !str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).isEmpty
            }.reduce("") {
                acc, val in
                
                return acc + val + "\n"
        }
    }
}


//Define our toy set
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

master.description() //Make sure everything looks good

//View Definitions
class TaskListView: UICollectionView {
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = UIColor.blueColor()
    }
}

class TaskView: UICollectionViewCell {
    init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
}

//View Manager
class ViewManager: NSObject {
    
}

extension ViewManager: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return 0 //todo
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        return nil //todo
    }
}

let masterView = TaskListView(frame: CGRectMake(0, 0, 300, 300))

masterView