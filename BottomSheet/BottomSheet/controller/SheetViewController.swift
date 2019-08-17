//
//  SheetViewController.swift
//  BottomSheet
//
//  Created by Venkatnarayansetty, Badarinath on 8/4/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import Foundation
import UIKit

class SheetViewController: UIViewController {
    
    public let containerView = UIView()
    
    /// The view that can be pulled to resize a sheeet.
    public let pullBarView = UIView()
    
    let bottomLauncher: BottomSheetLauncher = {
       let bottomLauncher = BottomSheetLauncher()
        return bottomLauncher
    }()
    
    let containerVC = ContainerViewController()
    let notchVC = NotchViewController()
    var heightConstraint:NSLayoutConstraint!
    var notchBottomConstraint:NSLayoutConstraint!
    
    public fileprivate(set) var blackOverlay: UIControl = UIControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
    
        //setup containerView ( this view contains the place holder for the notch )
        
        //setup pullbar view ( small notch and setting contraints to it )
        
        //setup childViewController ( this view is the bottom sheet )
        
        //Also add Blur effect View
        
        //bottomLauncher.showBootmView(rootView: rootView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setupContainerView()
    }
    
    func setupContainerView() {
        containerVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerVC.view)
        
        notchVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(notchVC.view)
        
        heightConstraint =  containerVC.view.heightAnchor.constraint(equalToConstant: 0)
        notchBottomConstraint = notchVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([
            containerVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            heightConstraint,
            
            //notchHeightConstraint,
            notchVC.view.heightAnchor.constraint(equalToConstant: 20),
            notchVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            notchVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            notchBottomConstraint
        ])
        
        self.add(containerVC)
        self.add(notchVC)
        
        let screenSize = UIScreen.main.bounds
        let heightValue = screenSize.size.height / 2
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.notchBottomConstraint.constant = -heightValue
            self.heightConstraint.constant =  heightValue
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //deactivate constraints
        heightConstraint.isActive = false
        notchBottomConstraint.isActive = false

        //remove from super view
        self.view.removeFromSuperview()
    }
}
