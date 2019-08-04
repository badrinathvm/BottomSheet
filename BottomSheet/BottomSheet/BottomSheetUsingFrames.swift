//
//  BottomSheetUsingFrames.swift
//  BottomSheet
//
//  Created by Venkatnarayansetty, Badarinath on 8/4/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetUsingFrames: NSObject {
    
    let containerView:UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var notchView: UIView = {
        let notchView = UIView()
        notchView.backgroundColor = UIColor.white
        notchView.layer.cornerRadius = 4.0
        return notchView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    public fileprivate(set) var blackOverlay: UIControl = UIControl()
    
    func showBottomSheet(rootView: UIView) {
        
        self.blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blackOverlay.frame = rootView.bounds
        self.blackOverlay.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        [self.blackOverlay, collectionView, containerView].forEach { view in
            rootView.addSubview(view)
        }
        
        containerView.addSubview(notchView)
        
        let screenWidth = UIScreen.main.bounds
        notchView.frame = CGRect(x: screenWidth.size.width / 2, y: 9, width: 50, height: 6)
        containerView.frame = CGRect(x: 0, y: rootView.frame.height, width: rootView.frame.width, height: 24)
        
        let referenceHeight:CGFloat = 200
        let y = rootView.frame.height - referenceHeight
        collectionView.frame = CGRect(x: 0, y: rootView.frame.height, width: rootView.frame.width, height: referenceHeight)
        
        //create a blur effect
        let overlayBlur = UIBlurEffect(style: UIBlurEffect.Style.light)
        let effectView = UIVisualEffectView(effect: overlayBlur)
        effectView.frame = self.blackOverlay.bounds
        effectView.isUserInteractionEnabled = false
        
        //add the blur effectuve view to blackoverlay
        //self.blackOverlay.addSubview(effectView)
        self.blackOverlay.alpha = 0
        
        //animate from alpha 0 to 1 to show the effect
        UIView.animate(withDuration: 0.5) {
            self.blackOverlay.alpha = 1
            
            self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            self.containerView.frame = CGRect(x: 0, y: y - 20, width: rootView.frame.width, height: 20)
        }
        
        //add a target to remove the overlay
        self.blackOverlay.addTarget(self, action: #selector(removePopover), for: .touchUpInside)
    }
    
    @objc func removePopover() {
        [ blackOverlay , notchView , collectionView ].forEach { view in
            view.removeFromSuperview()
        }
    }
}
