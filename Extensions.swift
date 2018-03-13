//
//  Extensions.swift
//  PortalAR
//
//  Created by George Garcia on 2/21/18.
//  Copyright © 2018 George Garcia. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

var width : CGFloat = 0.02
var height : CGFloat = 1
var length : CGFloat = 1

var doorLength : CGFloat = 0.3 // have a gap where the front door is

func createBox(isDoor : Bool) -> SCNNode{ // help us create those boxes; if it is a door, we will register a different length for those walls
    
    let node = SCNNode()
    
    //add first box; INNER
    let firstBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    let firstBoxNode = SCNNode(geometry: firstBox)
    firstBoxNode.renderingOrder = 200 //higher than the mass box.
    
    node.addChildNode(firstBoxNode)
    
    //add second box; OUTER
    let maskedBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    maskedBox.firstMaterial?.diffuse.contents = UIColor.white
    maskedBox.firstMaterial?.transparency = 0.00001
    
    let maskedBoxNode = SCNNode(geometry: maskedBox)
    maskedBoxNode.renderingOrder = 100 // LOWER than the firstBoxNode.renderingOrder
    maskedBoxNode.position = SCNVector3.init(width, 0, 0) // not place it on top of the box, we want right next to the box
    
    node.addChildNode(maskedBoxNode)
    
    return node
}

extension FloatingPoint{
    
    var degreesToRadians : Self{
        return self * .pi / 180
    }
    
    var radiansToDegrees : Self{
        return self * 180 / .pi
    }
    
}
