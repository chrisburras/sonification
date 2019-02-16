//
//  GameViewController.swift
//  sonification
//
//  Created by Amit Enand on 2/16/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AudioKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
                
            }
           
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    func startSound(){
        let oscillator = AKOscillator()
        AudioKit.output = oscillator
        do{
            try AudioKit.start()
        } catch{
            print("fail")
        }
        oscillator.start()
        sleep(3)
        oscillator.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startSound()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
