//
//  AccountViewCardCell.swift
//  Tinkoff-SnapKit
//
//  Created by Eduard on 04.01.2023.
//

import SnapKit
import UIKit

class AccountViewCardCell: UICollectionViewCell {
    // MARK: - Public
    func configure(with image: UIImage) {
        cardImageView.image = image
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private properties
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
}

// MARK: - Private methods
private extension AccountViewCardCell {
    func initialize() {
        contentView.addSubview(cardImageView)
        cardImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
