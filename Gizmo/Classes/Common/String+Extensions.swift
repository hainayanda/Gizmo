//
//  String+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/07/22.
//

import Foundation

public extension String {
    
    /// convert String to its base 64 encoded string
    var asBase64: String {
        Data(self.utf8).base64EncodedString()
    }
    
}
