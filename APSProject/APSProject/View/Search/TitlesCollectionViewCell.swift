//
//  TitlesCollectionCell.swift
//  CineTime
//
//  Created by Brena Amorim on 16/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class TitlesCollectionCell: UICollectionViewCell {

    var imageTitle: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        Setup()
    }
    
    override func prepareForReuse() {
        imageTitle.image = nil
    }
    
    func Setup() {
        self.backgroundColor = .clear
        self.addSubview(imageTitle)
        self.tintColor = .actionColor

        imageTitle.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 105, height: 151)
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.yellow.cgColor
                layer.borderWidth = 2
            } else {
                layer.borderColor = UIColor.clear.cgColor
                layer.borderWidth = 0
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
