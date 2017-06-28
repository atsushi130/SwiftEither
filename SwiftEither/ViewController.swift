//
//  ViewController.swift
//  SwiftEither
//
//  Created by Atsushi Miyake on 2017/06/29.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let either: Either<MyError, Int> = Either.left(MyError())
        // let either: Either<MyError, Int> = Either.right(2)
        either.map {
            $0 * 2
        }.map {
            Either<MyError, Int>.right($0)
        }.flatMap {
            $0
        }.fold {
            switch $0 {
            case let .left(left):   print(left)
            case let .right(right): print(right)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class MyError: Throwable {

    var cause: Error?

    init() {

    }

    required init(_ error: Error) {
        self.cause = error
    }
    
    func method() {
        
    }
}
