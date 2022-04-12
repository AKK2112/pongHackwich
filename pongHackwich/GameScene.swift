//
//  GameScene.swift
//  pongHackwich
//
//  Created by Alec Kinzie on 4/8/22.
//

import SpriteKit
import GameplayKit


var playerOnePaddle = SKSpriteNode()
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = border
        
        playerOnePaddle = self.childNode(withName: "playerOnePaddle") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let point = touch.location(in: self)
        playerOnePaddle.run(SKAction.moveTo(x: point.x, duration: 0.2))
    }
   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let point = touch.location(in: self)
        playerOnePaddle.run(SKAction.moveTo(x: point.x, duration: 0.2))

    }
    
}
