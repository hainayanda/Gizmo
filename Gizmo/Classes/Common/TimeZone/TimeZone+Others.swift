//
//  TimeZone+Others.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 28/9/22.
//

import Foundation

public extension TimeZone {
    
    // MARK: Antarctica
    
    enum Antarctica: String, CaseIterable {
        case casey = "Antarctica/Casey"
        case davis = "Antarctica/Davis"
        case dumontDUrville = "Antarctica/DumontDUrville"
        case macquarie = "Antarctica/Macquarie"
        case mawson = "Antarctica/Mawson"
        case mcMurdo = "Antarctica/McMurdo"
        case palmer = "Antarctica/Palmer"
        case rothera = "Antarctica/Rothera"
        case southPole = "Antarctica/South_Pole"
        case syowa = "Antarctica/Syowa"
        case troll = "Antarctica/Troll"
        case vostok = "Antarctica/Vostok"
    }
    
    // MARK: Arctic
    
    enum Arctic: String, CaseIterable {
        case longyearbyen = "Arctic/Longyearbyen"
    }
    
    // MARK: Atlantic
    
    enum Atlantic: String, CaseIterable {
        case azores = "Atlantic/Azores"
        case bermuda = "Atlantic/Bermuda"
        case canary = "Atlantic/Canary"
        case capeVerde = "Atlantic/Cape_Verde"
        case faroe = "Atlantic/Faroe"
        case madeira = "Atlantic/Madeira"
        case reykjavik = "Atlantic/Reykjavik"
        case southGeorgia = "Atlantic/South_Georgia"
        case stHelena = "Atlantic/St_Helena"
        case stanley = "Atlantic/Stanley"
    }
}
