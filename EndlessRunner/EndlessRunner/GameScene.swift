//
//  GameScene.swift
//  EndlessRunner
//
//  Created by Wannes Bouwen on 22/03/17.
//  Copyright © 2017 Wannes Bouwen. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    var backgroundNode: SKNode!
    var midgroundNode: SKNode!
    var foregroundNode: SKNode!
    
    var player: SKNode!// Tap to Start
    
    var scaleFactor: CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // Add some gravity
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        
        // Set contact delegate
        physicsWorld.contactDelegate = self
        scaleFactor = self.size.width / 320.0

        
        backgroundColor = SKColor.white
        
        foregroundNode = createForegroundNode()
        addChild(foregroundNode)
        
        player = createPlayer()
        foregroundNode.addChild(player)
        
        
        backgroundNode = createBackgroundNode()
        addChild(backgroundNode)
        
        player.physicsBody?.isDynamic = true
        
        // 4
        player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 50.0))
    }
    
    func createPlayer() -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.2)
        
        let sprite = SKSpriteNode(imageNamed: "Player")
        playerNode.addChild(sprite)
        
        // 1
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        // 2
        playerNode.physicsBody?.isDynamic = false
        // 3
        playerNode.physicsBody?.allowsRotation = false
        // 4
        playerNode.physicsBody?.restitution = 1.0
        playerNode.physicsBody?.friction = 0.0
        playerNode.physicsBody?.angularDamping = 0.0
        playerNode.physicsBody?.linearDamping = 0.0
        
        return playerNode
    }
    
    func createForegroundNode() -> SKNode {
        let foregroundNode = SKNode()
        
        let xSpacing = 32.0 * scaleFactor
        for index in 0...19 {
            // 3
            let node = SKSpriteNode(imageNamed: "tile")
            // 4
            node.setScale(scaleFactor)
            node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            node.position = CGPoint(x: xSpacing * CGFloat(index), y: 0)
            //5
            foregroundNode.addChild(node)
        }
        
        return foregroundNode
    }
    
    func createBackgroundNode() -> SKNode {
        // 1
        // Create the node
        let backgroundNode = SKNode()
        
        let node = SKSpriteNode(imageNamed: "BG2")
        
        node.setScale(scaleFactor)
        
        backgroundNode.addChild(node)
        
        return backgroundNode
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
