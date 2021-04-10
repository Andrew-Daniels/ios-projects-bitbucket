//
//  Animator.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/4/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

enum AnimationType {
    case ShrinkFadeIn
    case ShrinkFadeOut
    case BounceIn
    case BounceOut
    case Rotate180Clockwise
    case Rotate180CounterClockwise
}

class Animation {
    var animationType: AnimationType!
    var viewToAnimate: UIView!
    var animationDuration: TimeInterval!
    
    init(view: UIView, type: AnimationType) {
        self.viewToAnimate = view
        self.animationType = type
        self.animationDuration = 0.3
    }
    
    init(view: UIView, type: AnimationType, duration: TimeInterval) {
        self.viewToAnimate = view
        self.animationType = type
        self.animationDuration = duration
    }
}

class Animator {
    
    static func animate(animations: [Animation]) {
        for animation in animations {
            animate(animation: animation)
        }
    }
    
    static func animate(animation: Animation) {
        switch animation.animationType {
        case .ShrinkFadeIn:
            shrinkFadeIn(view: animation.viewToAnimate, duration: animation.animationDuration)
            break
        case .ShrinkFadeOut:
            shrinkFadeOut(view: animation.viewToAnimate, duration: animation.animationDuration)
            break
        case .BounceIn:
            break
        case .BounceOut:
            break
        case .Rotate180Clockwise:
            rotate180Clockwise(view: animation.viewToAnimate, duration: animation.animationDuration)
            break
        case .Rotate180CounterClockwise:
            rotate180CounterClockwise(view: animation.viewToAnimate, duration: animation.animationDuration)
            break
        case .none:
            break
        }
    }
    
    static func animate(view: UIView, withType: AnimationType, withDuration: TimeInterval) {
        animate(animation: Animation(view: view, type: withType, duration: withDuration))
    }
    
    static func animate(view: UIView, withType: AnimationType) {
        animate(animation: Animation(view: view, type: withType))
    }
    
    private static func shrinkFadeIn(view: UIView, duration: TimeInterval) {
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.alpha = 0
        UIView.animate(withDuration: duration) {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            view.alpha = 1
        }
        view.isHidden = false
    }
    
    private static func shrinkFadeOut(view: UIView, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            view.alpha = 0
        }
        view.isHidden = true
    }
    
    private static func rotate180Clockwise(view: UIView, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    private static func rotate180CounterClockwise(view: UIView, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }
    }
}
