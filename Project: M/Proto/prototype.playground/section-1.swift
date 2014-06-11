// Playground - noun: a place where people can play

import UIKit

//Model Object Definitions
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
class ViewManager: NSObject {

}

class TaskListView: UICollectionView {
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = UIColor.whiteColor()
        
        layout.itemSize = CGSizeMake(320, 40)
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
    }
}

var handle = Array<UIView>()

class TaskView: UICollectionViewCell {
    init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    func configure(name: String, details: String) {
        let nameLabel = UILabel(frame: self.contentView.frame)
        nameLabel.text = name
        self.contentView.addSubview(nameLabel)
    }
}

//TODO: Create a ViewModel for properly displaying Cells.

//View Manager
extension ViewManager: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return master.list.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("task", forIndexPath: indexPath) as TaskView
        
        let item = master.list[indexPath.item]
        
        cell.configure(item.name, details: item.details)
        
        return cell
    }
}

let masterView = TaskListView(frame: CGRectMake(0, 0, 350, 500))
masterView.registerClass(TaskView.self, forCellWithReuseIdentifier: "task")
let ds = ViewManager()
masterView.dataSource = ds

masterView
