//
//  NotchViewController.swift
//  BottomSheet
//
//  Created by Venkatnarayansetty, Badarinath on 8/17/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import Foundation
import UIKit

class NotchViewController: UIViewController {
    
    var handleView:UIView = {
        var handleView = UIView()
        handleView.backgroundColor = UIColor.white
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.layer.cornerRadius = 4.0
        return handleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(handleView)
        
        NSLayoutConstraint.activate([
            self.handleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.handleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.handleView.heightAnchor.constraint(equalToConstant: 5),
            self.handleView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
