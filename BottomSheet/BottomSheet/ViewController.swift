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

    var overlayBlur: UIBlurEffect?
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
        print("Show background layer")
        
        //prepareBackgroundView()
        
        guard let rootView = UIApplication.shared.keyWindow else {
            return
        }

        self.blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blackOverlay.frame = UIScreen.main.bounds
        self.blackOverlay.backgroundColor = UIColor(white: 1, alpha: 0.5)
        rootView.addSubview(self.blackOverlay)

        self.overlayBlur = UIBlurEffect(style: UIBlurEffect.Style.light)
        let effectView = UIVisualEffectView(effect: overlayBlur)
        effectView.frame = self.blackOverlay.bounds
        effectView.isUserInteractionEnabled = false
        self.blackOverlay.addSubview(effectView)
        //self.blackOverlay.alpha = 0
        
        self.blackOverlay.addTarget(self, action: #selector(removePopover), for: .touchUpInside)
    }
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        bluredView.backgroundColor = UIColor.yellow
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    @objc func removePopover() {
        print("Remove popover")
        self.blackOverlay.removeFromSuperview()
    }
}

