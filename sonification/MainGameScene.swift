//
//  MainGameScene.swift
//  sonification
//
//  Created by Amit Enand on 4/11/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioKit
import AVFoundation

class MainGameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    //private var lines = [Line]()
    private var engine = AudioEngine()
    private var fileNameInUse = ""
    private var alien = "alien.wav"
    private var bell = "bell1.wav"
    private var piano = "yeezy.wav"
    private var buzz = "buzz1.wav"
    private var electric = "electric.wav"
    private var shape1Noise = ""
    private var shape2Noise = ""
    private var shape3Noise = ""
    private var levelNum = 1
    private var images = [UIImage()]
    private var imagesInUse = [UIImageView()]
    private var line1 = SKShapeNode()
    private var line2 = SKShapeNode()
    private var line3 = SKShapeNode()
    private var points = [CGPoint()]
    private var latestImageTapped = ""
    private var highestLevelAvail = 2
    private var view1 = SKView()
    private var levelComplete = true
    private var lastUsed = SKShapeNode()

    
    override func didMove(to view: SKView) {
        view1 = view
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Double(screenSize.width)
        let screenHeight = Double(screenSize.height)
        let pathToDraw = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:(screenWidth - 350), height: 50), cornerRadius: 16).cgPath
        line2.path = pathToDraw
        line3.path = pathToDraw
        line1.path = pathToDraw
        line1.isAccessibilityElement = true
        line1.accessibilityLabel = ""
        line2.isAccessibilityElement = true
        line2.accessibilityLabel = ""
        line3.isAccessibilityElement = true
        line3.accessibilityLabel = ""
        line1.accessibilityTraits = [UIAccessibilityTraits.allowsDirectInteraction]
        line2.accessibilityTraits = [UIAccessibilityTraits.allowsDirectInteraction]
        line3.accessibilityTraits = [UIAccessibilityTraits.allowsDirectInteraction]
        line2.isHidden = true
        line3.isHidden = true
        line2.fillColor = UIColor.green
        line3.fillColor = UIColor.purple
        line1.fillColor = UIColor.orange
        line1.lineWidth = 1
        line2.lineWidth = 1
        line3.lineWidth = 1
        line1.position = CGPoint(x: 175, y: (screenHeight / 2) - 25)
        shape1Noise = alien
        shape2Noise = electric
        shape3Noise = piano
        let appleImage = UIImage(named: "apple.png")
        let appleImageView = UIImageView(image: appleImage!)
        appleImageView.frame = CGRect(x: CGFloat(screenWidth - 175), y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        appleImageView.isAccessibilityElement = true
        appleImageView.accessibilityLabel = "Apple"
        let appleLetter = UIImage(named: "a.png")
        let appleLetterView = UIImageView(image: appleLetter!)
        appleLetterView.isAccessibilityElement = true
        appleLetterView.accessibilityLabel = "a"
        appleLetterView.frame = CGRect(x: 25, y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        appleImageView.restorationIdentifier = "apple"
        appleLetterView.restorationIdentifier = "a"
        imagesInUse.append(appleImageView)
        imagesInUse.append(appleLetterView)
        view1.addSubview(appleLetterView)
        view1.addSubview(appleImageView)
        addChild(line2)
        addChild(line3)
        addChild(line1)
        line1.accessibilityTraits = [UIAccessibilityTraits.allowsDirectInteraction]
        line2.accessibilityTraits = [UIAccessibilityTraits.allowsDirectInteraction]
        line3.accessibilityTraits = [UIAccessibilityTraits.allowsDirectInteraction]
        points.removeAll()
        
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    
    func nextLevel() -> Int{
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Double(screenSize.width)
        let screenHeight = Double(screenSize.height)
        if levelNum > 6 {
            return 6
        }else{
            if highestLevelAvail > levelNum{
                levelNum = levelNum + 1
            }
        }
        if levelNum == 1{
            levelOne()
        }
        else if levelNum == 2 && highestLevelAvail >= levelNum{
            levelTwo()
        }else if levelNum == 3  && highestLevelAvail >= levelNum{
            levelThree()
        }else if levelNum == 4  && highestLevelAvail >= levelNum{
            levelFour()
        }else if levelNum == 5  && highestLevelAvail >= levelNum{
            levelFive()
        }else if levelNum == 6  && highestLevelAvail >= levelNum{
            levelSix()
        }
        return highestLevelAvail
    }
    
    func prevLevel(){
        print(levelNum)
        if levelNum >= 0{
            levelNum = levelNum - 2
            nextLevel()
        }
    }
    
    func tap(point: CGPoint) -> Bool{
        points.append(point)
        for i in imagesInUse{
            if i.frame.contains(point){
                let utterance = AVSpeechUtterance(string: i.restorationIdentifier ?? "error")
                utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                utterance.rate = 0.5
                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
            }
        }
        if points.count == 2{
            let pointa = points.popLast()!
            let pointb = points.popLast()!
            for i in imagesInUse{
                if i.frame.contains(pointa) || i.frame.contains(pointb){
                    if latestImageTapped.prefix(1) == i.restorationIdentifier?.prefix(1) && (latestImageTapped != i.restorationIdentifier){
                        highestLevelAvail = highestLevelAvail + 2
                        if latestImageTapped.prefix(1) == "a"{
                            if levelNum >= 5{
                                if line3.isHidden {
                                    line3.isHidden = false
                                    latestImageTapped = ""
                                }
                            }else{
                                if line1.isHidden{
                                    line1.isHidden = false
                                    latestImageTapped = ""
                                }
                            }
                        }else if latestImageTapped.prefix(1) == "b"{
                            if line2.isHidden{
                                line2.isHidden = false
                                latestImageTapped = ""
                            }
                        }else if latestImageTapped.prefix(1) == "c"{
                            if levelNum >= 5{
                                if line1.isHidden{
                                    line1.isHidden = false
                                    latestImageTapped = ""
                                }
                            }else{
                                if line3.isHidden{
                                    line3.isHidden = false
                                    latestImageTapped = ""
                                }
                            }
                        }
                    }else{
                        latestImageTapped = i.restorationIdentifier!
                    }
                }
            }
        }
        return checkCompletion()
    }
    
    func checkCompletion() -> Bool{
        if levelNum == 2{
            return !line1.isHidden
        }else if levelNum == 4{
            return !line1.isHidden && !line2.isHidden
        }else if levelNum == 6{
            return !line1.isHidden && !line2.isHidden && !line3.isHidden
        }else{
            return true
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if lastUsed.contains(position) && !lastUsed.isHidden{
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()
            }else{
            if line1.contains(position) && !line1.isHidden{
                lastUsed = line1
                if (fileNameInUse == shape1Noise){
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                } else {
                    fileNameInUse = shape1Noise
                    engine.changeSound(fileName: fileNameInUse)
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                }
            } else if line2.contains(position) && !line2.isHidden {
                lastUsed = line2
                if (fileNameInUse == shape2Noise){
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                } else {
                    fileNameInUse = shape2Noise
                    engine.changeSound(fileName: fileNameInUse)
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                }
            }else if line3.contains(position) && !line3.isHidden {
                lastUsed = line3
                if (fileNameInUse == shape3Noise){
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                } else {
                    fileNameInUse = shape3Noise
                    engine.changeSound(fileName: fileNameInUse)
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                }
            }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        engine.stopSound()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if lastUsed.contains(position) && !lastUsed.isHidden{
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()
            }else{
            if line1.contains(position) && !line1.isHidden{
                lastUsed = line1
                if (fileNameInUse == shape1Noise){
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                } else {
                    fileNameInUse = shape1Noise
                    engine.changeSound(fileName: fileNameInUse)
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                }
            } else if line2.contains(position) && !line2.isHidden {
                lastUsed = line2
                if (fileNameInUse == shape2Noise){
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                } else {
                    fileNameInUse = shape2Noise
                    engine.changeSound(fileName: fileNameInUse)
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                }
            } else if line3.contains(position) && !line3.isHidden {
                lastUsed = line3
                if (fileNameInUse == shape3Noise){
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                } else {
                    fileNameInUse = shape3Noise
                    engine.changeSound(fileName: fileNameInUse)
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                }
            }
            else {
                engine.stopSound()
            }
            }
        }
    }

    func levelOne(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Double(screenSize.width)
        let screenHeight = Double(screenSize.height)
        print("level one")
        //A to Apple
        //line 1 is displayed
        points.removeAll()
        for i in imagesInUse{
            i.removeFromSuperview()
        }
        imagesInUse.removeAll()
        line1.position = CGPoint(x: 175, y: (screenHeight / 2) - 25)
        line1.isHidden = false
        line1.zRotation = 0
        let appleImage = UIImage(named: "apple.png")
        let appleImageView = UIImageView(image: appleImage!)
        appleImageView.frame = CGRect(x: CGFloat(screenWidth - 175), y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        appleImageView.isAccessibilityElement = true
        appleImageView.accessibilityLabel = "Apple"
        let appleLetter = UIImage(named: "a.png")
        let appleLetterView = UIImageView(image: appleLetter!)
        appleLetterView.isAccessibilityElement = true
        appleLetterView.accessibilityLabel = "a"
        appleLetterView.frame = CGRect(x: 25, y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        appleImageView.restorationIdentifier = "apple"
        appleLetterView.restorationIdentifier = "a"
        imagesInUse.append(appleImageView)
        imagesInUse.append(appleLetterView)
        view1.addSubview(appleLetterView)
        view1.addSubview(appleImageView)
        line2.isHidden = true
        line3.isHidden = true
    }
    func levelTwo(){
        //a to apple
        //line 1 is hidden
        levelOne()
        line1.isHidden = true
        line2.isHidden = true
        line3.isHidden = true
    }
    func levelThree(){
        //level 3
        //a to apple and b to bumble bee
        //line 1 and 2 are displayed
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Double(screenSize.width)
        let screenHeight = Double(screenSize.height)
        print("level three")
        points.removeAll()
        line1.position = CGPoint(x: 175, y: (screenHeight / 4))
        for i in imagesInUse{
            i.removeFromSuperview()
        }
        line1.zRotation = 0
        line2.zRotation = 0
        imagesInUse.removeAll()
        line1.position = CGPoint(x: 175, y: (screenHeight / 4))
        let appleImage = UIImage(named: "apple.png")
        let appleImageView = UIImageView(image: appleImage!)
        appleImageView.frame = CGRect(x: CGFloat(screenWidth - 175), y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        appleImageView.isAccessibilityElement = true
        appleImageView.accessibilityLabel = "Apple"
        let appleLetter = UIImage(named: "a.png")
        let appleLetterView = UIImageView(image: appleLetter!)
        appleLetterView.isAccessibilityElement = true
        appleLetterView.accessibilityLabel = "a"
        appleLetterView.frame = CGRect(x: 25, y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        appleImageView.restorationIdentifier = "apple"
        appleLetterView.restorationIdentifier = "a"
        imagesInUse.append(appleImageView)
        imagesInUse.append(appleLetterView)
        view1.addSubview(appleLetterView)
        view1.addSubview(appleImageView)
        line2.position = CGPoint(x: 175, y: (screenHeight / 4) * 2)
        line2.isHidden = false
        line1.isHidden = false
        line3.isHidden = true
        let beeImage = UIImage(named: "bee.png")
        let beeImageView = UIImageView(image: beeImage)
        beeImageView.frame = CGRect(x: CGFloat(screenWidth - 175), y: CGFloat(screenHeight - Double(line2.position.y + 100)), width: 150, height: 150)
        beeImageView.isAccessibilityElement = true
        beeImageView.accessibilityLabel = "Bumble Bee"
        let beeLetter = UIImage(named: "b.png")
        let beeLetterView = UIImageView(image: beeLetter)
        beeLetterView.frame = CGRect(x: 25, y: CGFloat(screenHeight - Double(line2.position.y + 100)), width: 150, height: 150)
        beeLetterView.isAccessibilityElement = true
        beeLetterView.accessibilityLabel = "b"
        beeImageView.restorationIdentifier = "bumble bee"
        beeLetterView.restorationIdentifier = "b"
        imagesInUse.append(beeLetterView)
        imagesInUse.append(beeImageView)
        view1.addSubview(beeLetterView)
        view1.addSubview(beeImageView)
    }
    
    func levelFour(){
        //level four
        //line 1 and 2 are hidden
        levelThree()
        line1.isHidden = true
        line2.isHidden = true
        line3.isHidden = true
    }
    
    func levelFive(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Double(screenSize.width)
        let screenHeight = Double(screenSize.height)
        print("level five")
        points.removeAll()
        for i in imagesInUse{
            i.removeFromSuperview()
        }
        imagesInUse.removeAll()
        line3.position = CGPoint(x: 175, y: (screenHeight / 5) * 3)
        line3.isHidden = false
        let arctangent = atan((screenHeight / 5 * 2) / (screenWidth - 350)) * 180 / Double.pi
        let len = ((screenWidth - 350) * (screenWidth - 350) + (screenHeight / 5 * 2) * (screenHeight / 5 * 2)).squareRoot()
        let pathToDraw = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: len, height: 50), cornerRadius: 16).cgPath
        line3.path = pathToDraw
        line1.path = pathToDraw
        line3.zRotation = CGFloat(deg2rad(-arctangent))
        line2.zRotation = 0
        line2.position = CGPoint(x: 175, y: (screenHeight / 5) * 2)
        line2.isHidden = false
        line1.position = CGPoint(x: 175, y: (screenHeight / 5))
        line1.isHidden = false
        line1.zRotation = CGFloat(deg2rad(arctangent))
        let appleImage = UIImage(named: "apple.png")
        let appleImageView = UIImageView(image: appleImage!)
        appleImageView.frame = CGRect(x: CGFloat(screenWidth - 175), y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        appleImageView.isAccessibilityElement = true
        appleImageView.accessibilityLabel = "Apple"
        let appleLetter = UIImage(named: "a.png")
        let appleLetterView = UIImageView(image: appleLetter!)
        appleLetterView.isAccessibilityElement = true
        appleLetterView.accessibilityLabel = "a"
        appleLetterView.frame = CGRect(x: 25, y: CGFloat(screenHeight - Double(line3.position.y + 100)), width: 150, height: 150)
        appleImageView.restorationIdentifier = "apple"
        appleLetterView.restorationIdentifier = "a"
        imagesInUse.append(appleImageView)
        imagesInUse.append(appleLetterView)
        view1.addSubview(appleLetterView)
        view1.addSubview(appleImageView)
        let beeImage = UIImage(named: "bee.png")
        let beeImageView = UIImageView(image: beeImage)
        beeImageView.frame = CGRect(x: CGFloat(screenWidth - 175), y: CGFloat(screenHeight - Double(line2.position.y + 100)), width: 150, height: 150)
        beeImageView.isAccessibilityElement = true
        beeImageView.accessibilityLabel = "Bumble Bee"
        let beeLetter = UIImage(named: "b.png")
        let beeLetterView = UIImageView(image: beeLetter)
        beeLetterView.frame = CGRect(x: 25, y: CGFloat(screenHeight - Double(line2.position.y + 100)), width: 150, height: 150)
        beeLetterView.isAccessibilityElement = true
        beeLetterView.accessibilityLabel = "b"
        beeImageView.restorationIdentifier = "bee"
        beeLetterView.restorationIdentifier = "b"
        imagesInUse.append(beeLetterView)
        imagesInUse.append(beeImageView)
        view1.addSubview(beeLetterView)
        view1.addSubview(beeImageView)
        let carImage = UIImage(named: "car.png")
        let carImageView = UIImageView(image: carImage)
        carImageView.frame = CGRect(x: CGFloat(screenWidth - 175), y: CGFloat(screenHeight - Double(line3.position.y + 100)), width: 150, height: 150)
        carImageView.isAccessibilityElement = true
        carImageView.accessibilityLabel = "Car"
        let carLetter = UIImage(named: "c.png")
        let carLetterView = UIImageView(image: carLetter)
        carLetterView.frame = CGRect(x: 25, y: CGFloat(screenHeight - Double(line1.position.y + 100)), width: 150, height: 150)
        carLetterView.isAccessibilityElement = true
        carLetterView.accessibilityLabel = "c"
        carImageView.restorationIdentifier = "car"
        carLetterView.restorationIdentifier = "c"
        imagesInUse.append(carLetterView)
        imagesInUse.append(carImageView)
        view1.addSubview(carLetterView)
        view1.addSubview(carImageView)
    }
    func levelSix(){
        levelFive()
        line1.isHidden = true
        line2.isHidden = true
        line3.isHidden = true
    }
}
