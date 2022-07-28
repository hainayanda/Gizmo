//
//  StringExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class StringExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should convert string to base64") {
            let helloWorld = "Hello World!"
            expect(helloWorld.asBase64).to(equal("SGVsbG8gV29ybGQh"))
        }
    }
}
