//
//  GameScene.swift
//  Trump Hole
//
//  Created by Luis Ramirez on 4/12/16.
//  Copyright (c) 2016 Luis Ramirez. All rights reserved.
//

import SpriteKit
import AVFoundation
import GameKit
import GoogleMobileAds


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var movingObjects = SKSpriteNode()
    var groundSpeed = TimeInterval(15)
    var score = 0
    var trump = SKSpriteNode()
    var groundStart = SKSpriteNode()
    var groundStart2 = SKSpriteNode()
    var groundStart3 = SKSpriteNode()
    var groundStart4 = SKSpriteNode()
    var hilary = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var gameoverLabel = SKLabelNode()
    var labelContainer = SKSpriteNode()
    var bg = SKSpriteNode()
    var bottom = SKNode()
    var gameOver = false
    var groundSpawnSpeed = 1.2
    var startGroundTimer = Timer()
    var secondGroundTimer = Timer()
    var startSoundTimer = Timer()
    
    var music = "Retro Comedy"
    var musicPlayer = AVAudioPlayer()
    
    var soundFiles = ["Okay2", "we_want_deal!2", "Im_really_rich2", "Thank_you_darling2", "get_out_of_here2", "This is Hillary Clinton", "Im exhausted", "And I thank all of you", "Every American gets a cup cake"]
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    
    var diedRestartButton = SKSpriteNode()
    var diedMenuButton = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    
    
    let trumpTexture = SKTexture(imageNamed: "trumpstanding1.png")
    let trumpTexture2 = SKTexture(imageNamed: "trumprunning1.png")
    let hilaryTexture = SKTexture(imageNamed: "hilaryopenmouth1.png")
    let startGroundTexture = SKTexture(imageNamed: "bringgroundstart.png")
    
    enum PhysicsCategory:UInt32 {
        case trump = 1
        case gap = 2
        case hilary = 4
    }
    
    func setupAudioPlayer(_ file: NSString, type: NSString){
        let path = Bundle.main.path(forResource: file as String, ofType: type as String)
        let url = URL(fileURLWithPath: path!)
        do {
            try  audioPlayer =  AVAudioPlayer(contentsOf: url)
        } catch {
            print("Player not available")
        }
    }
    
    func setupMusicPlayer(_ file: NSString, type: NSString){
        let path = Bundle.main.path(forResource: file as String, ofType: type as String)
        let url = URL(fileURLWithPath: path!)
        do {
            try  musicPlayer =  AVAudioPlayer(contentsOf: url)
        } catch {
            print("Player not available")
        }
    }

    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        self.addChild(movingObjects)
        self.addChild(labelContainer)
        
        self.setupMusicPlayer(music as NSString, type: "mp3")
        musicPlayer.numberOfLoops = -1
        musicPlayer.prepareToPlay()
        musicPlayer.play()
    
        
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.allowsRotation = false
        borderBody.affectedByGravity = false
        borderBody.isDynamic = false
        self.physicsBody = borderBody
        
        bg = SKSpriteNode(imageNamed: "background.png")
        bg.size = self.frame.size
        bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 40)
        bg.zPosition = -6
        self.addChild(bg)
        
        
        bottom.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 30)
        bottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 50))
        borderBody.affectedByGravity = false
        bottom.physicsBody?.isDynamic = false
        self.addChild(bottom)
        
        
        let moveStartGround = SKAction.moveTo(y: self.frame.size.height, duration: 7)
        let removeStartGround = SKAction.removeFromParent()
        let moveAndRemoveStartGround = SKAction.sequence([moveStartGround, removeStartGround])
        groundStart = SKSpriteNode(texture: startGroundTexture)
        groundStart.size = CGSize(width: startGroundTexture.size().width, height: startGroundTexture.size().height/6)
        groundStart.position = CGPoint(x: self.frame.minX, y: self.frame.midY)
        groundStart.run(moveAndRemoveStartGround)
        groundStart.physicsBody = SKPhysicsBody(rectangleOf: groundStart.size)
        groundStart.physicsBody?.isDynamic = false
        self.addChild(groundStart)
        
        let moveStart2Ground = SKAction.moveTo(y: self.frame.size.height, duration: 10)
        let removeStart2Ground = SKAction.removeFromParent()
        let moveAndRemoveStart2Ground = SKAction.sequence([moveStart2Ground, removeStart2Ground])
        groundStart2 = SKSpriteNode(texture: startGroundTexture)
        groundStart2.size = CGSize(width: startGroundTexture.size().width, height: startGroundTexture.size().height/6)
        groundStart2.position = CGPoint(x: self.frame.maxX, y: self.frame.midY - 100)
        groundStart2.run(moveAndRemoveStart2Ground)
        groundStart2.physicsBody = SKPhysicsBody(rectangleOf: groundStart.size)
        groundStart2.physicsBody?.isDynamic = false
        self.addChild(groundStart2)
        
        let moveStart3Ground = SKAction.moveTo(y: self.frame.size.height, duration: 12)
        let removeStart3Ground = SKAction.removeFromParent()
        let moveAndRemoveStart3Ground = SKAction.sequence([moveStart3Ground, removeStart3Ground])
        groundStart3 = SKSpriteNode(texture: startGroundTexture)
        groundStart3.size = CGSize(width: startGroundTexture.size().width, height: startGroundTexture.size().height/6)
        groundStart3.position = CGPoint(x: self.frame.minX, y: self.frame.midY - 200)
        groundStart3.run(moveAndRemoveStart3Ground)
        groundStart3.physicsBody = SKPhysicsBody(rectangleOf: groundStart.size)
        groundStart3.physicsBody?.isDynamic = false
        self.addChild(groundStart3)
        
        let moveStart4Ground = SKAction.moveTo(y: self.frame.size.height, duration: 14)
        let removeStart4Ground = SKAction.removeFromParent()
        let moveAndRemoveStart4Ground = SKAction.sequence([moveStart4Ground, removeStart4Ground])
        groundStart4 = SKSpriteNode(texture: startGroundTexture)
        groundStart4.size = CGSize(width: startGroundTexture.size().width, height: startGroundTexture.size().height/6)
        groundStart4.position = CGPoint(x: self.frame.maxX, y: self.frame.midY - 300)
        groundStart4.run(moveAndRemoveStart4Ground)
        groundStart4.physicsBody = SKPhysicsBody(rectangleOf: groundStart.size)
        groundStart4.physicsBody?.isDynamic = false
        self.addChild(groundStart4)
        
        trump = SKSpriteNode(texture: trumpTexture)
        
        trump.size = CGSize(width: 40, height: 40)
        trump.position = CGPoint(x: self.frame.minX + 5, y: groundStart.position.y+1)
        trump.physicsBody = SKPhysicsBody(circleOfRadius: trumpTexture.size().height / 10)
        trump.physicsBody!.isDynamic = true
        trump.physicsBody?.restitution = 0
        trump.physicsBody?.linearDamping = 0.5
        trump.physicsBody?.categoryBitMask = PhysicsCategory.trump.rawValue
        trump.physicsBody?.collisionBitMask = PhysicsCategory.trump.rawValue
        trump.physicsBody?.allowsRotation = false
        self.addChild(trump)
        
        hilary = SKSpriteNode(texture: hilaryTexture)
        hilary.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
        hilary.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: hilaryTexture.size().height / 4))
        hilary.physicsBody!.isDynamic = false
        hilary.physicsBody?.categoryBitMask = PhysicsCategory.hilary.rawValue
        hilary.physicsBody?.contactTestBitMask = PhysicsCategory.trump.rawValue
        self.addChild(hilary)
        
        scoreLabel.fontName = "AvenirNext-Heavy"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 90)
        scoreLabel.zPosition = -5
        self.addChild(scoreLabel)
        
        startGroundTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(makeGround), userInfo: nil, repeats: true)
        
        startSoundTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(makeSounds), userInfo: nil, repeats: true)
        
    }
    
    
    func updateLeaderboard() {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            // Create a new score object, with our leaderboard:
            let score = GKScore(leaderboardIdentifier:
                "score")
            // Set the score value to our coin score:
            score.value = Int64(self.score)
            // Report the score (wrap the score in an array)
            GKScore.report([score],
                                 withCompletionHandler:
                {(error: Error?) -> Void in
                    if error != nil {
                        print(error)
                    }
            })
        }
    }
    
    func makeSounds() {
        let range: UInt32 = UInt32(soundFiles.count)
        let number = Int(arc4random_uniform(range))
        
        self.setupAudioPlayer(soundFiles[number] as NSString, type: "mp3")
        
        self.audioPlayer.play()
    }

            func makeGround() {
                
                let gapWidth = trumpTexture.size().width / 4
                let movementAmount = arc4random() % UInt32(self.frame.size.width / 2)
                let groundOffset = CGFloat(movementAmount) - self.frame.size.width / 4
                let moveGround = SKAction.moveTo(y: self.frame.size.height, duration: groundSpeed)
                let removeGround = SKAction.removeFromParent()
                let moveAndRemoveGround = SKAction.sequence([moveGround, removeGround])
                let groundTexture = SKTexture(imageNamed: "bringground.png")
                let ground2Texture = SKTexture(imageNamed: "bringground1.png")
                let voteTexture = SKTexture(imageNamed: "vote2.png")
                
                
                let ground1 = SKSpriteNode(texture: groundTexture)
                ground1.position = CGPoint(x: self.frame.midX + groundTexture.size().width/2 + gapWidth / 2 + groundOffset, y: self.frame.midY - self.frame.size.height)
                ground1.size = CGSize(width: groundTexture.size().width, height: groundTexture.size().height/6)
                ground1.run(moveAndRemoveGround)
                ground1.physicsBody = SKPhysicsBody(rectangleOf: ground1.size)
                ground1.physicsBody!.isDynamic = false
                
                movingObjects.addChild(ground1)
                
                let ground2 = SKSpriteNode(texture: ground2Texture)
                ground2.position = CGPoint(x: self.frame.midX - ground2Texture.size().width/2 - gapWidth / 2 + groundOffset, y: self.frame.midY - self.frame.size.height)
                ground2.size = CGSize(width: ground2Texture.size().width, height: ground2Texture.size().height/6)
                ground2.run(moveAndRemoveGround)
                ground2.physicsBody = SKPhysicsBody(rectangleOf: ground2.size)
                ground2.physicsBody!.isDynamic = false
                movingObjects.addChild(ground2)
                
                let gap = SKSpriteNode(texture: voteTexture)
                gap.position = CGPoint(x: self.frame.midX + groundOffset, y: self.frame.midY - self.frame.size.height)
                gap.run(moveAndRemoveGround)
                gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: gapWidth, height: ground1.size.height / 6))
                gap.physicsBody!.categoryBitMask = PhysicsCategory.gap.rawValue
                gap.physicsBody!.contactTestBitMask = PhysicsCategory.trump.rawValue
                gap.physicsBody!.collisionBitMask = PhysicsCategory.gap.rawValue
                gap.physicsBody!.isDynamic = false
                movingObjects.addChild(gap)
                
                
                
            }
            
            func didBegin(_ contact: SKPhysicsContact) {
                
                let otherBody:SKPhysicsBody
                let trumpMask = PhysicsCategory.trump.rawValue
                
                if (contact.bodyA.categoryBitMask & trumpMask) > 0 {
                   
                    otherBody = contact.bodyB   }
                else {
                    
                    otherBody = contact.bodyA
                    switch otherBody.categoryBitMask {
                        
                    case PhysicsCategory.gap.rawValue:
                        
                        score += 1
                        scoreLabel.text = String(score)
                        
                        otherBody.node!.removeFromParent()
                        
                        if (score <= 50) {
                            groundSpeed -= 0.2
                        }
                        
                        if (score == 60) {
                            startGroundTimer.invalidate()
                            secondGroundTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(makeGround), userInfo: nil, repeats: true)
                        }
                        
                        
                        
                        
                        
                        
                        if GKLocalPlayer.localPlayer().isAuthenticated {
                            
                            
                            switch score {
                                
                            case 5: let achieve1 = GKAchievement(identifier:
                                "5_voes")
                            achieve1.showsCompletionBanner = true
                            achieve1.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve1],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                                
                            case 20: let achieve2 = GKAchievement(identifier:
                                "20_votes")
                            achieve2.showsCompletionBanner = true
                            achieve2.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve2],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 40: let achieve3 = GKAchievement(identifier:
                                "40_votes")
                            achieve3.showsCompletionBanner = true
                            achieve3.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve3],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 50: let achieve4 = GKAchievement(identifier:
                                "50_votes")
                            achieve4.showsCompletionBanner = true
                            achieve4.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve4],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 100: let achieve5 = GKAchievement(identifier:
                                "100_votes")
                            achieve5.showsCompletionBanner = true
                            achieve5.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve5],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 125: let achieve6 = GKAchievement(identifier:
                                "125_votes")
                            achieve6.showsCompletionBanner = true
                            achieve6.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve6],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 150: let achieve7 = GKAchievement(identifier:
                                "150_votes")
                            achieve7.showsCompletionBanner = true
                            achieve7.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve7],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 200: let achieve8 = GKAchievement(identifier:
                                "200_votes")
                            achieve8.showsCompletionBanner = true
                            achieve8.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve8],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 250: let achieve9 = GKAchievement(identifier:
                                "250_votes")
                            achieve9.showsCompletionBanner = true
                            achieve9.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve9],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 300: let achieve10 = GKAchievement(identifier:
                                "300_votes")
                            achieve10.showsCompletionBanner = true
                            achieve10.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve10],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 350: let achieve11 = GKAchievement(identifier:
                                "350_votes")
                            achieve11.showsCompletionBanner = true
                            achieve11.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve11],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 400: let achieve12 = GKAchievement(identifier:
                                "400_votes")
                            achieve12.showsCompletionBanner = true
                            achieve12.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve12],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 450: let achieve13 = GKAchievement(identifier:
                                "450_votes")
                            achieve13.showsCompletionBanner = true
                            achieve13.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve13],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 500: let achieve14 = GKAchievement(identifier:
                                "500_votes")
                            achieve14.showsCompletionBanner = true
                            achieve14.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve14],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 600: let achieve15 = GKAchievement(identifier:
                                "600_votes")
                            achieve15.showsCompletionBanner = true
                            achieve15.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve15],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 700: let achieve16 = GKAchievement(identifier:
                                "700_votes")
                            achieve16.showsCompletionBanner = true
                            achieve16.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve16],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 800: let achieve17 = GKAchievement(identifier:
                                "800_votes")
                            achieve17.showsCompletionBanner = true
                            achieve17.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve17],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 900: let achieve18 = GKAchievement(identifier:
                                "900_votes")
                            achieve18.showsCompletionBanner = true
                            achieve18.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve18],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            case 1000: let achieve19 = GKAchievement(identifier:
                                "1000_votes")
                            achieve19.showsCompletionBanner = true
                            achieve19.percentComplete = 100
                            // Report the achievement!
                            GKAchievement.report([achieve19],
                                                             withCompletionHandler:
                                {(error: Error?) -> Void in
                                    if error != nil {
                                        print(error)
                                    }
                            })
                            default: return
                            }
                        }
                        
                    case PhysicsCategory.hilary.rawValue:
                        if gameOver == false {
                            
                            gameOver = true
                            
                            self.speed = 0
                            
                            updateLeaderboard()
                            
                            diedRestartButton = SKSpriteNode(imageNamed: "return.png")
                            diedRestartButton.name = "restartGame"
                            diedRestartButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 30)
                            diedRestartButton.zPosition = 5
                            self.addChild(diedRestartButton)
                            
                            diedMenuButton = SKSpriteNode(imageNamed: "menubutton2.png")
                            diedMenuButton.name = "backToMain"
                            diedMenuButton.position = CGPoint(x: self.frame.midX - 80, y: self.frame.midY - 30)
                            diedMenuButton.zPosition = 5
                            self.addChild(diedMenuButton)
                            
                            
                            
                            let gameOverText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
                            gameOverText.text = "Game Over"
                            gameOverText.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 30)
                            gameOverText.zPosition = 5
                            gameOverText.fontSize = 60
                            self.addChild(gameOverText)
                            
                            musicPlayer.stop()
                            startSoundTimer.invalidate()
                            
                            self.run(SKAction.playSoundFileNamed("And I thank all of you.mp3",
                                waitForCompletion: true))
                        }
                    default:
                        print("no contact")
                    }
                    
                }
            }
            
            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                /* Called when a touch begins */
                
                for touch in (touches ) {
                    let location = touch.location(in: self)
                    let nodeTouched = atPoint(location)
                    if gameOver == false {
                        
                        
                        if location.x < self.frame.size.width / 2 {
                            let flipTrumpNegative = SKAction.scaleX(to: -1, duration: 0)
                            let jumpFrames:[SKTexture] = [trumpTexture2, trumpTexture
                            ]
                            
                            let negJump = SKAction.animate(with: jumpFrames, timePerFrame: 0.14)
                            let negJumpAction = SKAction.sequence([flipTrumpNegative, negJump])
                            trump.run(negJumpAction)
                            trump.physicsBody!.applyImpulse(CGVector(dx: -5, dy: 5))
                        }
                        else {
                            let flipTrumpPositive = SKAction.scaleX(to: 1, duration: 0)
                            let jumpFrames:[SKTexture] = [trumpTexture2, trumpTexture
                            ]
                            
                            let posJump = SKAction.animate(with: jumpFrames, timePerFrame: 0.14)
                            let posJumpAction = SKAction.sequence([flipTrumpPositive, posJump])
                            trump.run(posJumpAction)
                            trump.physicsBody!.applyImpulse(CGVector(dx: 5, dy: 5))
                        }
                    }
                        
                        
                    else if nodeTouched.name == "restartGame" {
                        // Transition to a new version of the GameScene
                        // to restart the game:
                        self.view?.presentScene(
                            GameScene(size: self.size),
                            transition: .crossFade(withDuration: 0.6))
                    }
                    else if nodeTouched.name == "backToMain" {
                        // Transition to the main menu scene:
                        
                        musicPlayer.stop()
                        self.view?.presentScene(
                            MenuScene(size: self.size),
                            transition: .crossFade(withDuration: 0.6))
                    }
                }
            }
        
            override func update(_ currentTime: TimeInterval) {
                /* Called before each frame is rendered */
            }
}



