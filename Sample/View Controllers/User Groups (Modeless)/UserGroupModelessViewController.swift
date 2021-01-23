//
//  UserGroupsModeless.swift
//  PanModalDemo
//
//  Created by Roberto Lopez on 1/21/21.
//  Copyright © 2021 Detail. All rights reserved.
//

import UIKit

class UserGroupModelessViewController: UserGroupViewController {
    
    // MARK: - Pan Modal Presentable
    
    var heights: [PanModalHeight] = [.contentHeight(100.0), .contentHeight(320.0), .contentHeight(700.0)]
    var heightIndex: Int = 0
    var isGoingShort: Bool = false
    var interationEnabled: Bool = true
    var isAnimating: Bool = false
    
    var isGoingLong: Bool {
        return !isGoingShort
    }
    
    override var isModeless: Bool {
        return true
    }
    
    override var panModalBackgroundColor: UIColor {
        return UIColor.clear
    }
    
    override var shortFormHeight: PanModalHeight {
        if isGoingShort {
            if heightIndex == 0 {
                return heights[heightIndex]
            }
            return heights[heightIndex - 1]
        }
        
        // else is going long
        
        if heightIndex == heights.count - 1 {
            return heights[heightIndex - 1]
        }
        
        return heights[heightIndex]
    }
    
    override var longFormHeight: PanModalHeight {
        if isGoingShort {
            if heightIndex == 0 {
                return heights[heightIndex + 1]
            }
            return heights[heightIndex]
        }
        
        // else is going long
        
        if heightIndex == heights.count - 1 {
            return heights[heightIndex]
        }
        
        return heights[heightIndex + 1]
    }
    
    override var transitionDuration: Double {
        return 0.5
    }
    
    override func willTransition(to state: PanModalPresentationController.PresentationState, on yPos: CGFloat) {
        
        // modify the meaning of long/short depending on the intended direction
        switch(state) {
        
        case .longForm:
            isGoingShort = false
            
        case .shortForm:
            isGoingShort = true
        }
        
        heightIndex = nearest(to: yPos, inValues: heights)
        print("W: \(yPos) \(getContentHeight(from: heights[heightIndex])) \(heightIndex) \(isGoingShort ? "short" : "long")")
        
        self.panModalSetNeedsLayoutUpdate()
    }
    
    override func didTransition(to state: PanModalPresentationController.PresentationState, on yPos: CGFloat) {
        heightIndex = nearest(to: yPos, inValues: heights)
        self.panModalSetNeedsLayoutUpdate()
        print("D: \(yPos) \(getContentHeight(from: heights[heightIndex])) \(heightIndex) \(isGoingShort ? "short" : "long")")
    }
    
    func getContentHeight(from height: PanModalHeight) -> CGFloat {
        return topMargin(from: height) + topOffset + ((isGoingShort) ? 100.0 : -100.0)
    }
    
    func nearest(to number: CGFloat, inValues values: [PanModalHeight]) -> Int {
        guard let nearestIndex =
          values.enumerated()
                .min(by: { (lhs, rhs) -> Bool in
                    return abs(number - getContentHeight(from: lhs.element)) < abs(number - getContentHeight(from: rhs.element))
                    
                })
        else {
            return 0
        }
        return nearestIndex.offset
   }
    
    override var allowsDragToDismiss: Bool {
        return false;
    }
    
    override func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        if isAnimating {
            print("should respond? but is animating")
        }
        return true //return !isAnimating
    }
}
