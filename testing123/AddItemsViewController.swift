//
//  ViewController.swiftAddItemsViewController
//  testing123
//
//  Created by Kresimir Bojcic on 14/06/14.
//  Copyright (c) 2014 Kresimir Bojcic. All rights reserved.
//

import UIKit

@objc(AddItemsViewController) class AddItemsViewController: UIViewController{
    
    var toDoItems = ToDoItem[]()
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet var itemsTextView : UITextView
    @IBOutlet var doneButton : UIBarButtonItem
 
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
       
        if sender === doneButton{
            var items = itemsTextView.text.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
            for item in items{
                var trimmed = item.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                if trimmed != "" {
                    toDoItems.append(ToDoItem(text:trimmed))
                }
            }
        }

    }
}

