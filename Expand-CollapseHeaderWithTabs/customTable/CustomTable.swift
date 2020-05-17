//
//  CustomTable.swift
//  Expand-CollapseHeaderWithTabs
//
//  Created by yusef naser on 4/28/20.
//  Copyright © 2020 solutionplus. All rights reserved.
//

import UIKit

class CustomTableView : UITableView {
    
    override var adjustedContentInset: UIEdgeInsets {
        if self.frame.height > contentSize.height  {
            let heightBottom = ( self.frame.height - contentSize.height ) + 0.5
            return UIEdgeInsets(top: self.contentInset.top + 0.5 , left: self.contentInset.left , bottom: heightBottom , right: self.contentInset.right )
        }
        return UIEdgeInsets(top: self.contentInset.top + 0.5 , left: self.contentInset.left , bottom: self.contentInset.right , right: self.contentInset.right )
    }
    
    
}

class CustomCollectionView : UICollectionView {
    
    override var adjustedContentInset: UIEdgeInsets {
        if self.frame.height > contentSize.height  {
            let heightBottom = ( self.frame.height - contentSize.height ) + 0.5
            return UIEdgeInsets(top: self.contentInset.top + 0.5 , left: self.contentInset.left , bottom: heightBottom , right: self.contentInset.right )
        }
        return UIEdgeInsets(top: self.contentInset.top + 0.5 , left: self.contentInset.left , bottom: self.contentInset.right , right: self.contentInset.right )
    }
}
