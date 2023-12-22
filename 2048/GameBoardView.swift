//
//  GameBoardView.swift
//  2048
//
//  Created by Алексей Дробот on 22.12.2023.
//

import UIKit
import PinLayout

class GameBoardView: UIView {
    var board: GameBoard
    var tokenViews: [[TokenView]] = []
    
    init(board: GameBoard) {
        self.board = board
        super.init(frame: .zero)
        setupBoard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBoard() {
        for _ in 0..<board.size {
            var rowViews: [TokenView] = []
            for _ in 0..<board.size {
                let tokenView = TokenView()
                addSubview(tokenView)
                rowViews.append(tokenView)
            }
            tokenViews.append(rowViews)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tokenSize = frame.width / CGFloat(board.size)
        for (row, rowViews) in tokenViews.enumerated() {
            for (col, tokenView) in rowViews.enumerated() {
                tokenView.pin
                    .top(CGFloat(row) * tokenSize)
                    .left(CGFloat(col) * tokenSize)
                    .width(tokenSize)
                    .height(tokenSize)
            }
        }
    }
    
    func updateView() {
        for (row, rowViews) in tokenViews.enumerated() {
            for (col, tokenView) in rowViews.enumerated() {
                let token = board.getToken(at: row, col: col)
                tokenView.token = token
                if let token = token {
                    tokenView.backgroundColor = colorForValue(token.value)
                    tokenView.label.text = "\(token.value)"
                } else {
                    tokenView.backgroundColor = .lightGray
                    tokenView.label.text = ""
                }
            }
        }
    }
    
    private func colorForValue(_ value: Int) -> UIColor {
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
