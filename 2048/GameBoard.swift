//
//  GameBoard.swift
//  2048
//
//  Created by Алексей Дробот on 22.12.2023.
//

import Foundation

class GameBoard {
    private var tokens: [[Token?]]
    var size: Int { return tokens.count }
    
    init(size: Int = 4) {
        tokens = Array(repeating: Array(repeating: nil, count: size), count: size)
        addRandomToken()
        addRandomToken()
    }
    
    func addRandomToken() {
        var emptyPositions: [(Int, Int)] = []
        for i in 0..<size {
            for j in 0..<size {
                if tokens[i][j] == nil {
                    emptyPositions.append((i, j))
                }
            }
        }
        
        guard !emptyPositions.isEmpty else { return }
        let randomPosition = emptyPositions[Int(arc4random_uniform(UInt32(emptyPositions.count)))]
        tokens[randomPosition.0][randomPosition.1] = Token(value: 2) // начальное значение токена
    }
    
    func swipeLeft() {
        for i in 0..<size {
            var line = tokens[i].compactMap { $0 }
            merge(&line)
            tokens[i] = line + Array(repeating: nil, count: size - line.count)
        }
        addRandomToken()
    }
    
    func swipeRight() {
        for i in 0..<size {
            var line = Array(tokens[i].compactMap { $0 }.reversed())
            merge(&line)
            line.reverse()
            tokens[i] = Array(repeating: nil, count: size - line.count) + line
        }
        addRandomToken()
    }
    
    func swipeUp() {
        var movedOrMerged = false

        for col in 0..<size {
            var line = (0..<size).compactMap { tokens[$0][col] }
            let originalLine = line
            merge(&line)

            if line != originalLine {
                movedOrMerged = true
            }

            for row in 0..<line.count {
                tokens[row][col] = line[row]
            }
            for row in line.count..<size {
                tokens[row][col] = nil
            }
        }

        if movedOrMerged {
            addRandomToken()
        }
    }

    func swipeDown() {
        var movedOrMerged = false

        for col in 0..<size {
            var line = Array((0..<size).compactMap { tokens[$0][col] }.reversed())

            let originalLine = Array(line)

            merge(&line)

            if line != originalLine {
                movedOrMerged = true
            }

            for (row, token) in line.enumerated() {
                tokens[size - row - 1][col] = token
            }
            for row in 0..<(size - line.count) {
                tokens[row][col] = nil
            }
        }

        if movedOrMerged {
            addRandomToken()
        }
    }

    
    func isGameOver() -> Bool {
        for i in 0..<size {
            for j in 0..<size {
                // Проверяем, пуста ли текущая ячейка
                if tokens[i][j] == nil {
                    return false
                }
                
                // Проверяем соседние ячейки на наличие возможности слияния
                if j < size - 1, let current = tokens[i][j], let right = tokens[i][j + 1], current.value == right.value {
                    return false
                }
                if i < size - 1, let current = tokens[i][j], let bottom = tokens[i + 1][j], current.value == bottom.value {
                    return false
                }
            }
        }
        
        return true
    }
    
    private func merge(_ line: inout [Token]) {
        var index = 0
        while index < line.count - 1 {
            if line[index].value == line[index + 1].value {
                line[index].value *= 2
                line.remove(at: index + 1)
                index += 1
            } else {
                index += 1
            }
        }
    }


    
    func getToken(at row: Int, col: Int) -> Token? {
        guard row >= 0 && row < size && col >= 0 && col < size else { return nil }
        return tokens[row][col]
    }
}
