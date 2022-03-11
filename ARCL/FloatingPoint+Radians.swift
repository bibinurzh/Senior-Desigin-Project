//
//  FloatingPoint+Radians.swift
//  AugmentedReality
//
//  Created by Bibinur on 11/9/19.
//  Copyright © 2019 Bibinur. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    public var degreesToRadians: Self { return self * .pi / 180 }
    public var radiansToDegrees: Self { return self * 180 / .pi }
}
