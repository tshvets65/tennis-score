//
//  SettingsInterfaceController.swift
//  TennisScore WatchKit Extension
//
//  Created by AB on 11/18/18.
//  Copyright © 2018 AB. All rights reserved.
//

import WatchKit
import Foundation


class SettingsInterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var noAddSwitch: WKInterfaceSwitch!
    
    let setTypes = ["1 Set","3 Sets","5 Sets"]
    let sets = [1,3,5]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        var pickerItems:[WKPickerItem] = []
        for index in 0..<setTypes.count {
            let pickerItem = WKPickerItem()
            pickerItem.title = String(sets[index])
            pickerItem.caption = setTypes[index]
            pickerItems += [pickerItem]
        }
        picker.setItems(pickerItems)
        
        let defaults = UserDefaults.standard
        
        let noAdd = defaults.bool(forKey: InterfaceController.noAddKey)
        noAddSwitch?.setOn(noAdd)
        
        var numOfSets = defaults.integer(forKey: InterfaceController.numOfSetsKey)
        if numOfSets == 0 {
            numOfSets = 1
        }
        
        let selectedIndex = sets.index(of: numOfSets)
        picker.setSelectedItemIndex(selectedIndex ?? 0)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func changeNumOfSets(_ value: Int) {
        let defaults = UserDefaults.standard
        defaults.set(sets[value], forKey: InterfaceController.numOfSetsKey)
    }
    
    @IBAction func changeNoAdd(_ value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: InterfaceController.noAddKey)
    }
}
