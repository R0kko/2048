//
//  TokenView.swift
//  2048
//
//  Created by Алексей Дробот on 22.12.2023.
//

import UIKit

class TokenView: UIView {
    var token: Token? {
        didSet {
            if let token = token {
                label.text = "\(token.value)"
                backgroundColor = backgroundColorForValue(token.value)
            } else {
                label.text = ""
                backgroundColor = .lightGray
            }
        }
    }

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAppearance() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

    private func backgroundColorForValue(_ value: Int) -> UIColor {
        switch value {
        case 2, 4:
            return .yellow
        case 8, 16:
            return .orange
        case 32, 64:
            return .red
        default:
            return .green
        }
    }
}
