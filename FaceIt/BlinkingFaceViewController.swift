//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by Veronika Hristozova on 10/7/16.
//  Copyright © 2016 Veronika Hristozova. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {

    var blinking: Bool = false {
        didSet {
            startBlink()
        }
    }
    
    private struct BlinkRate {
        static let ClosedDuration = 0.3
        static let OpenedDuration = 3
    }
    func startBlink() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(timeInterval: BlinkRate.ClosedDuration, target: self, selector: #selector(BlinkingFaceViewController.endBlink), userInfo: nil, repeats: false)
        }
    }
    
    func endBlink() {
        faceView.eyesOpen = true
         Timer.scheduledTimer(timeInterval: TimeInterval(BlinkRate.OpenedDuration), target: self, selector: #selector(BlinkingFaceViewController.startBlink), userInfo: nil, repeats: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blinking = false
    }
}
