//
//  Dog.swift
//  Jetpack
//
//  Created by Alex Cuevas on 17/5/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import SpriteKit


class Dog: SKSpriteNode {
    
    var boosted = false
    
    //Animations
    var flyAnimation = SKAction()
    var boostAnimation = SKAction()
    var dieAnimation = SKAction()
    
    let flyTexture1 = SKTexture(imageNamed: "fly1.png")
    let flyTexture2 = SKTexture(imageNamed: "fly2.png")
    
    // FIXME: dead1.png not found
    let dieTexture1 = SKTexture(imageNamed: "dead2.png")
    let dieTexture2 = SKTexture(imageNamed: "dead2.png")
    
    let boostTexture1 = SKTexture(imageNamed: "boosted1.png")
    // FIXME: boosted2.png not found
    let boostTexture2 = SKTexture(imageNamed: "boosted1.png")
    
    var score: Double = Double(0)
    
    convenience init(menuWithFrame: CGRect) {
        self.init()
        position = CGPoint(x: menuWithFrame.minX - size.width, y: menuWithFrame.midY / 3 )
        boostMenu()
        run(.repeatForever(.sequence(
            [.move(by: CGVector(dx: menuWithFrame.maxX + size.width * 2, dy: 0), duration: 6),
             .move(to: CGPoint(x: menuWithFrame.minX - size.width, y: menuWithFrame.midY / 3), duration: 0)]
            )))
    }
    
    convenience init(gameWithFrame: CGRect) {
        self.init()
        physicsBody = SKPhysicsBody(rectangleOf: texture!.size())
        position = CGPoint(x: gameWithFrame.maxX * 0.2, y: gameWithFrame.midY)
        physicsBody!.allowsRotation = false
        physicsBody!.categoryBitMask = nodeType.dog.rawValue
        constraints = [SKConstraint.positionX(SKRange(constantValue: position.x))]
        fly()
    }
    
    private init() {
        flyAnimation = .repeatForever(.animate(with: [flyTexture1, flyTexture2], timePerFrame: 0.2))
        boostAnimation = .repeatForever(.animate(with: [boostTexture1, boostTexture2], timePerFrame: 0.2))
        dieAnimation = .repeatForever(.animate(with: [dieTexture1,dieTexture2], timePerFrame: 0.2))
        super.init(texture: flyTexture1, color: UIColor(), size: flyTexture1.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func fly() {
        boosted = false
        run(flyAnimation)
    }
    
    func boostMenu() {
        run(boostAnimation)
    }
    
    func boost() {
        boosted = true
        run(boostAnimation)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fly), userInfo: nil, repeats: true)
    }
    
    func die() {
        physicsBody!.categoryBitMask = 0
        run(SKAction.playSoundFileNamed("game_over.mp3", waitForCompletion: true))
        run(dieAnimation)
    }
}
