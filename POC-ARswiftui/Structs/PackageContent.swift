//
//  packageContent.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 22/06/22.
//

import Foundation
import SwiftUI
struct PackageContent: Identifiable {
    var name: String
    var imageName: String
    var price: NSDecimalNumber
    var description: String
    var pdfName: String
    var isBought: Bool
    var isAvailable: Bool
    var id: String { name }
}
