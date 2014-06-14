//
//  ViewController.swift
//  testing123
//
//  Created by Kresimir Bojcic on 14/06/14.
//  Copyright (c) 2014 Kresimir Bojcic. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyTableViewCellDelegate {
       
    @IBOutlet var tableViewOutlet : UITableView
    
    var toDoItems = ToDoItem[]()
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.toDoItems.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell:MyTableViewCell = self.tableViewOutlet.dequeueReusableCellWithIdentifier("cell") as MyTableViewCell
        
        cell.textLabel.text = self.toDoItems[indexPath.row].text
        cell.delegate = self
        cell.toDoItem = self.toDoItems[indexPath.row]
        return cell
    }
    
    func toDoItemDeleted(todoItem: ToDoItem, cell: MyTableViewCell) {
        var index = toDoItems.bridgeToObjectiveC().indexOfObject(todoItem)
        tableViewOutlet.beginUpdates()
        toDoItems.removeAtIndex(index)
        var indexPath = tableViewOutlet.indexPathForCell(cell)
        tableViewOutlet.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        tableViewOutlet.endUpdates()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewOutlet.registerClass(MyTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToMyViewController(segue:UIStoryboardSegue) {
        if segue.sourceViewController is AddItemsViewController {
            var controller = segue.sourceViewController as AddItemsViewController
            for item in controller.toDoItems{
                toDoItems.append(item)
            }
            tableViewOutlet.reloadData()
        }
    }
}

