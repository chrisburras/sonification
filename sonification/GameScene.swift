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
    private var lines = [Line]()
    private var engine = AudioEngine()
    private var shape = SKShapeNode()
    private var pathToDraw = UIBezierPath(roundedRect: CGRect(x: 100, y: 50, width: 1000, height: 50), cornerRadius: 16).cgPath
    
    override func didMove(to view: SKView) {

        shape.path = pathToDraw
        shape.fillColor = UIColor.red
        shape.strokeColor = UIColor.red
        shape.lineWidth = 1
        shape.position = CGPoint(x: 200, y: 10)
        shape.zRotation = CGFloat(deg2rad(90))
        addChild(shape)

    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if shape.contains(position) {
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()
            }else{
                print("miss")
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        engine.stopSound()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if shape.contains(position) {
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()
            }else{
                engine.stopSound()
                print("miss")
            }
        }
    }
}
