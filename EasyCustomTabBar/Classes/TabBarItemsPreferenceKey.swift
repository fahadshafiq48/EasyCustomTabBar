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

struct BadgeViewModifier: ViewModifier {
    let text: String?
    let badgeFont: Font?
    let badgeBgColor: Color?
    let badgeTextColor: Color?
    
    func body(content: Content) -> some View {
        
        if #available(iOS 15.0, *) {
            content
            .overlay(alignment: .top) {
                if text != nil, text != "" {
                    text.map { value in
                        Text(value)
                            .fixedSize(horizontal: true, vertical: false)
                            .font(badgeFont)
                            .foregroundColor(badgeTextColor)
                            .padding(.horizontal, value.count == 1 ? 2 : 6)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(badgeBgColor ?? .red)
                                    .if(value.count == 1) { $0.aspectRatio(1, contentMode: .fill) }
                            )
                            .offset(x: 16, y: -2)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            ZStack {
                content
                if text != nil, text != "" {
                    text.map { value in
                        Text(value)
                            .fixedSize(horizontal: true, vertical: false)
                            .font(badgeFont)
                            .foregroundColor(badgeTextColor)
                            .padding(.horizontal, value.count == 1 ? 2 : 6)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(badgeBgColor ?? .red)
                                    .if(value.count == 1) { $0.aspectRatio(1, contentMode: .fill) }
                            )
                            .offset(x: 12, y: -20)
                    }
                }
            }
        }
    }
}

// MARK: -  Extenstion
extension View {
    
    public func tabBarItem(tab: TabItem, tabIndex: Int, selection: Binding<Int>) -> some View {
        self.modifier(TabBarItemViewModifier(tab: tab, tabIndex: tabIndex, selection: selection))
    }
    
    func addTabBarShadow(showShodow: Bool) -> some View {
        ZStack {
            if showShodow {
                self.shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 5)
            }
        }
    }
    
    func customBadge(value: String?, badgeFont: Font?, badgeBgColor: Color?, badgeTextColor: Color?) -> some View {
        modifier(BadgeViewModifier(text: value, badgeFont: badgeFont, badgeBgColor: badgeBgColor, badgeTextColor: badgeTextColor))
    }
    
    @ViewBuilder func `if`<Result: View>(_ condition: Bool, closure: @escaping (Self) -> Result) -> some View {
        if condition {
            closure(self)
        } else {
            self
        }
    }
}



