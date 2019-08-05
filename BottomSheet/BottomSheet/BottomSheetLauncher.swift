//
//  BottomSheetLauncher.swift
//  BottomSheet
//
//  Created by Venkatnarayansetty, Badarinath on 8/3/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetLauncher: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    var notchView: UIView = {
        let notchView = UIView()
        notchView.backgroundColor = UIColor.white
        notchView.translatesAutoresizingMaskIntoConstraints = false
        notchView.layer.cornerRadius = 4.0
        return notchView
    }()
    
    let notchComponent:UIView = {
        let notchView = UIView()
        notchView.translatesAutoresizingMaskIntoConstraints = false
        notchView.backgroundColor = UIColor.clear
        return notchView
    }()
    
    public fileprivate(set) var blackOverlay: UIControl = UIControl()
    
    var bottomViewTopConstraint:NSLayoutConstraint!
    var notchTopConstraint:NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showBootmView(rootView: UIView) {
        
        self.blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blackOverlay.frame = rootView.bounds
        self.blackOverlay.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        self.blackOverlay.alpha = 0
        
        [self.blackOverlay, collectionView, notchComponent].forEach { view in
             rootView.addSubview(view)
        }
        
        notchComponent.addSubview(notchView)
        notchComponent.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        let screenSize = UIScreen.main.bounds
        let referenceHeight:CGFloat = 400
        
        bottomViewTopConstraint = self.collectionView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: rootView.frame.height)
        notchTopConstraint = self.notchComponent.topAnchor.constraint(equalTo: rootView.topAnchor, constant: screenSize.height - referenceHeight - 24)
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            bottomViewTopConstraint!,
            self.collectionView.heightAnchor.constraint(equalToConstant: referenceHeight),
            //self.bottomSheetView.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor),
            
            //self.notchComponent.topAnchor.constraint(equalTo: rootView.topAnchor, constant: screenSize.height - referenceHeight - 24),
            notchTopConstraint!,
            self.notchComponent.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            self.notchComponent.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            self.notchComponent.heightAnchor.constraint(equalToConstant: 24),
            
            self.notchView.centerXAnchor.constraint(equalTo: self.notchComponent.centerXAnchor),
            self.notchView.topAnchor.constraint(equalTo: self.notchComponent.topAnchor, constant: 9),
            self.notchView.heightAnchor.constraint(equalToConstant: 6),
            self.notchView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        self.bottomViewTopConstraint.constant = screenSize.height - referenceHeight
        self.notchTopConstraint.constant = screenSize.height - referenceHeight - 24
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.blackOverlay.alpha = 1
            self.layoutIfNeeded()
        }, completion: nil)
        
        self.blackOverlay.addTarget(self, action: #selector(dimsissBottomView), for: .touchUpInside)
    }
    
    @objc func dimsissBottomView() {
        [ blackOverlay , notchComponent , collectionView ].forEach { view in
            view.removeFromSuperview()
        }
    }
}
