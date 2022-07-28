//
//  Dictionary+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/07/22.
//

import Foundation

public extension Dictionary {
    
    /// Map Dictionary keys to another keys
    /// Key generated must be unique, otherwise it will replace the duplicated value with the last one mapped
    /// - Parameter mapper: Closure that map the old keys to the new one
    /// - Returns: New dictionary with new set of keys
    func mapKeys<NewKey: Hashable>(_ mapper: (Key) -> NewKey) -> Dictionary<NewKey, Value> {
        var newDictionary: [NewKey: Value] = [:]
        forEach { pair in
            let newKey = mapper(pair.key)
            newDictionary[newKey] = pair.value
        }
        return newDictionary
    }
    
    /// Map Dictionary keys to another keys
    /// If new key is nil, it will then ignore it and proceed with next key
    /// Key generated must be unique, otherwise it will replace the duplicated value with the last one mapped
    /// - Parameter mapper: Closure that map the old keys to the new one
    /// - Returns: New dictionary with new set of keys
    func compactMapKeys<NewKey: Hashable>(_ mapper: (Key) throws -> NewKey?) -> Dictionary<NewKey, Value> {
        var newDictionary: [NewKey: Value] = [:]
        forEach { pair in
            guard let newKeyThrowable = try? mapper(pair.key), let newKey = newKeyThrowable else { return }
            newDictionary[newKey] = pair.value
        }
        return newDictionary
    }
}
