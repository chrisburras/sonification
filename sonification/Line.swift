//
//  Line.swift
//  sonification
//
//  Created by Amit Enand on 2/21/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Line{
    var start: CGPoint
    var end: CGPoint
    var color: SKColor
    init(start _start: CGPoint, end _end: CGPoint, color _color: SKColor){
        start = _start
        end = _end
        color = _color
    }
}
