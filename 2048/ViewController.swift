//
//  ViewController.swift
//  2048
//
//  Created by Алексей Дробот on 22.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var gameBoardView: GameBoardView!
    var gameBoard: GameBoard!
    var restartButton: UIButton!
    var movesLabel: UILabel!
    var movesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupGame()
        setupViews()
        layoutViews()
        setupGestures()
    }
    
    func setupGame() {
        gameBoard = GameBoard()
    }
    
    func setupViews() {
        gameBoardView = GameBoardView(board: gameBoard)
        gameBoardView.layer.borderColor = UIColor.red.cgColor
        gameBoardView.layer.borderWidth = 1 
        view.addSubview(gameBoardView)
        
        restartButton = UIButton(type: .system)
        restartButton.setTitle("Начать игру заново", for: .normal)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        view.addSubview(restartButton)
        
        movesLabel = UILabel()
        movesLabel.text = "Сделано ходов: \(movesCount)"
        view.addSubview(movesLabel)
    }
    
    func layoutViews() {
        restartButton.pin.bottom(50).horizontally(10).height(40)
        
        movesLabel.pin.above(of: restartButton).marginBottom(10).horizontally(10).height(20)
        
        let availableHeight = view.bounds.height - restartButton.frame.height - movesLabel.frame.height - 100
        let gameBoardSize = min(view.bounds.width, availableHeight) - 20
        
        gameBoardView.pin.above(of: movesLabel).marginTop(12).horizontally(10).height(gameBoardSize)
    }
    
    
    @objc func restartGame() {
        gameBoard = GameBoard()
        gameBoardView.board = gameBoard
        gameBoardView.updateView()
        movesCount = 0
        movesLabel.text = "Сделано ходов: \(movesCount)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
    }
    
    func setupGestures() {
        let swipeDirections: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in swipeDirections {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeGesture.direction = direction
            gameBoardView.addGestureRecognizer(swipeGesture)
        }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            gameBoard.swipeUp()
        case .down:
            gameBoard.swipeDown()
        case .left:
            gameBoard.swipeLeft()
        case .right:
            gameBoard.swipeRight()
        default:
            break
        }
        gameBoardView.updateView()
        movesCount += 1
        movesLabel.text = "Сделано ходов: \(movesCount)"
        
        if gameBoard.isGameOver() {
            showGameOverAlert()
        }
    }
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Игра окончена", message: "Хотите начать заново?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.restartGame()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
