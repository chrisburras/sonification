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
    private var yourline = SKShapeNode()
    private var pathToDraw = CGMutablePath()



    override func didMove(to view: SKView) {

        //initSound()
//        let bkgSize = CGSize(width: view.frame.maxX, height: view.frame.maxY)
//        let bkg = SKShapeNode(rectOf: bkgSize)
//        bkg.fillColor = .blue
//        bkg.isUserInteractionEnabled = true
//        bkg.zPosition -= 1
//        bkg.position = CGPoint(x: (view.frame.maxX / 2), y: (view.frame.maxY / 2))
//        addChild(bkg)
        let line1 = Line(start: CGPoint(x:(100.0), y:(100.0)), end: CGPoint(x:(view.frame.maxX-100.0), y:(view.frame.maxY-100.0)),color: SKColor.red )
        lines.append(line1)
        pathToDraw.move(to: line1.start)
        pathToDraw.addLine(to: line1.end)
        yourline.path = pathToDraw
        yourline.strokeColor = line1.color
        yourline.lineWidth = 50.0
        //yourline.isUserInteractionEnabled = true
        addChild(yourline)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if yourline.calculateAccumulatedFrame().contains(position){
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        engine.stopSound()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if yourline.calculateAccumulatedFrame().contains(position){
                engine.changePitch(y: Double(position.y))
                engine.changeSpeed(x: Double(position.x))
                engine.startSound()

            }else{
                engine.stopSound()
            }
        }
    }
}
