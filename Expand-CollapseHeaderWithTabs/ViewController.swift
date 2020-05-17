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
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    let headerViewMaxHeight : CGFloat = 250
    let headerViewMinHeight : CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CellScrollView.self , forCellWithReuseIdentifier: "cellScroll")
        collectionView.register(CellTableView.self , forCellWithReuseIdentifier: "cellTable")
        
        if let l = collectionView.collectionViewLayout as? ExpandableFlowLayout {
            l.scrollDirection = .horizontal
        }
        
        viewHeader.isUserInteractionEnabled = true
        viewHeader.addGestureRecognizer(UIPanGestureRecognizer(target: self , action: #selector(handlePanGesture(_:))))
        
    }
    
    @objc private func handlePanGesture (_ gesture : UIPanGestureRecognizer ) {
        let translation = gesture.translation(in: viewHeader)
        gesture.setTranslation(CGPoint(x: translation.x , y: 0.0), in:  viewHeader )
        if translation.y > 0 && heightView.constant == headerViewMaxHeight {
            return
        }
        if translation.y < 0 && heightView.constant == headerViewMinHeight {
            return
        }
        if let cell = collectionView.visibleCells.first as? CellScrollView {
            cell.scrollView.contentOffset.y = cell.scrollView.contentOffset.y - translation.y
        }else if let cell = collectionView.visibleCells.first as? CellTableView {
            cell.tableView.contentOffset.y = cell.tableView.contentOffset.y - translation.y
        }

    }
    
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 // the number of tabs you want
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellScroll", for: indexPath) as! CellScrollView
            cell.scrollView.delegate = self
            cell.scrollView.setContentOffset(.zero , animated: false )
            return cell
        }else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTable", for: indexPath) as! CellTableView
            cell.tableView.delegate = self
            cell.tableView.dataSource = self 
            cell.tableView.setContentOffset(.zero , animated: false )
            return cell
        }
     
        return UICollectionViewCell()
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

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "index : \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
