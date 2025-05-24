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
        case "earth":
        case "sun":
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
    
    
}
