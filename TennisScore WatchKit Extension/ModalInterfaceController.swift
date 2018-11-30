//
//  ModalInterfaceController.swift
//  TennisScore WatchKit Extension
//
//  Created by AB on 11/20/18.
//  Copyright © 2018 AB. All rights reserved.
//

import WatchKit
import Foundation


class ModalInterfaceController: WKInterfaceController {

    @IBOutlet var group2: WKInterfaceGroup!
    @IBOutlet var group3: WKInterfaceGroup!
    @IBOutlet var group4: WKInterfaceGroup!
    @IBOutlet var group5: WKInterfaceGroup!
    
    @IBOutlet var set1Label1: WKInterfaceLabel!
    @IBOutlet var set1Label2: WKInterfaceLabel!
    @IBOutlet var set2Label1: WKInterfaceLabel!
    @IBOutlet var set2Label2: WKInterfaceLabel!
    @IBOutlet var set3Label1: WKInterfaceLabel!
    @IBOutlet var set3Label2: WKInterfaceLabel!
    @IBOutlet var set4Label1: WKInterfaceLabel!
    @IBOutlet var set4Label2: WKInterfaceLabel!
    @IBOutlet var set5Label1: WKInterfaceLabel!
    @IBOutlet var set5Label2: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let context = context {
            let sets = context as! [[Int]]
            
            for index in 0..<sets.count {
                switch(index) {
                case 0:
                    set1Label1.setText(String(sets[index][0]))
                    set1Label2.setText(String(sets[index][1]))
                case 1:
                    group2.setHidden(false)
                    set2Label1.setText(String(sets[index][0]))
                    set2Label2.setText(String(sets[index][1]))
                case 2:
                    group3.setHidden(false)
                    set3Label1.setText(String(sets[index][0]))
                    set3Label2.setText(String(sets[index][1]))
                case 3:
                    group4.setHidden(false)
                    set4Label1.setText(String(sets[index][0]))
                    set4Label2.setText(String(sets[index][1]))
                case 4:
                    group5.setHidden(false)
                    set5Label1.setText(String(sets[index][0]))
                    set5Label2.setText(String(sets[index][1]))
                default:
                    set1Label1.setText(String(sets[index][0]))
                    set1Label2.setText(String(sets[index][1]))
                }
            }
            
            
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func dismissModal() {
        dismiss()
    }
}
