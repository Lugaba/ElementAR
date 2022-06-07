//
//  CellContent.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 07/06/22.
//

import Foundation
import SwiftUI
struct CellContent: Identifiable {
    var color: Color
    var name: String
    var icon: Image
    var id: String { name }
}
