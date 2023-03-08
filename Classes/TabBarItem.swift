//
//  TabBarItem.swift
//  Swiftui_Example
//
//  Created by Fahad Shafiq on 03/03/2023.
//

import Foundation
import SwiftUI

public struct TabItem: Equatable, Identifiable {
    public let id = UUID()
    public var title: String
    public var image: Image
}
