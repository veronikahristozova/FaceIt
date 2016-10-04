//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Veronika Hristozova on 10/4/16.
//  Copyright © 2016 Veronika Hristozova. All rights reserved.
//

import Foundation

struct FacialExpression {
    
    enum Eyes: Int {
        case Opened
        case Closed
        case Squinting
        
    }
    
    enum EyeBrows: Int {
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedEyeBrow() -> EyeBrows {
            return EyeBrows(rawValue: -1) ?? .Relaxed
        }
        
        func moreFurrowedEyeBrow() -> EyeBrows {
            return EyeBrows(rawValue: +1) ?? .Furrowed
        }
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Smile
        case Grin
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes: Eyes
    var eyeBrows: EyeBrows
    var mouth: Mouth
    
    
}
