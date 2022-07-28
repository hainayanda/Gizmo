//
//  DictionaryExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class DictionaryExtensionsSpec: QuickSpec {
    
    override func spec() {
        let dictionary = [1: "one", 2: "two", 3: "three", 4: "four", 5: "five"]
        it("should map dictionary keys") {
            let newDictionary = dictionary.mapKeys { "\($0)" }
            expect(newDictionary).to(equal(["1": "one", "2": "two", "3": "three", "4": "four", "5": "five"]))
        }
        it("should compact map dictionary keys") {
            let newDictionary = dictionary.compactMapKeys { $0 < 5 ? "\($0)" : nil }
            expect(newDictionary).to(equal(["1": "one", "2": "two", "3": "three", "4": "four"]))
        }
    }
}
