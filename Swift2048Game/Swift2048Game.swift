//
//  Swift2048Game.swift
//  Swift2048Game
//
//  Created by Kohei Iwasaki on 9/13/16.
//  Copyright © 2016 Antelos. All rights reserved.
//

import UIKit

public class Game: NSObject {
    
    public static var sharedInstance = Game()
    
    public dynamic var turn = 0
    public var boardSize = 4
    public var board = [[Int]]()
    
    override init() {
        super.init()
        for _ in 0..<self.boardSize {
            self.board.append([Int](count: self.boardSize, repeatedValue: 0))
        }
    }
    
    public func nextTurn() {
        self.generateNumber()
        self.turn += 1
    }
    
    public func swipableDirections() -> [UISwipeGestureRecognizerDirection]{
        var results = [UISwipeGestureRecognizerDirection]()
        for dir:UISwipeGestureRecognizerDirection in [.Left, .Down, .Right, .Up]{
            let slidBoard = slideBoard(dir, virtual:true)
            for i in 0..<self.boardSize {
                if !self.board[i].elementsEqual(slidBoard[i]) {
                    results.append(dir)
                    break
                }
            }
        }
        return results
    }
    
    public func slideBoard(dir: UISwipeGestureRecognizerDirection, virtual: Bool) -> [[Int]] {
        var slidBoard = self.board
        for i in 0..<self.boardSize {
            switch dir {
            case UISwipeGestureRecognizerDirection.Up:
                let slid = slideNumbers(board.map({ (line) -> Int in return line[i] }), reverse: false)
                for t in 0..<self.boardSize {
                    slidBoard[t][i] = slid[t]
                }
            case UISwipeGestureRecognizerDirection.Left:
                slidBoard[i] = slideNumbers(board[i], reverse: false)
            case UISwipeGestureRecognizerDirection.Right:
                slidBoard[i] = slideNumbers(board[i], reverse: true)
            case UISwipeGestureRecognizerDirection.Down:
                let slid = slideNumbers(board.map({ (line) -> Int in return line[i] }), reverse: true)
                for t in 0..<self.boardSize {
                    slidBoard[t][i] = slid[t]
                }
            default:
                print("unexpected direction")
            }
        }
        if !virtual{
            self.board = slidBoard
            self.nextTurn()
        }
        return slidBoard
    }
    
    public func isGameOver() -> Bool {
        return self.swipableDirections().count == 0
    }
    
    func getEmptyPositions() -> [(x:Int, y:Int)]{
        var results = [(x:Int, y:Int)]()
        for y in 0..<self.boardSize {
            for x in 0..<self.boardSize {
                if(self.board[y][x] == 0){
                    results.append((x, y))
                }
            }
        }
        return results
    }
    
    func generateNumber() {
        let empties = self.getEmptyPositions()
        
        let randomNum = arc4random_uniform(UInt32(empties.count))
        let randomPos = empties[Int(randomNum)]
        
        // Set 2 or 4
        self.board[randomPos.y][randomPos.x] = Int(arc4random_uniform(2)+1) * 2
    }
    
    // [2, 2, 0, 4] => [2, 2, 4]
    func condense(numbers: [Int]) -> [Int] {
        return numbers.filter { (num) -> Bool in
            return num != 0
        }
    }
    
    // [2, 2, 4] => [4, 4]
    func merge(numbers: [Int]) -> [Int] {
        var mergedNumbers = [Int]()
        var i = 0
        while i < numbers.count {
            if i+1 == numbers.count {
                mergedNumbers.append(numbers[i])
                break
            }
            if numbers[i] == numbers[i+1] {
                mergedNumbers.append(numbers[i] * 2)
                i += 2
            } else {
                mergedNumbers.append(numbers[i])
                i += 1
            }
        }
        return mergedNumbers
    }
    
    // [4, 4] => [4, 4, 0, 0]
    func fillBlanks(numbers: [Int]) -> [Int] {
        return numbers + [Int](count: self.boardSize-numbers.count, repeatedValue: 0)
    }
    
    // reverse=false(up, left)   : [2, 2, 0, 4] => [4, 4, 0, 0]
    // reverse=true(right, down) : [2, 2, 0, 4] => [0, 0, 4, 4]
    func slideNumbers(numbers: [Int], reverse: Bool) -> [Int] {
        if reverse {
            return fillBlanks(merge(condense(numbers.reverse()))).reverse()
        } else {
            return fillBlanks(merge(condense(numbers)))
        }
    }
}
