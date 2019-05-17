//
//  GameScene.swift
//  Jetpack
//
//  Created by Alex Bou on 09/04/2019.
//  Copyright © 2019 Alex Bou. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    // Función equivalente a viewDidLoad
    override func didMove(to view: SKView) {
        // Nos encargamos de las colisiones de nuestros nodos
        //self.physicsWorld.contactDelegate = self
        initialize()
        
        
    }
    
    func initialize() {
        setTitle()
    }
    
    func setTitle() {
        let title: SKLabelNode = SKLabelNode()
        title.fontName = "Arial"
        title.fontSize = 80
        title.text = "DOGPACK RIDE"
        title.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 500)
        title.zPosition = 2
        self.addChild(title)
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
