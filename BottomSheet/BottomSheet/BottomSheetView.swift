//
//  BottomSheetView.swift
//  BottomSheet
//
//  Created by Venkatnarayansetty, Badarinath on 8/3/19.
//  Copyright © 2019 Badrinath. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetView: UIView  {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        self.addSubview(collectionView)
        
         collectionView.backgroundColor = UIColor.white
    
        let screenSize = UIScreen.main.bounds
         let referenceHeight:CGFloat = 200
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: screenSize.height - referenceHeight),
            self.collectionView.heightAnchor.constraint(equalToConstant: referenceHeight)
        ])
        
    }
}

