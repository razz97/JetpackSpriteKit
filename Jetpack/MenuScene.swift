//
//  MenuScene.swift
//  Jetpack
//
//  Created by Alex Bou on 14/05/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        setTitle()
        setPlayButton()
        setBackground()
        setDog()
    }
    
    func setTitle() {
        print("hello")
        let title: SKLabelNode = SKLabelNode()
        title.fontName = "Arial"
        title.fontSize = 65
        title.text = "DOGPACK RIDE"
        title.color = .cyan
        title.position = CGPoint(x: self.frame.midX, y: self.frame.midY+100)
        title.fontName = "BloomerDEMO-Regular"
        title.zPosition = 2
        self.addChild(title)
    }
    
    func setPlayButton() {
        let playButton: SKSpriteNode = SKSpriteNode(imageNamed: "start.png")
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playButton.name = "playButton"
        self.addChild(playButton)
    }
    
    func setBackground() {
//        var fondo2 = SKSpriteNode(imageNamed: "background.png")
//        fondo2.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
//        fondo2.size = frame.size
//        fondo2.zPosition = -1
//        self.addChild(fondo2)
        
        var fondo: SKSpriteNode
        let texturaFondo = SKTexture(imageNamed: "background.png")
        let movimientoFondo = SKAction.move(by: CGVector(dx: -frame.size.width, dy: 0), duration: 4)
        let movimientoFondoOrigen = SKAction.move(by: CGVector(dx: frame.size.width, dy: 0), duration: 0)
        let movimientoInfinitoFondo = SKAction.repeatForever(SKAction.sequence([movimientoFondo, movimientoFondoOrigen]))
        for i in 0...2 {
            fondo = SKSpriteNode(texture: texturaFondo)
            fondo.size = frame.size
            fondo.position = CGPoint(x: frame.size.width * CGFloat(i), y: self.frame.midY)
            fondo.size.height = self.frame.height
            fondo.zPosition = -1
            fondo.run(movimientoInfinitoFondo)
            self.addChild(fondo)
        }
        
    }
    
    func setDog() {
        let dog = SKSpriteNode(imageNamed: "boosted1.png")
        dog.position = CGPoint(x: frame.minX - dog.size.width, y: frame.midY * 1 / 3 + 20)
        let horizontalMovement = SKAction.move(by: CGVector(dx: frame.size.width + dog.size.width * 2, dy: 0), duration: 4)
        let backToStart = SKAction.move(to: CGPoint(x: frame.minX - dog.size.width, y: frame.midY * 1 / 3 + 20), duration: 0)
        let loop = SKAction.repeatForever(SKAction.sequence([horizontalMovement, backToStart]))
        dog.run(loop)
        addChild(dog)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            let nodeName = nodesArray.first?.name
            if nodeName == "playButton" {
                print("play")
            }
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

