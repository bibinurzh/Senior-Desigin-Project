//
//  LocationTextAnnotationNode.swift
//  AugmentedReality
//
//  Created by Bibinur on 11/9/19.
//  Copyright © 2019 Bibinur. All rights reserved.
//

import Foundation
import SceneKit
import CoreLocation
import ARKit

open class LocationTextAnnotationNode: LocationNode {
    
    // image and text that are displayed by the child nodes
    //public let image: UIImage
    public let text: String
    
    // child nodes
    public let imageAnnotationNode: SCNNode
    public let textAnnotationNode: SCNNode
    
    public init(location: CLLocation?, text: String) {
        self.text = text
        //self.image = image
        
        // create the child node that holds the location's marker image
        /*let imagePlane = SCNPlane(width: image.size.width / 100, height: image.size.height / 100)
        imagePlane.firstMaterial!.diffuse.contents = image
        imagePlane.firstMaterial!.lightingModel = .constant
        */
        let plane = SCNPlane(width: 120.0, height: 24.0)
        //plane.cornerRadius = 0.5
        plane.firstMaterial?.isDoubleSided = true
        plane.firstMaterial?.diffuse.contents = UIColor(red: 74/255.0, green: 35/255.0, blue: 90/255.0, alpha: 0.8)
        imageAnnotationNode = SCNNode()
        imageAnnotationNode.geometry = plane
        
        // create the child node that holds the location's name
        let textShape = SCNText(string: text, extrusionDepth: 1)
        textShape.firstMaterial!.diffuse.contents = UIColor.white
        textShape.firstMaterial!.specular.contents = UIColor.black
        textShape.firstMaterial!.lightingModel = .phong
        textShape.isWrapped = true
        textShape.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        
        textAnnotationNode = SCNNode()
        textAnnotationNode.geometry = textShape
        
        // initializer ARCL's LocationNode
        super.init(location: location)
        scaleRelativeToDistance = true
        
        // apply a billboard constraint so the parent node, so it always faces the user
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardConstraint]
        
        // add the child nodes
        addChildNode(imageAnnotationNode)
        addChildNode(textAnnotationNode)
        
        // center text correctly around (x) and below (y) origin (SCNText's origins in in the bottom left corner)
        let min = textAnnotationNode.boundingBox.min
        let max = textAnnotationNode.boundingBox.max
        textAnnotationNode.pivot = SCNMatrix4MakeTranslation((max.x - min.x) / 2, (max.y - min.y), 0);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
