//
//  Token.swift
//  2048
//
//  Created by Алексей Дробот on 22.12.2023.
//

import UIKit

class Token: Equatable {
    var value: Int
    var image: UIImage?
    
    init(value: Int, image: UIImage? = nil) {
        self.value = value
        self.image = image
    }
    
    func increaseValue() {
        value *= 2
    }
    
    static func ==(lhs: Token, rhs: Token) -> Bool {
        return lhs.value == rhs.value
    }
}
