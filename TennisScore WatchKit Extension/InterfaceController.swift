//
//  InterfaceController.swift
//  TennisScore WatchKit Extension
//
//  Created by AB on 11/17/18.
//  Copyright © 2018 AB. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    @IBOutlet var setGroup1: WKInterfaceGroup!
    @IBOutlet var setGroup5: WKInterfaceGroup!
    @IBOutlet var setGroup4: WKInterfaceGroup!
    @IBOutlet var setGroup3: WKInterfaceGroup!
    @IBOutlet var setGroup2: WKInterfaceGroup!
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
    @IBOutlet var gameLabel1: WKInterfaceLabel!
    @IBOutlet var gameLabel2: WKInterfaceLabel!
    
    static let noAddKey = "NoAdd"
    static let numOfSetsKey = "NumOfSets"
    static let background = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let activeBackground = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)

    var gameScore = [0,0]
    var sets = [[0,0],[0,0],[0,0],[0,0],[0,0]]
    var prevScore = [0,0]
    var prevSets = [[0,0],[0,0],[0,0],[0,0],[0,0]]
    var currentSet = 1
    var prevSet = 1
    var noAdd = false
    var numOfSets = 1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setBackgrounds()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let defaults = UserDefaults.standard

        noAdd = defaults.bool(forKey: InterfaceController.noAddKey)
        numOfSets = defaults.integer(forKey: InterfaceController.numOfSetsKey)
        if numOfSets == 0 {
            numOfSets = 1
        }
        
        showOrHideSets()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func refreshGameScore() {
        switch(gameScore[0]) {
        case 0:
            gameLabel1.setText("0")
        case 1:
            gameLabel1.setText("15")
        case 2:
            gameLabel1.setText("30")
        case 3:
            gameLabel1.setText("40")
            if gameScore[1]==4 {
                gameLabel1.setText("-")
            }
        case 4:
            gameLabel1.setText("AD")
        default:
            gameLabel1.setText("0")
        }
        switch(gameScore[1]) {
        case 0:
            gameLabel2.setText("0")
        case 1:
            gameLabel2.setText("15")
        case 2:
            gameLabel2.setText("30")
        case 3:
            gameLabel2.setText("40")
            if gameScore[0]==4 {
                gameLabel2.setText("-")
            }
        case 4:
            gameLabel2.setText("AD")
        default:
            gameLabel2.setText("0")
        }
    }
    
    func refreshSets() {
        set1Label1.setText(String(sets[0][0]))
        set1Label2.setText(String(sets[0][1]))
        set2Label1.setText(String(sets[1][0]))
        set2Label2.setText(String(sets[1][1]))
        set3Label1.setText(String(sets[2][0]))
        set3Label2.setText(String(sets[2][1]))
        set4Label1.setText(String(sets[3][0]))
        set4Label2.setText(String(sets[3][1]))
        set5Label1.setText(String(sets[4][0]))
        set5Label2.setText(String(sets[4][1]))
        setBackgrounds()
    }
    
    func setBackgrounds() {
        switch(currentSet) {
        case 1:
            setGroup1.setBackgroundColor(InterfaceController.activeBackground)
            setGroup2.setBackgroundColor(InterfaceController.background)
            setGroup3.setBackgroundColor(InterfaceController.background)
            setGroup4.setBackgroundColor(InterfaceController.background)
            setGroup5.setBackgroundColor(InterfaceController.background)
        case 2:
            setGroup1.setBackgroundColor(InterfaceController.background)
            setGroup2.setBackgroundColor(InterfaceController.activeBackground)
            setGroup3.setBackgroundColor(InterfaceController.background)
            setGroup4.setBackgroundColor(InterfaceController.background)
            setGroup5.setBackgroundColor(InterfaceController.background)
        case 3:
            setGroup1.setBackgroundColor(InterfaceController.background)
            setGroup2.setBackgroundColor(InterfaceController.background)
            setGroup3.setBackgroundColor(InterfaceController.activeBackground)
            setGroup4.setBackgroundColor(InterfaceController.background)
            setGroup5.setBackgroundColor(InterfaceController.background)
        case 4:
            setGroup1.setBackgroundColor(InterfaceController.background)
            setGroup2.setBackgroundColor(InterfaceController.background)
            setGroup3.setBackgroundColor(InterfaceController.background)
            setGroup4.setBackgroundColor(InterfaceController.activeBackground)
            setGroup5.setBackgroundColor(InterfaceController.background)
        case 5:
            setGroup1.setBackgroundColor(InterfaceController.background)
            setGroup2.setBackgroundColor(InterfaceController.background)
            setGroup3.setBackgroundColor(InterfaceController.background)
            setGroup4.setBackgroundColor(InterfaceController.background)
            setGroup5.setBackgroundColor(InterfaceController.activeBackground)
        default:
            setGroup1.setBackgroundColor(InterfaceController.activeBackground)
            setGroup2.setBackgroundColor(InterfaceController.background)
            setGroup3.setBackgroundColor(InterfaceController.background)
            setGroup4.setBackgroundColor(InterfaceController.background)
            setGroup5.setBackgroundColor(InterfaceController.background)
        }
    }
    
    @IBAction func addPoint1() {
        prevScore = gameScore
        prevSets = sets
        prevSet = currentSet
        
        switch gameScore[0] {
        case 3:
            if noAdd {
                winGame(player: 1)
            } else {
                switch gameScore[1] {
                case 3: //deuce
                    gameScore[0] = 4 //advantage
                case 4:
                    gameScore[1] = 3 //deuce
                default:
                    winGame(player: 1)
                }
            }
        case 4:
            winGame(player: 1)
        default:
            gameScore[0] += 1
        }
        refreshGameScore()
    }
    
    @IBAction func addPoint2() {
        prevScore = gameScore
        prevSets = sets
        prevSet = currentSet
        
        switch gameScore[1] {
        case 3:
            if noAdd {
                winGame(player: 2)
            } else {
                switch gameScore[0] {
                case 3: //deuce
                    gameScore[1] = 4 //advantage
                case 4:
                    gameScore[0] = 3 //deuce
                default:
                    winGame(player: 2)
                }
            }
        case 4:
            winGame(player: 2)
        default:
            gameScore[1] += 1
        }
        refreshGameScore()
    }
    
    func winGame(player: Int) {
        prevSets = sets
        prevSet = currentSet
        
        let wins = sets[currentSet-1][player-1] + 1
        let losses = sets[currentSet-1][2-player]
        
        sets[currentSet-1][player-1] = wins
        gameScore[0] = 0
        gameScore[1] = 0
        refreshSets()
        
        if numOfSets==1 { return }
        
        if wins>=6 && (wins-losses>1 || noAdd) {
            //set won, start next set
            currentSet += 1
            setBackgrounds()
            if currentSet > numOfSets {//finish match, reset scoreBoard
                var context = [[Int]]()
                for index in 0 ..< numOfSets {
                    context.append(sets[index])
                }
                resetGame()
                presentController(withName: "Modal", context: context)
            }
        }
    }
    
    func showOrHideSets() {
        switch(numOfSets) {
        case 1:
            setGroup2.setHidden(true)
            setGroup3.setHidden(true)
            setGroup4.setHidden(true)
            setGroup5.setHidden(true)
        case 3:
            setGroup2.setHidden(false)
            setGroup3.setHidden(false)
            setGroup4.setHidden(true)
            setGroup5.setHidden(true)
        case 5:
            setGroup2.setHidden(false)
            setGroup3.setHidden(false)
            setGroup4.setHidden(false)
            setGroup5.setHidden(false)
        default:
            numOfSets = 1
            setGroup2.setHidden(true)
            setGroup3.setHidden(true)
            setGroup4.setHidden(true)
            setGroup5.setHidden(true)
        }
    }
    
    func resetGame() {
        for index in 0..<gameScore.count {
            gameScore[index] = 0
        }
        for index in 0..<sets.count {
            sets[index][0]=0
            sets[index][1]=0
        }
        currentSet = 1
        refreshGameScore()
        refreshSets()
        showOrHideSets()
    }
    
    @IBAction func reset() {
        resetGame()
    }
    
    @IBAction func undo() {
        sets = prevSets
        gameScore = prevScore
        currentSet = prevSet
        refreshGameScore()
        refreshSets()
        showOrHideSets()
    }
}


