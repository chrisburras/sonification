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

class TutorialGameViewController: UIViewController {
    
    //var skView: SKView!
    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            //skView = view
            if let scene = SKScene(fileNamed: "TutorialGameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill

                // Present the scene
                skView.presentScene(scene)
                
            }
           
            skView.ignoresSiblingOrder = true
            
            skView.showsFPS = true
            skView.showsNodeCount = true
        //}
    }
    
    @IBAction func homeButton(_ sender: UIButton) {
        do{
            try AudioKit.stop()
        }catch{
            print("fail")
        }
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if let gameScene = skView.scene as? TutorialGameScene{
            let x = gameScene.nextTutorial()
            if x{
                sender.isEnabled = false
                sender.tintColor = UIColor.gray
            }
        }
    }
    //    override func viewDidAppear(_ animated: Bool) {
//        startSound()
//    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
