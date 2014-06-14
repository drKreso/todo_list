//
//  MyTableViewCell.swift
//  testing123
//
//  Created by Kresimir Bojcic on 14/06/14.
//  Copyright (c) 2014 Kresimir Bojcic. All rights reserved.
//

import Foundation
import UIKit

protocol MyTableViewCellDelegate {
    func toDoItemDeleted(todoItem: ToDoItem, cell: MyTableViewCell)
}

class MyTableViewCell: UITableViewCell {
    
    let medColor: UIColor = UIColor(red: 0.973, green: 0.388, blue: 0.173, alpha: 1)
    var originalCenter: CGPoint = CGPoint()
    var deleteOnDragRelease:Bool = false
    var delegate:MyTableViewCellDelegate?
    var toDoItem:ToDoItem?
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        
        self.textColor = UIColor.whiteColor()
        self.backgroundColor = medColor
        self.selectionStyle = UITableViewCellSelectionStyle.None
       

        var recognizer:UIGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePen:")
        recognizer.delegate = self;
        self.addGestureRecognizer(recognizer)
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
        var gr = gestureRecognizer as UIPanGestureRecognizer
        var translation = gr.translationInView(self)
        if (abs(translation.x) > abs(translation.y)){
            return true
        }
        else {
            return false
        }

    }

    func handlePen(recognizer:UIPanGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.Began {
            self.originalCenter = self.center
        }
        
        if recognizer.state == UIGestureRecognizerState.Changed {
            var translation = recognizer.translationInView(self)
            self.center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            self.deleteOnDragRelease = (self.frame.origin.x < -self.frame.size.width / 2) || (self.frame.origin.x > self.frame.size.width / 2)
        }
        
        if recognizer.state == UIGestureRecognizerState.Ended {
            
            var originalFrame = CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)
            if !self.deleteOnDragRelease {
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            } else {
                self.delegate!.toDoItemDeleted(self.toDoItem!, cell: self)
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}