//
//  ViewController.swift
//  Tinkoff-SnapKit
//
//  Created by Eduard on 04.01.2023.
//

import SnapKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "TinkoffBackgroundColor")
        let accountView = AccountView()
        let info = AccountViewInfo(currency: .eur, amount: 100, cardName: "Tinkoff Black EUR", cards: [CardThumbnailInfo(image: UIImage(named: "card")!, id: ""), CardThumbnailInfo(image: UIImage(named: "card")!, id: ""), CardThumbnailInfo(image: UIImage(named: "card")!, id: "")])
        accountView.configure(with: info)
        view.addSubview(accountView)
        accountView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
