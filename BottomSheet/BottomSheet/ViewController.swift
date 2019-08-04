//
//  ViewController.swift
//  BottomSheet
//
//  Created by Badrinath on 8/3/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button: UIButton = {
       let button = UIButton(type: UIButton.ButtonType.infoDark)
       button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showTransparent(_:)), for: UIControl.Event.touchUpInside)
        return button
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
        
        //create a blur effect
        let overlayBlur = UIBlurEffect(style: UIBlurEffect.Style.light)
        let effectView = UIVisualEffectView(effect: overlayBlur)
        effectView.frame = self.blackOverlay.bounds
        effectView.isUserInteractionEnabled = false
        
        //add the blur effectuve view to blackoverlay
        self.blackOverlay.addSubview(effectView)
        self.blackOverlay.alpha = 0
        
        //animate from alpha 0 to 1 to show the effect
        UIView.animate(withDuration: 0.5) {
            self.blackOverlay.alpha = 1
        }

        //add a target to remove the overlay
        self.blackOverlay.addTarget(self, action: #selector(removePopover), for: .touchUpInside)
    }
    
    @objc func removePopover() {
        self.blackOverlay.removeFromSuperview()
    }
}

