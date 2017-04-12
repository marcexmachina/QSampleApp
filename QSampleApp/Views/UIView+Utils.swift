//
//  UIView+Utils.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 11/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
 
  internal var width: CGFloat {
    get {
      return self.frame.size.width
    }
    set {
      self.frame.size.width = newValue
    }
  }
  
  internal var height: CGFloat {
    get {
      return self.frame.size.height
    }
    set {
      self.frame.size.height = newValue
    }
  }
  
  internal var centerX: CGFloat {
    get {
      return self.center.x
    }
    set {
      self.center = CGPoint(x: newValue, y: self.center.y)
    }
  }
  
  internal var centerY: CGFloat {
    get {
      return self.center.y
    }
    set {
      self.center = CGPoint(x: self.center.x, y: newValue)
    }
  }

  
}
