//
//  ViewController.swift
//  Expand-CollapseHeaderWithTabs
//
//  Created by yusef naser on 4/18/20.
//  Copyright © 2020 solutionplus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightView : NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let headerViewMaxHeight : CGFloat = 250
    let headerViewMinHeight : CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CellScrollView.self , forCellWithReuseIdentifier: "cell")

        
        if let l = collectionView.collectionViewLayout as? ExpandableFlowLayout {
            l.scrollDirection = .horizontal
        }
        
    }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 // the number of tabs you want
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellScrollView
        cell.scrollView.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
}

extension ViewController : UIScrollViewDelegate {
    
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let y: CGFloat = scrollView.contentOffset.y
         guard let headerViewHeightConstraint = heightView else {return}
         let newHeaderViewHeight: CGFloat =
                   headerViewHeightConstraint.constant - y
         if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
         } else if newHeaderViewHeight <= headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
         } else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
         }
       }
    
}

