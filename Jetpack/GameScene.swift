//
//  GameScene.swift
//  Jetpack
//
//  Created by Alex Bou on 09/04/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    // Función equivalente a viewDidLoad
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        setBackground()
        setDog()
    }
    
    func setBackground() {
        var background: SKSpriteNode
        let backTexture = SKTexture(imageNamed: "background.png")
        let horizontalMovement = SKAction.move(by: CGVector(dx: -frame.size.width, dy: 0), duration: 4)
        let backToStart = SKAction.move(by: CGVector(dx: frame.size.width, dy: 0), duration: 0)
        let loop = SKAction.repeatForever(SKAction.sequence([horizontalMovement, backToStart]))
        for i in 0...2 {
            background = SKSpriteNode(texture: backTexture)
            background.size = frame.size
            background.position = CGPoint(x: frame.size.width * CGFloat(i), y: self.frame.midY)
            background.size.height = self.frame.height
            background.zPosition = -1
            background.run(loop)
            self.addChild(background)
        }
    }
    
    func setDog() {
        let dog = SKSpriteNode(imageNamed: "fly1.png")
        dog.position = CGPoint(x: frame.minX, y: frame.midY)
        addChild(dog)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
