//
//  ViewController.swift
//  BottomSheet
//
//  Created by Badrinath on 8/3/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bottomLauncher = BottomSheetLauncher()
    let bottomLauncherUsingFrames = BottomSheetUsingFrames()
     let sheetVc = SheetViewController()
    
    let button: UIButton = {
       let button = UIButton(type: UIButton.ButtonType.infoDark)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(showTransparent(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
        
    var heightConstraint:NSLayoutConstraint!
    
    public fileprivate(set) var blackOverlay: UIControl = UIControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        sheetVc.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sheetVc.view)
        
        NSLayoutConstraint.activate([
            sheetVc.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            sheetVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sheetVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            sheetVc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    // Below code is if we wanna make use of BottomSheetLauncher or BottomLauncher Using frames.
    
    func usingBootmSheetLauncherORFrames() {
        //Get the rootView
        guard let rootView = UIApplication.shared.keyWindow else {
            return
        }
        
        self.blackOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blackOverlay.frame = rootView.bounds
        self.blackOverlay.backgroundColor = UIColor.lightGray
        self.blackOverlay.alpha = 1
        
        rootView.addSubview(self.blackOverlay)
        bottomLauncher.showBootmView(rootView: rootView)
        
        //bottomLauncherUsingFrames.showBottomSheet(rootView: rootView)
    }

}









