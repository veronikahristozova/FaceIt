//
//  ViewController.swift
//  FaceIt
//
//  Created by Veronika Hristozova on 10/3/16.
//  Copyright © 2016 Veronika Hristozova. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    // MARK: - Model
    
    var expression = FacialExpression(eyes: .Opened, eyeBrows: .Normal, mouth: .Smile) { didSet { updateUI() } }
    
    // MARK: View
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(recognizer:))))
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Smirk: -0.5, .Neutral: 0.0]
    
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]
    
    //    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
    //        if recognizer.state == .ended {
    //            switch expression.eyes {
    //            case .Opened: expression.eyes = .Closed
    //            case .Closed: expression.eyes = .Opened
    //            case .Squinting: break
    //            }
    //        }
    //    }
    private struct Animation {
        static var ShakeAngle = CGFloat(M_PI/6)
        static let ShakeDuration = 0.4
    }
    @IBAction func shakeHead(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: Animation.ShakeDuration,
                       animations: {
                        self.faceView.transform = CGAffineTransform(rotationAngle: Animation.ShakeAngle)
        }) { (finished) in
            if finished {
                UIView.animate(withDuration: Animation.ShakeDuration,
                               animations: {
                                self.faceView.transform = CGAffineTransform(rotationAngle: -Animation.ShakeAngle)
                }) { (finished) in
                    if finished {
                        Animation.ShakeAngle = CGFloat(M_PI*(-2))
                        UIView.animate(withDuration: Animation.ShakeDuration,
                                       animations: {
                                        self.faceView.transform = CGAffineTransform(rotationAngle: Animation.ShakeAngle)
                        }) { (finished) in
                            if finished {
                                Animation.ShakeAngle = CGFloat(M_PI/6)
                            }
                        }
                    }
                }
            }
        }
    }
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Opened: faceView.eyesOpen = true
            case .Closed: faceView.eyesOpen = false
            case .Squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
}

