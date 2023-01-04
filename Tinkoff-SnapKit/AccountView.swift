//
//  AccountView.swift
//  Tinkoff-SnapKit
//
//  Created by Eduard on 04.01.2023.
//

import SnapKit
import UIKit

class AccountView: UIView {
    // MARK: - Public
    func configure(with info: AccountViewInfo) {
        currencySignImageView.image = makeCurrencySignImage(for: info.currency)
        amountLabel.text = makeAmountText(for: info.amount, currency: info.currency)
        cardNameLabel.text = info.cardName
        cards = info.cards
        collectionView.reloadData()
    }

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let creditCardHeight: CGFloat = 30
        static let creditCardWidth: CGFloat = 45
        static let currencySignImageSize: CGFloat = 40
        static let xStackSpacing: CGFloat = 16
        static let yStackSpacing: CGFloat = 4
        static let amountLabelFontSize: CGFloat = 17
        static let collectionViewToCardNameSpacing: CGFloat = 12
        static let viewCornerRadius: CGFloat = 16
    }

    // MARK: - Private properties
    private let currencySignImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: UIConstants.amountLabelFontSize, weight: .bold)
        return label
    }()

    private let cardNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()

    private var collectionView: UICollectionView!
    private var cards: [CardThumbnailInfo] = []
}

// MARK: - Private methods
private extension AccountView {
    func initialize() {
        layer.cornerRadius = UIConstants.viewCornerRadius
        backgroundColor = UIColor(named: "TinkoffThemeColor")
        let yStack = UIStackView()
        yStack.axis = .vertical
        yStack.spacing = UIConstants.yStackSpacing
        yStack.addArrangedSubview(amountLabel)
        yStack.addArrangedSubview(cardNameLabel)
        yStack.setCustomSpacing(UIConstants.collectionViewToCardNameSpacing, after: cardNameLabel)
        
        let layout = makeCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AccountViewCardCell.self, forCellWithReuseIdentifier: String(describing: AccountViewCardCell.self))
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.creditCardHeight)
        }
        
        yStack.addArrangedSubview(collectionView)
        
        let xStack = UIStackView()
        xStack.axis = .horizontal
        xStack.alignment = .top
        xStack.spacing = UIConstants.xStackSpacing
        currencySignImageView.snp.makeConstraints { make in
            make.size.equalTo(UIConstants.currencySignImageSize)
        }
        xStack.addArrangedSubview(currencySignImageView)
        xStack.addArrangedSubview(yStack)
        
        addSubview(xStack)
        xStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.contentInset)
        }
    }

    func makeCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }

    func makeCurrencySignImage(for currency: Currency) -> UIImage? {
        return UIImage(systemName: "star")
    }

    func makeAmountText(for amount: Int, currency: Currency) -> String {
        var currencySign: String {
            switch currency {
            case .eur:
                return "€"
            case .usd:
                return "$"
            case .rub:
                return "₽"
            }
        }
        return "\(amount) \(currencySign)"
    }
}

// MARK: - UICollectionViewDataSource
extension AccountView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AccountViewCardCell.self), for: indexPath) as! AccountViewCardCell
        cell.configure(with: cards[indexPath.item].image)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AccountView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIConstants.creditCardWidth, height: UIConstants.creditCardHeight)
    }
}
