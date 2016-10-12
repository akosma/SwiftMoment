//
//  LazyBox.swift
//
//  Created by Ole Begemann on 17.12.15.
//  Copyright © 2016 Ole Begemann. All rights reserved.
//

import Foundation

/// An enumeration used by the LazyBox class.
///
/// - notYetComputed->T: This value holds a block to be lazily executed.
/// - computed:          Indicating that the computation has already happened.
internal enum LazyValue<T> {
    case notYetComputed(() -> T)
    case computed(T)
}


/// Adapted to Swift 3 from
/// https://oleb.net/blog/2015/12/lazy-properties-in-structs-swift/
internal final class LazyBox<T> {
    init(computation: @escaping () -> T) {
        val = .notYetComputed(computation)
    }

    private var val: LazyValue<T>

    /// All reads and writes of `_value` must happen on this queue.
    private let queue = DispatchQueue(label: "LazyBox._value")

    /// Performs the lazy computation, or returns the value stored.
    var value: T {
        var returnValue: T? = nil
        queue.sync {
            switch self.val {
            case .notYetComputed(let computation):
                let result = computation()
                self.val = .computed(result)
                returnValue = result
            case .computed(let result):
                returnValue = result
            }
        }
        assert(returnValue != nil)
        return returnValue!
    }
}
