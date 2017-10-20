//
//  SCNNode+Extensions.swift
//  Taper
//
//  Created by Marc O'Neill on 20/10/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import Foundation
import ARKit

extension SCNNode {

  func distance(to: SCNNode) -> Float {
    let dx = to.position.x - position.x
    let dy = to.position.y - position.y
    let dz = to.position.z - position.z
    return sqrtf(dx*dx + dy*dy + dz*dz)
  }
  
}
