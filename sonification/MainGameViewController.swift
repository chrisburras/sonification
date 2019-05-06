//
//  MainGameViewController.swift
//  sonification
//
//  Created by Amit Enand on 4/11/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioKit
import UIKit


class MainGameViewController: UIViewController {
    private var currentLevel = 1
    
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //if let view = self.view as! SKView? {
        // Load the SKScene from 'GameScene.sks'
        //skView = view
            if let scene = SKScene(fileNamed: "MainGameScene") {
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
        //}
    }
    @objc func doubleTapped(sender:UITapGestureRecognizer){
        let location = sender.location(in: self.view)
        if let gameScene = skView.scene as? MainGameScene{
            let x = gameScene.tap(point: location)
            if x{
                nextButton.isEnabled = true
                nextButton.backgroundColor = UIColor(red:0.96, green:0.13, blue:1.00, alpha:1.0)

            }
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
    
    @IBAction func nextButton(_ sender: UIButton) {
        if let gameScene = skView.scene as? MainGameScene{
            currentLevel = currentLevel + 1
            let x = gameScene.nextLevel()
            print(currentLevel)
            if currentLevel == x{
                if (x % 2) == 0{
                    nextButton.isEnabled = false
                    nextButton.backgroundColor = UIColor.gray
                }else{
                    nextButton.isEnabled = true
                    nextButton.backgroundColor = UIColor(red:0.96, green:0.13, blue:1.00, alpha:1.0)
                    
                }
            }else{
                nextButton.isEnabled = true
                nextButton.backgroundColor = UIColor(red:0.96, green:0.13, blue:1.00, alpha:1.0)
            }
        }
    }
    
    
    @IBAction func previousButton(_ sender: UIButton) {
        if let gameScene = skView.scene as? MainGameScene{
            currentLevel = currentLevel - 1
            gameScene.prevLevel()
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(red:0.96, green:0.13, blue:1.00, alpha:1.0)
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
