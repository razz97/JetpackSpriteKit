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
    
    var isButtonHolding: Bool = false
    let textuteButton = SKTexture(imageNamed: "start.png")
    let textureButtonHold = SKTexture(imageNamed: "start_hold.png")
    let playButton = SKSpriteNode(imageNamed: "start.png")
    let music = SKAudioNode(fileNamed: "menu.mp3")
    
    override func didMove(to view: SKView) {
        setTitle()
        setPlayButton()
        setBackground()
        setDog()
        addChild(music)
    }
    
    func setTitle() {
        let title: SKLabelNode = SKLabelNode(fontNamed: "BloomerDEMO-Regular")
        title.fontSize = 65
        title.text = "DOGPACK RIDE"
        title.fontColor = .cyan
        title.position = CGPoint(x: self.frame.midX, y: self.frame.midY+100)
        title.zPosition = 2
        self.addChild(title)
    }
    
    func setPlayButton() {
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playButton.name = "playButton"
        self.addChild(playButton)
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
        addChild(Dog(menuWithFrame: frame))
    }
    
    func changeButtonTexture(_ hold: Bool) {
        playButton.texture = hold ? self.textureButtonHold : self.textuteButton
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            let nodeName = nodesArray.first?.name
            if nodeName == "playButton" {
                run(.playSoundFileNamed("click.mp3", waitForCompletion: true))
                changeButtonTexture(true)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        changeButtonTexture(false)
        if let location = touches.first?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            let nodeName = nodesArray.first?.name
            if nodeName == "playButton" {
                let scene = GameScene(size: CGSize(width: 800, height: 800))
                scene.scaleMode = .resizeFill
                self.view?.presentScene(scene)
            }
        }
    }

}

