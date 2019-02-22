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
    private var oscillator = AKOscillator()
    
    override func didMove(to view: SKView) {

        initSound()
        var yourline = SKShapeNode()
        var pathToDraw = CGMutablePath()
        var line1 = Line(start: CGPoint(x:(50.0), y:(view.frame.maxY / 2)), end: CGPoint(x:(view.frame.maxX-50.0), y:(view.frame.maxY / 2)),color: SKColor.red )
        lines.append(line1)
        print(lines.count)
        pathToDraw.move(to: line1.start)
        pathToDraw.addLine(to: line1.end)
        yourline.path = pathToDraw
        yourline.strokeColor = line1.color
        yourline.lineWidth = 50.0
        addChild(yourline)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
            print(lines[0].start)
            print(lines[0].end)
            if position.x > lines[0].start.x && position.x < lines[0].end.x{
                let y = position.y - lines[0].start.y
                if abs(y) <= 25{
                    startSound()
                }
        }
    }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endSound()
    }
    //    func touchMoved(toPoint pos : CGPoint) {
    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
    //            n.position = pos
    //            n.strokeColor = SKColor.blue
    //            self.addChild(n)
    //        }
    //    }
    func initSound(){
        AudioKit.output = oscillator
        do{
            try AudioKit.start()
        } catch{
            print("fail")
        }
    }
    
    func startSound(){
        oscillator.start()
    }
    
    func endSound(){
        oscillator.stop()
    }
        
//
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    
    
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
    
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }

//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//

//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//

//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
}
