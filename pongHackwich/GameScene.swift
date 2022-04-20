//
//  GameScene.swift
//  pongHackwich
//
//  Created by Alec Kinzie on 4/8/22.
//

import SpriteKit
import GameplayKit

var playerOnePaddle = SKSpriteNode()
var ball = SKSpriteNode()

var scoreLabel = SKLabelNode()
var deathsLabel = SKLabelNode()
var infoLabel = SKLabelNode()


var score = 0
var deaths = 0


class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = border
        physicsWorld.contactDelegate = self
        
        playerOnePaddle = self.childNode(withName: "playerOnePaddle") as! SKSpriteNode
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        
        let bottomLeft = CGPoint(x: frame.origin.x, y: frame.origin.y)
        let bottomRight = CGPoint(x: -frame.origin.x, y: frame.origin.y)
        let bottom = SKNode()
        bottom.name = "bottom"
        bottom.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: bottomRight)
        bottom.physicsBody?.contactTestBitMask = 1
        addChild(bottom)
        
        scoreLabel = self.childNode(withName: "scorer") as! SKLabelNode
        scoreLabel.text = "Score: 0"
        
        deathsLabel = self.childNode(withName: "deaths") as! SKLabelNode
        deathsLabel.text = "Deaths: 0"
        
        infoLabel = self.childNode(withName: "info") as! SKLabelNode
        infoLabel.text = "Don't hit the bottom more than 3 times!"
        //        scoreLabel.horizontalAlignmentMode = .right
        //        scoreLabel.position = CGPoint(x: 500, y: 500)
        //        addChild(scoreLabel)
    }
    
    struct game {
        static var IsOver : Bool = false
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
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact.bodyA)
        print(contact.bodyB)
        if contact.bodyA.node?.name == "playerOnePaddle" && contact.bodyB.node?.name == "Ball" {
            score += 1
            scoreLabel.text = "Score: \(score)"
        }
        
        if contact.bodyA.node?.name == "bottom" && contact.bodyB.node?.name == "Ball" {
            deaths += 1
            deathsLabel.text = "Deaths: \(deaths)"
        }
        
        if deaths == 3 {
            ball.removeFromParent()
            playerOnePaddle.removeFromParent()
            infoLabel.text = "You hit the bottom more than 3 times! oops!"
            scoreLabel.text = "Game over"
            deathsLabel.text = "You Loose"
        }
    }
    
    
    
}
