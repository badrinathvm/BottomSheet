//
//  BottomSheetLauncher.swift
//  BottomSheet
//
//  Created by Venkatnarayansetty, Badarinath on 8/3/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetLauncher: NSObject {
    
    let bottomSheetView:UIView = {
        let sheet = UIView()
        sheet.backgroundColor = UIColor.white
        sheet.translatesAutoresizingMaskIntoConstraints = false
        return sheet
    }()
    
    var notchView: UIView = {
        let notchView = UIView()
        notchView.backgroundColor = UIColor.blue
        notchView.translatesAutoresizingMaskIntoConstraints = false
        notchView.layer.cornerRadius = 4.0
        return notchView
    }()
    
    let notch:UIView = {
        let notchView = UIView()
        notchView.translatesAutoresizingMaskIntoConstraints = false
        return notchView
    }()
    
    override init() {
        super.init()
    }
    
    func showBootmView(rootView: UIView) {
        rootView.addSubview(bottomSheetView)
        notch.addSubview(notchView)
        rootView.addSubview(notch)
        
        self.bottomSheetView.backgroundColor = UIColor.white
        self.notch.backgroundColor = UIColor.clear
        
        let screenSize = UIScreen.main.bounds
        let referenceHeight:CGFloat = 200
        
        NSLayoutConstraint.activate([
            self.bottomSheetView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            self.bottomSheetView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: screenSize.height - referenceHeight),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor),
            
            self.notch.topAnchor.constraint(equalTo: rootView.topAnchor, constant: screenSize.height - referenceHeight - 24),
            self.notch.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            self.notch.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            self.notch.heightAnchor.constraint(equalToConstant: 24),
            
            self.notchView.centerXAnchor.constraint(equalTo: self.notch.centerXAnchor),
            self.notchView.topAnchor.constraint(equalTo: self.notch.topAnchor, constant: 9),
            self.notchView.heightAnchor.constraint(equalToConstant: 6),
            self.notchView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func dimsissBottomView() {
        self.bottomSheetView.removeFromSuperview()
        self.notch.removeFromSuperview()
    }
}
