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
    //private var pathToDraw : CGPath?
    
    override func didMove(to view: SKView) {
//        let line1 = Line(start: CGPoint(x:(100.0), y:(100.0)), end: CGPoint(x:(view.frame.maxX-100.0), y:(view.frame.maxY-100.0)),color: SKColor.red )
//        lines.append(line1)
//        pathToDraw.move(to: line1.start)
//        pathToDraw.addLine(to: line1.end)
//        pathToDraw.closeSubpath()
//        yourline.path = pathToDraw
//        yourline.strokeColor = line1.color
//        yourline.lineWidth = 50.0
        //yourline.fillColor = UIColor.blue

        //yourline.isUserInteractionEnabled = true
        //addChild(yourline)
//        var aRect = CGRect(x: 100, y: 100, width: 1000, height: 50);
//        aRect = getBoundingRectAfterRotation(rect: aRect, angle: 45);
//        pathToDraw = UIBezierPath(roundedRect: aRect, cornerRadius: 16).cgPath
        shape.path = pathToDraw
        shape.fillColor = UIColor.red
        shape.strokeColor = UIColor.red
        shape.lineWidth = 1
        shape.zRotation = 0.436332
        addChild(shape)

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
