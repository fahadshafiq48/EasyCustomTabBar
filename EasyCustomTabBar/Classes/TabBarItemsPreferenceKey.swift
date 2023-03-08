//
//  TabBarItemsPreferenceKey.swift
//  Swiftui_Example
//
//  Created by Fahad Shafiq on 03/03/2023.
//

import Foundation
import SwiftUI

// MARK: -  Supported Tabbar Styles
public enum TabBarStyle {
    
    case simple, separate, centeredButton
}

// MARK: -  Create PreferenceKey
struct TabBarItemsPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabItem] = []
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}

// MARK: -  ViewModifier
struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabItem
    let tabIndex: Int
    @Binding var selection: Int
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tabIndex ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

// MARK: -  Extenstion
extension View {
    
    public func tabBarItem(tab: TabItem, tabIndex: Int, selection: Binding<Int>) -> some View {
        self
            .modifier(TabBarItemViewModifier(tab: tab, tabIndex: tabIndex, selection: selection))
    }
    
    func addTabBarShadow(showShodow: Bool) -> some View {
        ZStack {
            if showShodow {
                self.shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 5)
            }
        }
    }
}


