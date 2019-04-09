//
//  GameScene.swift
//  Projects16-18-Milestone
//
//  Created by Giulia Boscaro on 08/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var scoreLabel: SKLabelNode!
    var bulletsLabel: SKLabelNode!
    var isGameOver = false
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var bullets = 3 {
        didSet {
            bulletsLabel.text = "Bullets: \(bullets)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "wood-background")
        background.position = CGPoint(x: 512, y: 454)
        background.blendMode = .replace
        background.size = UIScreen.main.bounds.size
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 780, y: 710)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.fontSize = 48
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        
        bulletsLabel = SKLabelNode(fontNamed: "Chalkduster")
        bulletsLabel.position = CGPoint(x: 15, y: 710)
        bulletsLabel.horizontalAlignmentMode = .left
        bulletsLabel.fontSize = 48
        bulletsLabel.text = "Bullets: 3"
        addChild(bulletsLabel)
        
        let firstRow = SKSpriteNode(imageNamed: "water-fg")
        firstRow.position = CGPoint(x: 512, y: 10)
        firstRow.size.width = UIScreen.main.bounds.width
        firstRow.size.height = 200
        addChild(firstRow)
        
        let secondRow = SKSpriteNode(imageNamed: "water-fg")
        secondRow.position = CGPoint(x: 512, y: 260)
        secondRow.size.width = UIScreen.main.bounds.width
        secondRow.size.height = 200
        addChild(secondRow)
        
        let thirdRow = SKSpriteNode(imageNamed: "water-fg")
        thirdRow.position = CGPoint(x: 512, y: 500)
        thirdRow.size.width = UIScreen.main.bounds.width
        thirdRow.size.height = 200
        addChild(thirdRow)
        
        
    }
}
