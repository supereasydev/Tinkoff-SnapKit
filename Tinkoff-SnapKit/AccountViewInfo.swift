//
//  AccountViewInfo.swift
//  Tinkoff-SnapKit
//
//  Created by Eduard on 04.01.2023.
//

import UIKit

struct AccountViewInfo {
    let currency: Currency
    let amount: Int
    let cardName: String
    let cards: [CardThumbnailInfo]
}

enum Currency {
    case rub
    case usd
    case eur
}

struct CardThumbnailInfo {
    let image: UIImage
    let id: String
}
