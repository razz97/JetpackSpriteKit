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
    
    let dog = SKSpriteNode(imageNamed: "fly1.png")
    var timer: Timer = Timer()
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -7)
        setBackground()
        setDog()
        setBounds()
    }
    
    func setBackground() {
        var background: SKSpriteNode
        let backTexture = SKTexture(imageNamed: "background.png")
        let horizontalMovement = SKAction.move(by: CGVector(dx: -frame.size.width, dy: 0), duration: 5)
        let backToStart = SKAction.move(by: CGVector(dx: frame.size.width, dy: 0), duration: 0)
        let loop = SKAction.repeatForever(.sequence([horizontalMovement, backToStart]))
        for i in 0...1 {
            background = SKSpriteNode(texture: backTexture)
            background.size = frame.size
            background.anchorPoint = CGPoint(x: 0, y: 0)
            background.position = CGPoint(x: frame.maxX * CGFloat(i), y: 0)
            background.size.height = self.frame.height
            background.zPosition = -1
            background.run(loop)
            self.addChild(background)
        }
    }
    
    func setDog() {
        dog.physicsBody = SKPhysicsBody(rectangleOf: (dog.texture?.size())!)
        dog.position = CGPoint(x: frame.minX + 50, y: frame.midY)
        addChild(dog)
    }
    
    func setBounds() {
        let bottom = SKNode()
        bottom.position = CGPoint(x: frame.midX, y: frame.minY)
        bottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.maxX, height: 10))
        bottom.physicsBody!.affectedByGravity = false
        bottom.physicsBody!.isDynamic = false
        let top = SKNode()
        top.position = CGPoint(x: frame.midX, y: frame.maxY)
        top.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.maxX, height: 10))
        top.physicsBody!.affectedByGravity = false
        top.physicsBody!.isDynamic = false
        addChild(top)
        addChild(bottom)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        applyForce()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(applyForce), userInfo: nil, repeats: true)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.timer.invalidate()
        
    }
    
    @objc func applyForce() {
        dog.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 35))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
