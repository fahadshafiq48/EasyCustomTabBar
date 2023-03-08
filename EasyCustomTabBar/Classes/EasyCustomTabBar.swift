//
//  EasyCustomTabBar.swift
//  Swiftui_Example
//
//  Created by Fahad Shafiq on 08/03/2023.
//

import Foundation
import SwiftUI

public struct EasyCustomTabBar<Content:View>: View {
    @Namespace var namespace
    let content: Content
    let tabs: [TabItem]
    
    @Binding private var selection: Int
    @Binding private var centreBtnPressed: Bool?
    @State private var localSelectedIndex: Int = 0
    
    // Centre Button
    private var centreBtn: TabItem = TabItem(title: "", image: Image(""))
    private var centreBtnRadius: CGFloat = 30
    private var centreBtnPadding: CGFloat = 11
    private var centreBtnOffsetY: CGFloat = -26
    private var centreBtnHeightWidth: CGFloat = 60
    private var centreBtnBgColor: Color = .blue
    private var centreBtnTextColor: Color = .white
    
    // Tab Bar
    private var tabBarStyle: TabBarStyle = .simple
    private var tabBarShadow: Bool = false
    private var tabBarCornerRadius: CGFloat = 12
    private var tabBarColor: Color = .white
    private var tabBarHeight: CGFloat = 80
    
    // Tab Item
    private var tabItemFont: Font = .system(size: 10, weight: .semibold, design: .rounded)
    private var tabItemActiveColor: Color = .blue
    private var tabItemInActiveColor: Color = .gray
    private var tabItemBgColor: Color = .clear
    
    public init(tabs: [TabItem], selection: Binding<Int>, tabBarStyle: TabBarStyle, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self._centreBtnPressed = .constant(false)
        self.content = content()
        self.tabs = tabs
        self.tabBarStyle = tabBarStyle
    }
    
    // MARK: -  BODY
    public var body: some View {
        
        ZStack(alignment: .bottom) {
            content
            
            switch tabBarStyle {
            case .simple:
                simpleTabBar
                
            case .separate:
                separateStyledTabBar
                    .onChange(of: selection) { newValue in
                        withAnimation(.easeInOut) {
                            localSelectedIndex = newValue
                        }
                    }
                
            case .centeredButton:
                centeredButtonTabBar()
            }
        }
    }
}

//MARK: TAB BAR VIEWS
extension EasyCustomTabBar {
    
    private var simpleTabBar: some View {
        HStack {
            if !tabs.isEmpty {
                ForEach(0..<tabs.count, id: \.self) { index in
                    tabViewItem(tab: tabs[index], index: index)
                        .onTapGesture {
                            selection = index
                        }
                }
            }
        }
        .padding(6)
        .addTabBarShadow(showShodow: tabBarShadow)
        .background(tabBarColor.ignoresSafeArea(edges: .bottom))
    }
    
    private var separateStyledTabBar: some View {
        HStack {
            if !tabs.isEmpty {
                ForEach(0..<tabs.count, id: \.self) { index in
                    itemWithBG(tab: tabs[index], index: index)
                        .onTapGesture {
                            selection = index
                        }
                }
            }
        }
        .padding(6)
        .background(tabBarColor.ignoresSafeArea(edges: .bottom))
        .cornerRadius(tabBarCornerRadius)
        .addTabBarShadow(showShodow: tabBarShadow)
        .padding(.horizontal)
    }
    
    private func centeredButtonTabBar() -> some View {
        return VStack {
            Spacer()
            ZStack {
                CentreButtonTabBarShape(cornerRadius: tabBarCornerRadius, buttonRadius: centreBtnRadius, buttonPadding: centreBtnPadding)
                    .fill(tabBarColor)
                    .frame(height: tabBarHeight)
                    .addTabBarShadow(showShodow: tabBarShadow)
                    .overlay(
                        Button(action: {
                            centreBtnPressed?.toggle()
                        }, label: {
                            VStack {
                                centreBtn.image
                                if centreBtn.title != "" {
                                    Text(centreBtn.title)
                                        .font(tabItemFont)
                                        .foregroundColor(centreBtnTextColor)
                                }
                            }
                            .frame(width: centreBtnHeightWidth, height: centreBtnHeightWidth, alignment: .center)
                            .background(centreBtnBgColor)
                            .cornerRadius(centreBtnHeightWidth / 2)
                        }).offset(x: 0, y: centreBtnOffsetY)
                    )
                
                HStack(spacing: 70) {
                    
                    if !tabs.isEmpty {
                        let itemsOnFirstStack = tabs.count % 2 == 0 ? tabs.count/2 : tabs.count/2 - 1
                        let itemsOnSecondStack = (tabs.count % 2 == 0 ? tabs.count/2 : tabs.count/2) + itemsOnFirstStack
                        
                        HStack {
                            ForEach(0..<itemsOnFirstStack, id: \.self) { index in
                                tabViewItem(tab: tabs[index], index: index)
                                    .onTapGesture {
                                        selection = index // Switch the tab
                                    }
                            }
                        }
                        HStack {
                            ForEach(itemsOnFirstStack..<itemsOnSecondStack, id: \.self) { index in
                                tabViewItem(tab: tabs[index], index: index)
                                    .onTapGesture {
                                        selection = index // Switch the tab
                                    }
                            }
                        }
                    }
                }
                .padding([.horizontal], 16)
                .padding([.bottom], 10)
            }
        }.ignoresSafeArea()
    }
}

