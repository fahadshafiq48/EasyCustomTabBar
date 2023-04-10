//
//  TabBarHandler.swift
//  Swiftui_Example
//
//  Created by Fahad Shafiq on 03/03/2023.
//

import SwiftUI
//import EasyCustomTabBar

struct TabBarHandler: View {
    
    var items: [TabItem] = [
        TabItem(title: "Home", image: Image("home")),
        TabItem(title: "Transaction", image: Image("transaction")),
        TabItem(title: "Budget", image: Image("pieChart")),
        TabItem(title: "Profile", image: Image("user"))]
    
    @State var selectedTabIndex = 0
    @State var centreBtnPressed: Bool? = false
    @State var tabIndexBadges: Dictionary<Int, String>? = [1: ""] // index 1 will have badge
    
    var body: some View {
        
        ZStack {
            EasyCustomTabBar(tabs: items, selection: $selectedTabIndex, tabBarStyle: .centeredButton) {
                NavigationView {
                    HomeVC()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tabBarItem(tab: items[0], tabIndex: 0, selection: $selectedTabIndex)
                }
                
                TransactionsVC()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[1], tabIndex: 1, selection: $selectedTabIndex)
                
                BudgetVC()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[2], tabIndex: 2, selection: $selectedTabIndex)
                
                ProfileVC()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[3], tabIndex: 3, selection: $selectedTabIndex)
                
                if centreBtnPressed == true {
                    TabBarAddVC()
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
