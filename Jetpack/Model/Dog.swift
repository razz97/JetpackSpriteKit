//
//  Dog.swift
//  Jetpack
//
//  Created by Alex Cuevas on 17/5/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import SpriteKit


class Dog: SKSpriteNode{
    
    init() {
        let texture = SKTexture(imageNamed: "fly1.png")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: frame.minX, y: frame.midY)
    }
    
    init(name: String) {
        let texture = SKTexture(imageNamed: "fly1.png")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        self.position = CGPoint(x: frame.minX, y: frame.midY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func fly() {
        let fly1 = SKTexture(imageNamed: "fly1.png")
        let fly2 = SKTexture(imageNamed: "fly2.png")
        let animation = SKAction.animate(with: [fly1, fly2], timePerFrame: 0.2)
        let infiniteAnimation = SKAction.repeatForever(animation)
        self.run(infiniteAnimation)
    }
    
    func boost() {
        // 5s
        let fly1 = SKTexture(imageNamed: "boosted1.png")
        let fly2 = SKTexture(imageNamed: "boosted2.png")
        let animation = SKAction.animate(with: [fly1, fly2], timePerFrame: 0.2)
        let infiniteAnimation = SKAction.repeatForever(animation)
        self.run(infiniteAnimation)
        
    }
}
