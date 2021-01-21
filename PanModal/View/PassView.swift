//
//  PassView.swift
//  PanModal
//
//  Created by Roberto Lopez on 1/20/21.
//  Copyright © 2021 Detail. All rights reserved.
//

#if os(iOS)
import UIKit

public class PassView: UIView {
    
    var presentingView: UIView? = nil

    public init(presentingView: UIView, frame: CGRect) {
        super.init(frame: frame)
        self.presentingView = presentingView
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("hit test")
        return presentingView?.hitTest(point, with: event);
    }
}

#endif
