//
//  GameScene.swift
//  Jetpack
//
//  Created by Alex Bou on 09/04/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

// 0 is used for dead dog
enum nodeType: UInt32 {
    case dog = 1
    case laser = 2
    case missile = 4
    case coin = 6
    case booster = 7
}

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var dog: Dog?
    var timer: Timer = Timer()
    let points = SKLabelNode(fontNamed: "BloomerDEMO-Regular")
    let music = SKAudioNode(fileNamed: "music.wav")
    let coinAnimation = SKAction.repeat(.animate(with: [
            SKTexture(imageNamed: "coin1.png"),SKTexture(imageNamed: "coin2.png"),
            SKTexture(imageNamed: "coin3.png"),SKTexture(imageNamed: "coin4.png"),
            SKTexture(imageNamed: "coin5.png"),SKTexture(imageNamed: "coin6.png"),
            SKTexture(imageNamed: "coin7.png"),SKTexture(imageNamed: "coin8.png")
        ], timePerFrame: 0.2),count: 3)
    let billAnimation = SKAction.repeat(.animate(with: [
        SKTexture(imageNamed: "bill2"),SKTexture(imageNamed: "bill3"), SKTexture(imageNamed: "bill4"), SKTexture(imageNamed: "bill5")
    ], timePerFrame: 0.2),count: 3)
    let starAnimation = SKAction.repeat(.animate(with: [
            SKTexture(imageNamed: "star1"),SKTexture(imageNamed: "star2"),SKTexture(imageNamed: "star3"),
            SKTexture(imageNamed: "star4"),SKTexture(imageNamed: "star5"),SKTexture(imageNamed: "star6"),
            SKTexture(imageNamed: "star7"),SKTexture(imageNamed: "star8"),SKTexture(imageNamed: "star9"),
            SKTexture(imageNamed: "star10"),SKTexture(imageNamed: "star11"),SKTexture(imageNamed: "star12"),
            SKTexture(imageNamed: "star13"),SKTexture(imageNamed: "star14"),SKTexture(imageNamed: "star15"),
            SKTexture(imageNamed: "star16"),SKTexture(imageNamed: "star17"),SKTexture(imageNamed: "star18"),
            SKTexture(imageNamed: "star19"),SKTexture(imageNamed: "star21"),SKTexture(imageNamed: "star22"),
            SKTexture(imageNamed: "star23"),
        ], timePerFrame: 0.1), count: 2)
    
    var laserTimer = Timer()
    var coinTimer = Timer()
    var missileTimer = Timer()
    var starTimer = Timer()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -7)
        dog = Dog(gameWithFrame: frame)
        addChild(dog!)
        addChild(music)
        setBackground()
        setPointsLabel()
        setBounds()
        startTimers()
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
    
    func setPointsLabel() {
        points.fontSize = 40
        points.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        points.text = "Score: 0"
        points.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 50)
        points.zPosition = 200
        self.addChild(points)
    }
    
    func startTimers() {
        laserTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addLaser), userInfo: nil, repeats: true)
        coinTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addCoin), userInfo: nil, repeats: true)
        missileTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addMissile), userInfo: nil, repeats: true)
        starTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addBooster), userInfo: nil, repeats: true)
    }
    
    @objc func addMissile() {
        if 25 >= .random(in: 0...100) {
            let warning = SKSpriteNode(imageNamed: "rocket_warn.png")
            warning.position = CGPoint(x: self.frame.maxX - warning.frame.maxX, y: dog!.position.y)
            addChild(warning)
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addAlert), userInfo: warning, repeats: false)
        }
    }
    
    @objc func addAlert(timer: Timer) {
        let warning = timer.userInfo as! SKSpriteNode
        let alert = SKSpriteNode(imageNamed: "rocket_warn_almost.png")
        alert.position = warning.position
        warning.removeFromParent()
        addChild(alert)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addRocket), userInfo: alert, repeats: false)
    }
    
    @objc func addRocket(timer: Timer) {
        let alert = timer.userInfo as! SKSpriteNode
        let rocket = SKSpriteNode(imageNamed: "bill2")
        rocket.position = alert.position
        rocket.xScale *= -1
        alert.removeFromParent()
        rocket.size = CGSize(width: rocket.texture!.size().width * 2, height: rocket.texture!.size().height * 1.75)
        rocket.physicsBody = SKPhysicsBody(texture: rocket.texture!, alphaThreshold: 0.5, size: rocket.size)
        rocket.physicsBody!.categoryBitMask = nodeType.missile.rawValue
        rocket.physicsBody!.collisionBitMask = nodeType.dog.rawValue
        rocket.physicsBody!.contactTestBitMask = nodeType.dog.rawValue
        rocket.physicsBody!.isDynamic = false
        let move = SKAction.move(to: CGPoint(x: frame.minX - 100, y: rocket.position.y), duration: 2.5)
        let moveAndRemove = SKAction.sequence([.group([move,billAnimation]),.removeFromParent()])
        rocket.run(moveAndRemove)
        addChild(rocket)
    }
    
    @objc func addLaser() {
        let laser = SKSpriteNode(imageNamed: "laser_on.png")
        laser.position = CGPoint(x: frame.maxX, y: frame.midY * .random(in: 0.5 ... 1.5))
        laser.size = CGSize(width: laser.texture!.size().width / 1.75, height: laser.texture!.size().height / 1.75)
        laser.physicsBody = SKPhysicsBody(texture: laser.texture!, alphaThreshold: 0.5, size: laser.size)
        laser.physicsBody!.affectedByGravity = false
        laser.physicsBody!.isDynamic = false
        laser.physicsBody!.pinned = true
        laser.physicsBody!.categoryBitMask = nodeType.laser.rawValue
        laser.physicsBody!.collisionBitMask = nodeType.dog.rawValue
        laser.physicsBody!.contactTestBitMask = nodeType.dog.rawValue
        laser.zRotation = .pi * CGFloat.random(in: 0...2)
        var anims:[SKAction] = [.move(to: CGPoint(x: frame.minX - 100, y: laser.position.y), duration: 3)]
        if 25 >= .random(in: 0...100) {
            anims.append(.rotate(byAngle: .pi * 2, duration: 3))
        }
        laser.run(.sequence([.group(anims),.removeFromParent()]))
        addChild(laser)
    }
    
    @objc func addCoin() {
        let coin = SKSpriteNode(imageNamed: "coin1.png")
        coin.position = CGPoint(x: frame.maxX, y: frame.midY * .random(in: 0.5 ... 1.5))
        coin.size = CGSize(width: coin.texture!.size().width, height: coin.texture!.size().height)
        coin.physicsBody = SKPhysicsBody(texture: coin.texture!, alphaThreshold: 0.5, size: coin.size)
        coin.physicsBody!.affectedByGravity = false
        coin.physicsBody!.isDynamic = false
        coin.physicsBody!.categoryBitMask = nodeType.coin.rawValue
        coin.physicsBody!.collisionBitMask = nodeType.dog.rawValue
        coin.physicsBody!.contactTestBitMask = nodeType.dog.rawValue
        let move = SKAction.move(to: CGPoint(x: frame.minX - 100, y: coin.position.y), duration: 3)
        coin.run(.sequence([.group([move,coinAnimation]),.removeFromParent()]))
        self.addChild(coin)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        applyForce()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(applyForce), userInfo: nil, repeats: true)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer.invalidate()
    }
    
    @objc func applyForce() {
        dog!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 35))
    }
    
    override func update(_ currentTime: TimeInterval) {
        dog!.score += 0.13
        points.text = "Score: \(Double(round(100*dog!.score)/100))"
    }
    
    @objc func changeToEndScene() {
        timer.invalidate()
        coinTimer.invalidate()
        laserTimer.invalidate()
        missileTimer.invalidate()
        starTimer.invalidate()
        let scene = EndingScene(score: dog!.score, size: size)
        self.view?.presentScene(scene)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // We only have collisions between a dog and something else
        let other = contact.bodyA.categoryBitMask == nodeType.dog.rawValue ? contact.bodyB : contact.bodyA
        switch other.categoryBitMask {
            case nodeType.missile.rawValue, nodeType.laser.rawValue:
                if !dog!.boosted {
                    dog!.die()
                    run(.playSoundFileNamed("laser.mp3", waitForCompletion: true))
                    let explosion = SKEmitterNode(fileNamed: "Explosion")!
                    explosion.position = other.node!.position
                    addChild(explosion)
                    run(.wait(forDuration: 2)) {
                        explosion.removeFromParent()
                        self.changeToEndScene()
                    }
                } else { other.node?.removeFromParent() }
                break
            case nodeType.coin.rawValue:
                other.node?.removeFromParent()
                run(SKAction.playSoundFileNamed("coin_pickup.mp3", waitForCompletion: false))
                self.dog?.score += 50
                break
            case nodeType.booster.rawValue:
                dog!.boost()
                other.node?.removeFromParent()
            default: break
        }
    }
    
    @objc func addBooster() {
        let booster = SKSpriteNode(imageNamed: "star1")
        booster.position = CGPoint(x: frame.maxX, y: frame.midY * .random(in: 0.5 ... 1.5))
        booster.size = CGSize(width: booster.texture!.size().width, height: booster.texture!.size().height)
        booster.physicsBody = SKPhysicsBody(texture: booster.texture!, alphaThreshold: 0.5, size: booster.size)
        booster.physicsBody!.affectedByGravity = false
        booster.physicsBody!.isDynamic = false
        booster.physicsBody!.categoryBitMask = nodeType.booster.rawValue
        booster.physicsBody!.collisionBitMask = nodeType.dog.rawValue
        booster.physicsBody!.contactTestBitMask = nodeType.dog.rawValue
        let move = SKAction.move(to: CGPoint(x: frame.minX - booster.size.height, y: booster.position.y), duration: 3)
        booster.run(.sequence([.group([move,starAnimation]),.removeFromParent()]))
        addChild(booster)
    }
}
