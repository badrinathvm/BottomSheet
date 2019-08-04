//
//  ViewController.swift
//  BottomSheet
//
//  Created by Badrinath on 8/3/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var containerView:UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var notchView: UIView = {
        let notchView = UIView()
        notchView.backgroundColor = UIColor.blue
        notchView.layer.cornerRadius = 4.0
        return notchView
    }()
    
     let bottomLauncher = BottomSheetLauncher()
    
    
    let button: UIButton = {
       let button = UIButton(type: UIButton.ButtonType.infoDark)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(showTransparent(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.yellow
        return cv
    }()


    
    public fileprivate(set) var blackOverlay: UIControl = UIControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.button.widthAnchor.constraint(equalToConstant: 20),
            self.button.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func showTransparent(_ sender: UIButton) {
        //Get the rootView
        guard let rootView = UIApplication.shared.keyWindow else {
            return
        }

        //configure black overlay adn add ot the rootview
        self.blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blackOverlay.frame = rootView.bounds
        self.blackOverlay.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        rootView.addSubview(self.blackOverlay)
       
        //bottomLauncher.showBootmView(rootView: rootView)
        
        
        rootView.addSubview(self.collectionView)
        containerView.addSubview(notchView)
        rootView.addSubview(containerView)
        
        let screenWidth = UIScreen.main.bounds
        self.notchView.frame = CGRect(x: screenWidth.size.width / 3 + 40, y: 9, width: 50, height: 6)
        self.containerView.frame = CGRect(x: 0, y: rootView.frame.height, width: rootView.frame.width, height: 24)

        let referenceHeight:CGFloat = 200
        let y = rootView.frame.height - referenceHeight
        self.collectionView.frame = CGRect(x: 0, y: rootView.frame.height, width: rootView.frame.width, height: referenceHeight)
        

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
        self.blackOverlay.removeFromSuperview()
        bottomLauncher.dimsissBottomView()
        //self.bottomSheetView.removeFromSuperview()
        //self.notch.removeFromSuperview()
        //self.collectionView.removeFromSuperview()
    }
}

