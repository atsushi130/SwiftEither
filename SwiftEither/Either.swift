//
// Created by Atsushi Miyake on 2017/06/29.
// Copyright (c) 2017 Atsushi Miyake. All rights reserved.
//

import Foundation

enum Either<Left: Throwable, Right> {

    case left(Left)
    case right(Right)

    func map<U>(f: (Right) throws -> U) -> Either<Left, U> {
        switch self {
        case let .left(left): return .left(left)
        case let .right(right):
            do {
                return .right(try f(right))
            } catch let error as Left {
                return .left(error)
            } catch let error {
                return .left(Left(error))
            }
        }
    }

    func flatMap<U>(f: (Right) throws -> Either<Left, U>) -> Either<Left, U> {
        switch self {
        case let .left(left): return .left(left)
        case let .right(right):
            do {
                return try f(right).fold {
                    switch $0 {
                    case let .left(left):   return .left(left)
                    case let .right(right): return .right(right)
                    }
                }
            } catch let error as Left {
                return .left(error)
            } catch let error {
                let left = Left(error)
                return .left(left)
            }
        }
    }
    
    func fold<U>(f: (Either<Left, Right>) -> U) -> U {
            return f(self)
    }
}
