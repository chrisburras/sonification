//
//  GameScene.swift
//  sonification
//
//  Created by Amit Enand on 2/16/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    //private var lines = [Line]()
    private var engine = AudioEngine()
    private var shape = SKShapeNode()
    private var shape2 = SKShapeNode()
    private var fileNameInUse = ""
    private var nextButton = SKShapeNode()
    private var tutorial = 0
    private var alien = "alien.wav"
    private var bell = "bell1.wav"
    private var piano = "yeezy.wav"
    private var buzz = "buzz1.wav"
    private var electric = "electric.wav"
    private var shape1Noise = ""
    private var shape2Noise = ""
    
    override func didMove(to view: SKView) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Double(screenSize.width)
        let pathToDraw = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:(screenWidth - 200), height: 50), cornerRadius: 16).cgPath
        let pathToDraw2 = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:(screenWidth - 200), height: 50), cornerRadius: 16).cgPath
        shape.path = pathToDraw
        shape2.path = pathToDraw2
        shape.fillColor = UIColor.red
        shape2.fillColor = UIColor.blue
        shape.lineWidth = 1
        shape2.lineWidth = 1
        shape.position = CGPoint(x: 100, y: 300)
        shape2.position = CGPoint(x: 100, y: 50)
        shape2.isHidden = true
        shape1Noise = alien
        shape2Noise = bell
        addChild(shape)
        addChild(shape2)
        //addChild(nextButton)

    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func nextTutorial() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = Double(screenSize.height)
        tutorial = tutorial + 1
        if tutorial == 1{
            //2 horizontals
            shape2.isHidden = false
            shape2.position = CGPoint(x: 100, y: 600)
        }else if tutorial == 2{
            //1 diagonal
            shape1Noise = piano
            shape2.isHidden = true
            shape.position = CGPoint(x: 100, y: 50)
            shape.zRotation = CGFloat(deg2rad(30))
        }else if tutorial == 3{
            //2 diagonal
            shape2Noise = buzz
            shape.position = CGPoint(x: 100, y: 150)
            shape2.position = CGPoint(x: 150, y: 50)
            shape2.zRotation = CGFloat(deg2rad(15))
            shape2.isHidden = false
        }else if tutorial == 4{
            //1 vertical
            shape1Noise = electric
            shape2.isHidden = true
            let pathToDraw = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:(screenHeight - 200), height: 50), cornerRadius: 16).cgPath
            shape.path = pathToDraw
            shape.position = CGPoint(x: 400, y: 50)
            shape.zRotation = CGFloat(deg2rad(90))
        }else {
            //1 vertical 1 diagonal
            shape2Noise = alien
            shape.position = CGPoint(x: 400, y: 50)
            let pathToDraw = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:(screenHeight - 200), height: 50), cornerRadius: 16).cgPath
            shape2.path = pathToDraw
            shape2.position = CGPoint(x: 800, y: 50)
            shape2.zRotation = CGFloat(deg2rad(60))
            shape2.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if shape.contains(position) {
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
            } else if shape2.contains(position) && !shape2.isHidden {
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
            }
//            else if nextButton.contains(position){
//                nextTutorial()
//            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        engine.stopSound()
    }
    
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if shape.contains(position) {
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
            } else if shape2.contains(position) && !shape2.isHidden {
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
            } else {
                engine.stopSound()
            }
        }
    }
}
