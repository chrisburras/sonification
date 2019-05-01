//
//  SandboxViewController.swift
//  sonification
//
//  Created by Amit Enand on 4/11/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AudioKit

class SandboxGameViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //if let view = self.view as! SKView? {
        // Load the SKScene from 'GameScene.sks'
        //skView = view
        if let scene = SKScene(fileNamed: "Sandbox") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .resizeFill
            
            // Present the scene
            skView.presentScene(scene)
            
        }
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped(sender:UITapGestureRecognizer){
        let location = sender.location(in: self.view)
        if let gameScene = skView.scene as? Sandbox{
            let x = gameScene.tap(point: location)
        }
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
    @IBAction func undo(_ sender: UIButton) {
        if let gameScene = skView.scene as? Sandbox{
            gameScene.undo()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
