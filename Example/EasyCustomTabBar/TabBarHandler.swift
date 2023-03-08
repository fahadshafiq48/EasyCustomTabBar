//
//  TabBarHandler.swift
//  Swiftui_Example
//
//  Created by Fahad Shafiq on 03/03/2023.
//

import SwiftUI
import EasyCustomTabBar

struct TabBarHandler: View {
    
    let items: [TabItem] = [
        TabItem(title: "Tab 1", image: Image("tab1")),
        TabItem(title: "Tab 2", image: Image("tab2")),
        TabItem(title: "Tab 3", image: Image("tab3")),
        TabItem(title: "Tab 4", image: Image("tab4"))]
    
    @State var selectedTabIndex = 0
    @State var centreBtnPressed: Bool? = false
    
    var body: some View {
        
        ZStack {
            
            // tabBarStyle: This will change the view of your tabbar
            EasyCustomTabBar(tabs: items, selection: $selectedTabIndex, tabBarStyle: .simple) {
                Tab1()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[0], tabIndex: 0, selection: $selectedTabIndex)

                Tab2()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[1], tabIndex: 1, selection: $selectedTabIndex)

                Tab3()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[2], tabIndex: 2, selection: $selectedTabIndex)

                Tab4()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabBarItem(tab: items[3], tabIndex: 3, selection: $selectedTabIndex)

                // [Optional] In case of centred button tabbar style write the below code
                if centreBtnPressed == true {
                    CentreButtonView()
                }
            }
            // In case of centred button tabbar style write the
            .centreBtnPressed($centreBtnPressed)
            .tabBarShadow(true)
            .tabItemBgColor(Color.clear)
            .tabItemActiveColor(Color.blue)
            
//            .centreBtn(TabItem(title: "", image: Image("addIcon")))
            
            // if you want to change centre button image on its action the do this
            .centreBtn(centreBtnPressed == true ? TabItem(title: "", image: Image("closeIcon")) : TabItem(title: "", image: Image("addIcon")))
//            .tabItemCornerRadius(12)
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
