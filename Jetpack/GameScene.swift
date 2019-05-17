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
    
    var dog: Dog?
    var timer: Timer = Timer()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -7)
        dog = Dog(gameWithFrame: frame)
        addChild(dog!)
        setBackground()
        setBounds()
        startLaserTimer()
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
    
    func setBounds() {
        let boundSize = CGSize(width: frame.maxX, height: 10)
        let bottom = SKSpriteNode(color: .red, size: boundSize)
        bottom.position = CGPoint(x: frame.midX, y: frame.minY)
        bottom.physicsBody = SKPhysicsBody(rectangleOf: boundSize)
        bottom.physicsBody!.affectedByGravity = false
        bottom.physicsBody!.isDynamic = false
        let top = SKSpriteNode(color: .red, size: boundSize)
        top.position = CGPoint(x: frame.midX, y: frame.maxY)
        top.physicsBody = SKPhysicsBody(rectangleOf: boundSize)
        top.physicsBody!.affectedByGravity = false
        top.physicsBody!.isDynamic = false
        addChild(top)
        addChild(bottom)
    }
    
    func startLaserTimer() {
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addLaser), userInfo: nil, repeats: true)
    }
    
    @objc func addLaser() {
        let laser = SKSpriteNode(imageNamed: "laser_on.png")
        laser.position = CGPoint(x: frame.maxX, y: frame.midY * CGFloat.random(in: 0.5 ... 1.5))
        laser.size = CGSize(width: laser.texture!.size().width / 1.75, height: laser.texture!.size().height / 1.75)
        laser.physicsBody = SKPhysicsBody(texture: laser.texture!, alphaThreshold: 0.5, size: laser.size)
        laser.physicsBody!.affectedByGravity = false
        laser.physicsBody!.isDynamic = false
        laser.zRotation = .pi * CGFloat.random(in: 0...2)
        let anim = SKAction.move(to: CGPoint(x: frame.minX - laser.size.height, y: laser.position.y), duration: 3)
        laser.run(anim)
        addChild(laser)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        applyForce()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(applyForce), userInfo: nil, repeats: true)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.timer.invalidate()
        
    }
    
    @objc func applyForce() {
        dog!.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 35))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