//MARK: TAB BAR ITEM VIEWS
extension EasyCustomTabBar {
    
    private func tabViewItem(tab: TabItem, index: Int) -> some View {
        VStack {
            tab.image
            Text(tab.title)
                .font(tabItemFont)
        }
        .foregroundColor(selection == index ? tabItemActiveColor : tabItemInActiveColor)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(tabItemBgColor)
    }
    
    private func itemWithBG(tab: TabItem, index: Int) -> some View {
        VStack {
            tab.image
            Text(tab.title)
                .font(tabItemFont)
        }
        .foregroundColor(localSelectedIndex == index ? tabItemActiveColor : tabItemInActiveColor)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelectedIndex == index {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tabItemBgColor)
                        .matchedGeometryEffect(id: "bg_rectangle", in: namespace)
                }
            }
        )
    }
}

extension EasyCustomTabBar {
    
    //MARK: Centre Button Methods
    
    public func centreBtnPressed(_ value: Binding<Bool?>) -> Self {
        var newSelf = self
        newSelf._centreBtnPressed = value
        return newSelf
    }
    
    public func centreBtn(_ value: TabItem) -> Self {
        var newSelf = self
        newSelf.centreBtn = value
        return newSelf
    }
    
    public func centreBtnRadius(_ value: CGFloat) -> Self {
        var newSelf = self
        newSelf.centreBtnRadius = value
        return newSelf
    }
    
    public func centreBtnPadding(_ value: CGFloat) -> Self {
        var newSelf = self
        newSelf.centreBtnPadding = value
        return newSelf
    }
    
    public func centreBtnOffsetY(_ value: CGFloat) -> Self {
        var newSelf = self
        newSelf.centreBtnOffsetY = value
        return newSelf
    }
    
    public func centreBtnHeightWidth(_ value: CGFloat) -> Self {
        var newSelf = self
        newSelf.centreBtnHeightWidth = value
        return newSelf
    }
    
    public func centreBtnBgColor(_ value: Color) -> Self {
        var newSelf = self
        newSelf.centreBtnBgColor = value
        return newSelf
    }
    
    public func centreBtnTextColor(_ value: Color) -> Self {
        var newSelf = self
        newSelf.centreBtnTextColor = value
        return newSelf
    }
    
    //MARK: Tab bar Methods
    public func tabBarShadow(_ value: Bool) -> Self {
        var newSelf = self
        newSelf.tabBarShadow = value
        return newSelf
    }
    
    public func tabBarCornerRadius(_ value: CGFloat) -> Self {
        var newSelf = self
        newSelf.tabBarCornerRadius = value
        return newSelf
    }
    
    public func tabBarColor(_ value: Color) -> Self {
        var newSelf = self
        newSelf.tabBarColor = value
        return newSelf
    }
    
    public func tabBarHeight(_ value: CGFloat) -> Self {
        var newSelf = self
        newSelf.tabBarHeight = value
        return newSelf
    }
    
    //MARK: Tab Item Methods
    public func tabItemFont(_ value: Font) -> Self {
        var newSelf = self
        newSelf.tabItemFont = value
        return newSelf
    }
    
    public func tabItemActiveColor(_ value: Color) -> Self {
        var newSelf = self
        newSelf.tabItemActiveColor = value
        return newSelf
    }
    
    public func tabItemInActiveColor(_ value: Color) -> Self {
        var newSelf = self
        newSelf.tabItemInActiveColor = value
        return newSelf
    }
    
    public func tabItemBgColor(_ value: Color) -> Self {
        var newSelf = self
        newSelf.tabItemBgColor = value
        return newSelf
    }
    
}

