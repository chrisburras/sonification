//
//  Sandbox.swift
//  sonification
//
//  Created by Amit Enand on 4/11/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioKit

class Sandbox: SKScene {
    //private var lines = [Line]()
    private var engine = AudioEngine()
    private var shapes = [SKShapeNode()]
    private var shapesInUse = [SKShapeNode()]
//    private var shape = SKShapeNode()
//    private var shape2 = SKShapeNode()
    private var nextButton = SKShapeNode()
    private var alien = "alien.wav"
    private var bell = "bell1.wav"
    private var piano = "yeezy.wav"
    private var buzz = "buzz1.wav"
    private var electric = "electric.wav"
    private var fileNameInUse = "alien.wav"
    private var points = [CGPoint()]
    private var lastUsed = 0
    private var box = SKShapeNode()
    private var colorPicked = "alien.wav"

    //alien, bell, piano, buzz, guitar
    
    
    override func didMove(to view: SKView) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = Double(screenSize.height)
        let screenWidth = Double(screenSize.width)
        for i in 1...5 {
            let shape = SKShapeNode()
            let pathToDraw = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 60, height: 120), cornerRadius: 0).cgPath
            shape.path = pathToDraw
            shape.isAccessibilityElement = true
            shape.accessibilityLabel = ""
            shape.lineWidth = 1
            if i == 1{
                shape.fillColor = UIColor.orange
                shape.position = CGPoint(x: (screenWidth / 2) - 230, y: 0)
            }else if i == 2{
                shape.fillColor = UIColor.blue
                shape.position = CGPoint(x: (screenWidth / 2) - 130, y: 0)
            }else if i == 3{
                shape.fillColor = UIColor.purple
                shape.position = CGPoint(x: (screenWidth / 2) - 30, y: 0)
            }else if i == 4{
                shape.fillColor = UIColor.red
                shape.position = CGPoint(x: (screenWidth / 2) + 70, y: 0)
            }else{
                shape.fillColor = UIColor.green
                shape.position = CGPoint(x: (screenWidth / 2) + 170, y: 0)
            }
            shapes.append(shape)
            addChild(shape)
        }
        box = SKShapeNode(rectOf: CGSize(width: screenWidth, height: Double(screenSize.height - 260)))
        box.position = CGPoint(x: Double(screenWidth / 2), y: Double(screenSize.height / 2))
        box.isAccessibilityElement = true
        box.accessibilityLabel = ""
        box.alpha = 0.0
        addChild(box)
        
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    func undo(){
        lastUsed = 0
        if (shapesInUse.count >= 1){
            shapesInUse.popLast()?.removeFromParent()
        }
        print(shapesInUse.count)
    }
    
    func tap(point: CGPoint){
        engine.stopSound()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = Double(screenSize.height)
        print(point)
        points.append(point)
        if points.count == 3{
            print("build line")
            let b = points.popLast()
            let a = points.popLast()
            print(a!.y)
            print(b!.y)
            print(screenHeight)
            if !box.contains(a!) || !box.contains(b!){
                print("don't Build here")
                return
            }
            let xDist = Double(b!.x - a!.x)
            let yDist = Double(b!.y - a!.y)
            let len = (xDist * xDist + yDist * yDist).squareRoot()
            let shape = SKShapeNode()
            let pathToDraw = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: len, height: 60), cornerRadius: 16).cgPath
            let arctangent = atan(yDist / xDist) * 180 / Double.pi
            if b!.x > a!.x {
                let pos = CGPoint(x: a!.x, y: CGFloat(screenHeight - Double(a!.y) - 30))
                print(pos)
                shape.position = pos
            }else{
                let pos = CGPoint(x: b!.x, y: CGFloat(screenHeight - Double(b!.y) - 30))
                print(pos)
                shape.position = pos
            }
            shape.zRotation = CGFloat(deg2rad(-arctangent))
            shape.path = pathToDraw
            shape.isAccessibilityElement = true
            shape.accessibilityLabel = ""
            shape.lineWidth = 1
            if(colorPicked == alien){
                shape.fillColor = UIColor.orange
            }else if(colorPicked == bell){
                shape.fillColor = UIColor.blue
            }else if(colorPicked == buzz){
                shape.fillColor = UIColor.red
            }else if(colorPicked == electric){
                shape.fillColor = UIColor.green
            }else {
                shape.fillColor = UIColor.purple
            }
            shape.zPosition = 1
            print(shapesInUse.count)
            shapesInUse.append(shape)
            addChild(shape)
            UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: shape)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if shapesInUse.count >= 1 && shapesInUse[lastUsed].contains(position){
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()
            }else{
            for x in shapesInUse{
                if x.contains(position){
                    if (x.fillColor == UIColor.orange){
                        fileNameInUse = alien
                    }else if (x.fillColor == UIColor.purple){
                        fileNameInUse = piano
                    }else if (x.fillColor == UIColor.green){
                        fileNameInUse = electric
                    }else if (x.fillColor == UIColor.red){
                        fileNameInUse = buzz
                    }else{
                        fileNameInUse = bell
                    }
                    engine.changeSound(fileName: fileNameInUse)
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                    lastUsed = shapesInUse.index(of: x)!
                }
            }
            if shapes[1].contains(position) {
                colorPicked = alien
                if (fileNameInUse == alien){
                    engine.startSound()
                } else {
                    fileNameInUse = alien
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            } else if shapes[2].contains(position)  {
                colorPicked = bell
                if (fileNameInUse == bell){
                    engine.startSound()
                } else {
                    fileNameInUse = bell
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            }
            else if shapes[3].contains(position)  {
                colorPicked = piano
                if (fileNameInUse == piano){
                    engine.startSound()
                } else {
                    fileNameInUse = piano
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            }
            else if shapes[4].contains(position)  {
                colorPicked = buzz
                if (fileNameInUse == buzz){
                    engine.startSound()
                } else {
                    fileNameInUse = buzz
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            }
            else if shapes[5].contains(position)  {
                colorPicked = electric
                if (fileNameInUse == electric){
                    engine.startSound()
                } else {
                    fileNameInUse = electric
                    engine.changeSound(fileName: fileNameInUse)
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
            var hit = false
            let position = touch.location(in: self)
            if shapesInUse.count >= 1 && shapesInUse[lastUsed].contains(position){
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()
            }else{
            for x in shapesInUse{
                if x.contains(position){
                    if (x.fillColor == UIColor.orange){
                        fileNameInUse = alien
                    }else if (x.fillColor == UIColor.purple){
                        fileNameInUse = piano
                    }else if (x.fillColor == UIColor.green){
                        fileNameInUse = electric
                    }else if (x.fillColor == UIColor.red){
                        fileNameInUse = buzz
                    }else{
                        fileNameInUse = bell
                    }
                    hit = true
                    if (engine.fileInPlay() + ".wav") != fileNameInUse{
                        engine.changeSound(fileName: fileNameInUse)
                    }
                    engine.changePitch(y: Double(position.y))
                    engine.changeSpeed(x: Double(position.x))
                    engine.startSound()
                    lastUsed = shapesInUse.index(of: x)!
                    break
                }
            }
            if shapes[1].contains(position) {
                hit = true
                colorPicked = alien
                if (fileNameInUse == alien){
                    engine.startSound()
                } else {
                    fileNameInUse = alien
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            } else if shapes[2].contains(position)  {
                hit = true
                colorPicked = bell
                if (fileNameInUse == bell){
                    engine.startSound()
                } else {
                    fileNameInUse = bell
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            }
            else if shapes[3].contains(position)  {
                hit = true
                colorPicked = piano
                if (fileNameInUse == piano){
                    engine.startSound()
                } else {
                    fileNameInUse = piano
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            }
            else if shapes[4].contains(position)  {
                hit = true
                colorPicked = buzz
                if (fileNameInUse == buzz){
                    engine.startSound()
                } else {
                    fileNameInUse = buzz
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            }
            else if shapes[5].contains(position)  {
                hit = true
                colorPicked = electric
                if (fileNameInUse == electric){
                    engine.startSound()
                } else {
                    fileNameInUse = electric
                    engine.changeSound(fileName: fileNameInUse)
                    engine.startSound()
                }
            }
            if !hit{
                engine.stopSound()
            }
        }
        }
    }

}
