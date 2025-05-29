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
           // Planets
           case "Sun":
               rotate(node)
           case "Moon":
               rotate(node)
           case "Earth":
               earthRotation(node)
           case "Jupiter":
               rotate(node)
           case "Mars":
               rotate(node)
           case "Mercury":
               rotate(node)
           case "Neptune":
               rotate(node)
           case "Uranus":
               rotate(node)
           case "Venus":
               rotate(node)
           case "Pluto":
               rotate(node)
           case "Saturn":
               rotate(node)
           // Foods
           case "Apple":
               foodDefaults(node)
           case "Banana":
               foodDefaults(node)
           case "Carrot":
               foodDefaults(node)
           // case "Carrots":
           //     foodDefaults(node)
           case "Cheese":
               foodDefaults(node)
           case "Corn":
               foodDefaults(node)
           case "Donut":
               foodDefaults(node)
           case "Egg":
               foodDefaults(node)
           case "Milk":
               foodDefaults(node)
           case "Orange":
               foodDefaults(node)
           case "Pizza":
               foodDefaults(node)
           default:
               animalDefaults(node)
           }
    }
    
    //MARK: Defaults
    func rotate(_ node: SCNNode ) {
        let rotation = CArotation(20)
        node.addAnimation(rotation, forKey: "rotate")
        let scale = CAScale()
        node.addAnimation(scale, forKey: "scale")
        let zigzag = CAZigZag(position: node.position)
        node.addAnimation(zigzag, forKey: "zigzag")
    }
        
    func foodDefaults(_ node: SCNNode ) {
        let upDown = CAUpDown(position: node.position)
        node.addAnimation(upDown, forKey: "upDown")
        let scale = CAScale()
        node.addAnimation(scale, forKey: "scale")
    }
    
    func animalDefaults(_ node: SCNNode ) {
        let circle = CACircular(position: node.position)
        node.addAnimation(circle, forKey: "circle")
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
    
    func CAUpDown(position: SCNVector3, offset: Float = 0.3, duration: TimeInterval = 5.0) -> CAKeyframeAnimation {
        let upDown = CAKeyframeAnimation(keyPath: "position")

        let currentPosition = position
        let up = SCNVector3(currentPosition.x, currentPosition.y + offset, currentPosition.z)
        let down = SCNVector3(currentPosition.x, currentPosition.y - offset, currentPosition.z)

        upDown.values = [
            NSValue(scnVector3: currentPosition),
            NSValue(scnVector3: up),
            NSValue(scnVector3: currentPosition)
        ]
        upDown.duration = duration
        upDown.repeatCount = .infinity
        upDown.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        return upDown
    }
    
    func CACircular(position: SCNVector3, diameter: Float = 1.0, duration: TimeInterval = 5.0) -> CAKeyframeAnimation {
        
        let circularPath = CAKeyframeAnimation(keyPath: "position")

        let radius = diameter / 2
        let center = position

        let steps = 60  // Higher = smoother circle
        var values: [NSValue] = []

        for i in 0...steps {
            let angle = Float(i) * (2 * Float.pi / Float(steps))
            let x = center.x + radius * cos(angle)
            let z = center.z + radius * sin(angle)
            let y = center.y // stays flat on the table
            let point = SCNVector3(x, y, z)
            values.append(NSValue(scnVector3: point))
        }

        circularPath.values = values
        circularPath.duration = duration
        circularPath.repeatCount = .infinity
        circularPath.calculationMode = .linear
        circularPath.timingFunction = CAMediaTimingFunction(name: .linear)

        return circularPath
    }
        
}
