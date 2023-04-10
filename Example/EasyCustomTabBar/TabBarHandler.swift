//
//  TabBarHandler.swift
//  Swiftui_Example
//
//  Created by Fahad Shafiq on 03/03/2023.
//

import SwiftUI
import EasyCustomTabBar

struct TabBarHandler: View {
    
    var items: [TabItem] = [
        TabItem(title: "Home", image: Image("tab1")),
        TabItem(title: "Transaction", image: Image("tab2")),
        TabItem(title: "Budget", image: Image("tab3")),
        TabItem(title: "Profile", image: Image("tab4"))]
    
    @State var selectedTabIndex = 0
    @State var centreBtnPressed: Bool? = false
    @State var tabIndexBadges: Dictionary<Int, String>? = [3: "2", 1: "99"] // index 0 and 1 will have badge
    
    var body: some View {
        
        ZStack {
            EasyCustomTabBar(tabs: items, selection: $selectedTabIndex, tabBarStyle: .centeredButton) {
                NavigationView {
                    Tab1()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tabBarItem(tab: items[0], tabIndex: 0, selection: $selectedTabIndex)
                }
                
                Tab2()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[1], tabIndex: 1, selection: $selectedTabIndex)
                
                Tab3()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[2], tabIndex: 2, selection: $selectedTabIndex)
                
                Tab4()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[3], tabIndex: 3, selection: $selectedTabIndex)
                
                if centreBtnPressed == true {
                    CentreButtonView()
                        .onAppear {
                            tabIndexBadges?.updateValue("120", forKey: 1)
                        }
                }
            }
            .badgeItems($tabIndexBadges)
            .centreBtnPressed($centreBtnPressed)
            .tabBarShadow(true)
            .tabItemBgColor(Color.clear)
            .centreBtn(TabItem(title: "", image: Image("addIcon")))
        }
        .frame(alignment: .bottom)
        .navigationBarHidden(true)
    }
}

struct TabBarHandler_Previews: PreviewProvider {
    static var previews: some View {
        TabBarHandler()
    }
}
