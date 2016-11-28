
//
//  HowToScene.swift
//  Trump Hole
//
//  Created by Luis Ramirez on 4/23/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import SpriteKit
import GameKit
import GoogleMobileAds

class HowToScene: SKScene {
    
    let leftTexture = SKTexture(imageNamed: "leftred.png")
    let rightTexture = SKTexture(imageNamed: "rightred.png")
    
    override func didMove(to view: SKView) {
        let instructional = SKSpriteNode(imageNamed: "instructionalpage.png")
        instructional.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        instructional.size = CGSize(width: self.frame.width, height: self.frame.height)
        instructional.zPosition = -5
        self.addChild(instructional)
        
        let backText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        backText.text = "Back To"
        backText.position = CGPoint(x: self.frame.midX - 70, y: self.frame.midY - 60)
        backText.fontSize = 30
        self.addChild(backText)
        
        let backText2 = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        backText2.text = "Home"
        backText2.position = CGPoint(x: self.frame.midX - 70, y: self.frame.midY - 90)
        backText2.fontSize = 30
        self.addChild(backText2)
        
        let playText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        playText.text = "Play!"
        playText.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY - 60)
        playText.fontSize = 30
        self.addChild(playText)
        
        let backbutton = SKSpriteNode(texture: leftTexture)
        backbutton.name = "BackBtn"
        backbutton.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        self.addChild(backbutton)
        
        
        let play = SKSpriteNode(texture: rightTexture)
        play.name = "PlayBtn"
        play.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        self.addChild(play)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "BackBtn" {
                self.view?.presentScene(MenuScene(size: self.size))
            }
            else if nodeTouched.name == "PlayBtn" {
                self.view?.presentScene(GameScene(size: self.size)) }
        }
    }
}

