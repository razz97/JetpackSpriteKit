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
    
    //Animations
    var flyAnimation = SKAction()
    var boostAnimation = SKAction()
    
    let flyTexture1 = SKTexture(imageNamed: "fly1.png")
    let flyTexture2 = SKTexture(imageNamed: "fly2.png")
    
    let boostTexture1 = SKTexture(imageNamed: "boosted1.png")
    // FIXME: boosted2.png not found
    let boostTexture2 = SKTexture(imageNamed: "boosted1.png")
    
    convenience init(menuWithFrame: CGRect) {
        self.init()
        position = CGPoint(x: menuWithFrame.minX - size.width, y: menuWithFrame.midY / 3 )
        run(boostAnimation)
        run(.repeatForever(.sequence(
            [.move(by: CGVector(dx: menuWithFrame.maxX + size.width * 2, dy: 0), duration: 6),
             .move(to: CGPoint(x: menuWithFrame.minX - size.width, y: menuWithFrame.midY / 3), duration: 0)]
        )))
    }
    
    convenience init(gameWithFrame: CGRect) {
        self.init()
        physicsBody = SKPhysicsBody(rectangleOf: texture!.size())
        position = CGPoint(x: gameWithFrame.minX + size.width, y: gameWithFrame.midY)
        fly()
    }
    
    private init() {
        flyAnimation = .repeatForever(.animate(with: [flyTexture1, flyTexture2], timePerFrame: 0.2))
        boostAnimation = .repeatForever(.animate(with: [boostTexture1, boostTexture2], timePerFrame: 0.2))
        super.init(texture: flyTexture1, color: UIColor(), size: flyTexture1.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func fly() {
        run(flyAnimation)
    }
    
    func boost() {
        run(boostAnimation)
    }
}
