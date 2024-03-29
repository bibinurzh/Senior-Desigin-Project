//
//  RouteSegmentAnnotationNode.swift
//  AugmentedReality
//
//  Created by Bibinur on 11/9/19.
//  Copyright © 2019 Bibinur. All rights reserved.
//

import Foundation
import SceneKit
import CoreLocation

open class RouteSegmentAnnotationNode: LocationNode {
    
    public let routeNode: SCNNode
    public let textNode: SCNNode
    
    public init(startNode: RouteAnnotationNode, endNode: RouteAnnotationNode) {
        
        // the node is set between the start and end locations
        let startLocation = startNode.location!
        let endLocation = endNode.location!
        let coordinateInBetween = CLLocationCoordinate2D(latitude: (startLocation.coordinate.latitude + endLocation.coordinate.latitude)/2.0,
                                   longitude: (startLocation.coordinate.longitude + endLocation.coordinate.longitude)/2.0)
        let locationInBetween = CLLocation(coordinate: coordinateInBetween,
                                           altitude: (startLocation.altitude + endLocation.altitude)/2.0)
        
        routeNode = LineNode(startPosition: startNode.position, endPosition: endNode.position)
        textNode = TextNode(startLocation: startLocation, endLocation: endLocation)
        
        super.init(location: locationInBetween)
        scaleRelativeToDistance = true
        
        addChildNode(routeNode)
        //addChildNode(textNode)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TextNode: SCNNode {
    
    init(startLocation: CLLocation, endLocation: CLLocation) {
        super.init()
        
        let distance = Int( round( startLocation.distance(from: endLocation)))
        
        let textShape = SCNText(string: "\(distance) m", extrusionDepth: 1)
        textShape.firstMaterial!.diffuse.contents = UIColor.white
        textShape.firstMaterial!.specular.contents = UIColor.black
        textShape.firstMaterial!.lightingModel = .phong
        textShape.isWrapped = true
        textShape.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        
        let textNode = SCNNode()
        textNode.geometry = textShape
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardConstraint]
        
        addChildNode(textNode)
        
        // center text correctly around the origin (x axis only) (SCNText's origins in in the bottom left corner)
        let min = textNode.boundingBox.min
        let max = textNode.boundingBox.max
        textNode.pivot = SCNMatrix4MakeTranslation((max.x - min.x) / 2, 0, 0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class LineNode: SCNNode{
    
    init(startPosition: SCNVector3, endPosition: SCNVector3) {
        super.init()
        
        let distance = distanceBetweenScenePoints(pointA: startPosition, pointB: endPosition)
        
        position = startPosition
        
        let endNode = SCNNode()
        
        endNode.position = endPosition
        
        let ndZAlign = SCNNode()
        ndZAlign.eulerAngles.x = Float.pi/2
        
         let cylgeo = SCNBox(width: 1.75, height: distance, length: 1.75, chamferRadius: 0.25)
               //SCNBox(width: 5, height: distance, length: 5, chamferRadius: 0)
               cylgeo.firstMaterial!.diffuse.contents = UIColor.green
        cylgeo.firstMaterial!.specular.contents = UIColor.black
        cylgeo.firstMaterial!.lightingModel = .phong
        // cylgeo.firstMaterial!.fillMode = .lines // used for debug purposes
        
        let ndCylinder = SCNNode(geometry: cylgeo)
        ndCylinder.position.y = Float(-distance/2) + 0.001
        ndZAlign.addChildNode(ndCylinder)
        
        addChildNode(ndZAlign)
        
        constraints = [SCNLookAtConstraint(target: endNode)]
    }
    
    
    func distanceBetweenScenePoints(pointA: SCNVector3, pointB: SCNVector3) -> CGFloat {
        let distance = sqrt(
            (pointA.x - pointB.x) * (pointA.x - pointB.x) +
            (pointA.y - pointB.y) * (pointA.y - pointB.y) +
            (pointA.z - pointB.z) * (pointA.z - pointB.z)
        )
        return CGFloat(distance)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
