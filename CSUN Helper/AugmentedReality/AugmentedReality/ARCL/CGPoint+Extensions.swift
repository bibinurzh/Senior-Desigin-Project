//
//  CGPoint+Extensions.swift
//  AugmentedReality
//
//  Created by Bibinur on 11/9/19.
//  Copyright © 2019 Bibinur. All rights reserved.
//

import UIKit
import SceneKit

extension CGPoint {
    static func pointWithVector(vector: SCNVector3) -> CGPoint {
        return CGPoint(x: CGFloat(vector.x), y: CGFloat(0 - vector.z))
    }

    func radiusContainsPoint(radius: CGFloat, point: CGPoint) -> Bool {
        let x = pow(point.x - self.x, 2)
        let y = pow(point.y - self.y, 2)
        let radiusSquared = pow(radius, 2)

        return x + y <= radiusSquared
    }
}
