//
//  AnimationController.swift
//  ABC_Vision
//
//  Created by Wylan Neely on 5/24/25.
//

import Foundation
import SceneKit

struct AnimationController {
    
    //TODO: make an object that animates the object depending on the name of the file
    
    func animateNodeInScene(_ node: SCNNode, sceneFileName: String) {
        
        switch sceneFileName {
        case "Earth":
            earthRotation(node)
        case "sun":
            rotate(node)
            default:
            rotate(node)
        }
    }
    
    //MARK: Default planets
    func rotate(_ node: SCNNode ) {
        let rotation = CABasicAnimation(keyPath: "rotation")
        rotation.fromValue = SCNVector4(0, 1, 0, 0)
        rotation.toValue = SCNVector4(0, 1, 0, Float.pi * 2)
        rotation.duration = 15
        rotation.repeatCount = .infinity
        node.addAnimation(rotation, forKey: "rotate")
    }
    
    //MARK: Planets
    
   
    
    func earthRotation(_ node: SCNNode ) {
        let rotation = CArotation(20)
        node.addAnimation(rotation, forKey: "rotate")
        let scale = CAScale()
        node.addAnimation(scale, forKey: "scale")
        let zigzag = CAZigZag(position: node.position)
        node.addAnimation(zigzag, forKey: "zigzag")
    }
    
    //MARK: Helpers
    
    func CArotation(_ duration: TimeInterval = 15) -> CABasicAnimation  {
        let rotation = CABasicAnimation(keyPath: "rotation")
        rotation.fromValue = SCNVector4(0, 1, 0, 0)
        rotation.toValue = SCNVector4(0, 1, 0, Float.pi * 2)
        rotation.duration = duration
        rotation.repeatCount = .infinity
        return  rotation
    }
    
    func CAScale(x:Float = 1.2,y:Float = 1.2,z: Float = 1.2, duration: TimeInterval = 2) -> CABasicAnimation  {
        let scale = CABasicAnimation(keyPath: "scale")
        scale.fromValue = SCNVector3(1.0, 1.0, 1.0)
        scale.toValue = SCNVector3(x,y,z)
        scale.duration = duration
        scale.autoreverses = true
        scale.repeatCount = .infinity
        return scale
    }
    
    func CAZigZag(position: SCNVector3 ,offset: Float = 0.05, duration: TimeInterval = 30.0) -> CAKeyframeAnimation  {
        let zigzag = CAKeyframeAnimation(keyPath: "position")
        let currentPosition = position

        let offset = offset  // About a few inches in AR space
        zigzag.values = [
            NSValue(scnVector3: currentPosition),
            NSValue(scnVector3: SCNVector3(currentPosition.x + offset, currentPosition.y, currentPosition.z)),
            NSValue(scnVector3: SCNVector3(currentPosition.x, currentPosition.y + offset, currentPosition.z)),
            NSValue(scnVector3: SCNVector3(currentPosition.x - offset, currentPosition.y, currentPosition.z)),
            NSValue(scnVector3: SCNVector3(currentPosition.x, currentPosition.y - offset, currentPosition.z)),
            NSValue(scnVector3: currentPosition)
        ]
        zigzag.duration = duration
        zigzag.repeatCount = .infinity
        return zigzag
    }
}
