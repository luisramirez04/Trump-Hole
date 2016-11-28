//
//  MenuScene.swift
//  Trump Hole
//
//  Created by Luis Ramirez on 4/17/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import SpriteKit
import GameKit
import GoogleMobileAds
class MenuScene: SKScene, GKGameCenterControllerDelegate {
    
    var startButton = SKSpriteNode()
    var questionButton = SKSpriteNode()
    var questionButtonTexture = SKTexture(imageNamed: "questionred.png")
    let buttonTexture = SKTexture(imageNamed: "playButton1.PNG")
    let bgcolor = UIColor(red: 126, green: 192, blue: 238, alpha: 1)
    override func didMove(to view: SKView) {
        
       
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = bgcolor
       
        self.run(SKAction.playSoundFileNamed("were_going_to_make_america_great2.mp3",
            waitForCompletion: true))
        
        let backgroundImage = SKSpriteNode(imageNamed: "mainScreen1.png")
        backgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 40)
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height)
        backgroundImage.zPosition = -5
        self.addChild(backgroundImage)
        
       
        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoText.text = "Trump Hole"
        logoText.position = CGPoint(x: 0, y: 140)
        logoText.fontSize = 60
        self.addChild(logoText)
        
        questionButton = SKSpriteNode(texture: questionButtonTexture)
        questionButton.name = "HowTo"
        questionButton.position = CGPoint(x: self.frame.maxX - 30, y: self.frame.maxY - 30)
        self.addChild(questionButton)
        
        // Build the start game button:
        startButton = SKSpriteNode(texture: buttonTexture)
        // Name the start node for touch detection:
        startButton.name = "StartBtn"
        startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(startButton)
        
        // Pulse the start button in and out gently:
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.7, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9),
            ])
        startButton.run(SKAction.repeatForever(pulseAction))
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            createLeaderboardButton()
            
        }
    }
    
    func createLeaderboardButton() {     // Add some text to open the leaderboard     
        let leaderboardText = SKLabelNode(fontNamed:"AvenirNext-Heavy")
        leaderboardText.text = "Leaderboard"
        leaderboardText.name = "LeaderboardBtn"
        leaderboardText.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 80)
        leaderboardText.fontSize = 20
        self.addChild(leaderboardText) }
        
        func showLeaderboard() {
            let gameCenter = GKGameCenterViewController()
            gameCenter.gameCenterDelegate = self
            gameCenter.viewState = GKGameCenterViewControllerState.leaderboards
            if let gameViewController = self.view?.window?.rootViewController {
                gameViewController.show(gameCenter,sender: self)
                gameViewController.navigationController?.pushViewController(gameCenter, animated: true)
            }
    }
            
            // This hides the game center when the user taps 'done' 
    func gameCenterViewControllerDidFinish(_ gameCenterViewController:GKGameCenterViewController)
    {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
            
            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                for touch in (touches ) {
                    let location = touch.location(in: self)
                    let nodeTouched = atPoint(location)
                    if nodeTouched.name == "StartBtn" {
                        // Player touched the start text or button node
                        // Switch to an instance of the GameScene:
                        self.view?.presentScene(GameScene(size: self.size))
                    }
                    else if nodeTouched.name == "HowTo" {
                        self.view?.presentScene(HowToScene(size: self.size))
                    }
                    else if nodeTouched.name == "LeaderboardBtn" {
                        showLeaderboard()
                    }
            }
}
}
