//
//  HapinessViewController.swift
//  Happiness
//
//  Created by Chris Maury on 1/10/16.
//  Copyright © 2016 Chris Maury. All rights reserved.
//

import UIKit

class HapinessViewController: UIViewController, faceViewDataSource {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
        
    }
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .Ended: fallthrough
            case .Changed:
                let translation = gesture.translationInView(faceView)
                let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
                if happinessChange != 0 {
                 happiness += happinessChange
                 gesture.setTranslation(CGPointZero, inView: faceView)
                }
            default: break
        }
    }

    
    var happiness: Int = 50 {
        didSet {
            happiness - min(max(happiness, 0), 100)
            updateUI()
            print("happiness = \(happiness)")
        }
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50/5)
        
    }
    func updateUI() {
        faceView.setNeedsDisplay()
        
    }
}
