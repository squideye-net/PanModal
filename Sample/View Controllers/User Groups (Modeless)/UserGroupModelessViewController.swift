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
    
    override var isModeless: Bool {
        return true
    }
    
    override var panModalBackgroundColor: UIColor {
        return UIColor.clear
    }
}
