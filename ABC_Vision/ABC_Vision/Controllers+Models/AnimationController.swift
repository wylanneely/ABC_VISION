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
    
    func CArotation(_ duration: TimeInterval = 15) -> CABasicAnimation  {
        let rotation = CABasicAnimation(keyPath: "rotation")
        rotation.fromValue = SCNVector4(0, 1, 0, 0)
        rotation.toValue = SCNVector4(0, 1, 0, Float.pi * 2)
        rotation.duration = duration
        rotation.repeatCount = .infinity
        return  rotation
    }
    
    func earthRotation(_ node: SCNNode ) {
           let rotation = CArotation(20)
           node.addAnimation(rotation, forKey: "rotate")
           let scale = CABasicAnimation(keyPath: "scale")
        
           scale.fromValue = SCNVector3(1.0, 1.0, 1.0)
           scale.toValue = SCNVector3(1.2, 1.2, 1.2)
           scale.duration = 2.0
           scale.autoreverses = true
           scale.repeatCount = .infinity
           node.addAnimation(scale, forKey: "scale")

           let zigzag = CAKeyframeAnimation(keyPath: "position")
           let currentPosition = node.position

           let offset: Float = 0.05  // About a few inches in AR space
           zigzag.values = [
               NSValue(scnVector3: currentPosition),
               NSValue(scnVector3: SCNVector3(currentPosition.x + offset, currentPosition.y, currentPosition.z)),
               NSValue(scnVector3: SCNVector3(currentPosition.x, currentPosition.y + offset, currentPosition.z)),
               NSValue(scnVector3: SCNVector3(currentPosition.x - offset, currentPosition.y, currentPosition.z)),
               NSValue(scnVector3: SCNVector3(currentPosition.x, currentPosition.y - offset, currentPosition.z)),
               NSValue(scnVector3: currentPosition)
           ]
           zigzag.duration = 30.0
           zigzag.repeatCount = .infinity
           node.addAnimation(zigzag, forKey: "zigzag")
    }
    
    
}
