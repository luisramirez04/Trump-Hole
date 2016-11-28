//
//  GameViewController.swift
//  Trump Hole
//
//  Created by Luis Ramirez on 4/12/16.
//  Copyright (c) 2016 Luis Ramirez. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit
import GoogleMobileAds

class GameViewController: UIViewController {
    
    var banner : GADBannerView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Build the menu scene:
        let menuScene = MenuScene()
        let skView = self.view as! SKView
        
        skView.ignoresSiblingOrder = true
        
        menuScene.size = view.bounds.size
        // Show the menu:
        skView.presentScene(menuScene)
        authenticateLocalPlayer(menuScene)
        loadBanner()
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    func loadBanner(){
      banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
      
      banner.rootViewController = self
      let req : GADRequest = GADRequest()
       banner.load(req)
       banner.frame = CGRect(x: 0, y: view.bounds.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        self.view.addSubview(banner)
    }
    
    func authenticateLocalPlayer(_ menuScene:MenuScene) {
        
        
        let localPlayer = GKLocalPlayer.localPlayer();
            localPlayer.authenticateHandler = {
                (viewController: UIViewController?, error: Error?) -> Void in
                if viewController != nil {
                    self.present(viewController!, animated: true, completion: nil)
                }
                    else if localPlayer.isAuthenticated
                {
                    menuScene.createLeaderboardButton()
                }
                else {
                }
        }
    }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Release any cached data, images, etc that aren't in use.
        }
        
        override var prefersStatusBarHidden : Bool {
            return true
        }
}
