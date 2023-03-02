//
//  ObservableProperty.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation
import UIKit

typealias VoidClosure = (() -> Void)

typealias Key = String

struct PropertyObserver<V> {
    typealias Identifier = String
    
    private(set) weak var target: AnyObject?
    let key: Key?
    let callback: ((V) -> Void)
    
    internal var identifer: Identifier? {
        if let key = key {
            return key
        }
        
        return (target?.hash).flatMap { hash in
            return Identifier(hash)
        }
    }
    
    init(uniqueTarget: AnyObject, callback: @escaping ((V) -> Void)) {
        self.key = nil
        self.target = uniqueTarget
        self.callback = callback
    }
    
    init(key: Key, callback: @escaping ((V) -> Void)) {
        self.key = key
        self.target = nil
        self.callback = callback
    }
}

class ObservableProperty<V> {
    var value: V {
        didSet {
            notifyObservers()
        }
    }
    var observers: [PropertyObserver<V>] = []
    
    init(value: V) {
        self.value = value
    }
    
    fileprivate func notifyObservers() {
        for (index, observer) in observers.enumerated().reversed() {
            guard observer.identifer != nil else {
                observers.remove(at: index)
                continue
            }
            observer.callback(value)
        }
    }
    
    static func +=(left: inout ObservableProperty, right: PropertyObserver<V>) {
        // Replace observer if exists for this identifier.
        left.observers = left.observers.compactMap { handler in
            guard handler.identifer != right.identifer else {
                return nil
            }
            return handler
        }
        
        left.observers.append(right)
    }
    
    static func -=(left: inout ObservableProperty, right: PropertyObserver<V>) {
        left.observers = left.observers.compactMap { handler in
            guard handler.identifer != right.identifer else {
                return nil
            }
            return handler
        }
    }
    
    static func -=(left: inout ObservableProperty, right: AnyObject) {
        let mappedRight = PropertyObserver<V>(uniqueTarget: right, callback: { _ in })
        left -= mappedRight
    }
    
    static func -=(left: inout ObservableProperty, right: Key) {
        let mappedRight = PropertyObserver<V>(key: right, callback: { _ in })
        left -= mappedRight
    }
}
