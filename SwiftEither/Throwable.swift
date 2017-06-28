//
// Created by Atsushi Miyake on 2017/06/29.
// Copyright (c) 2017 Atsushi Miyake. All rights reserved.
//

import Foundation

protocol Throwable: Error {
    var cause: Error? { set get }
    init(_ error: Error)
}
