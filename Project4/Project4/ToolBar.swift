//
//  ToolBar.swift
//  Project4
//
//  Created by Oh Sang Young on 2015. 12. 13..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

//
// 메소드 호출을 추적하기 위해서 확장을 했다. 
// 기능 추가는 없다.
//
class ToolBar: UIToolbar {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override func didAddSubview(subview: UIView) {
        logDebug(subview.description)
    }

    override func willRemoveSubview(subview: UIView) {
        logDebug(subview.description)
    }

}
