//
//  CentreButtonView.swift
//  EasyCustomTabBar_Example
//
//  Created by Fahad Shafiq on 08/03/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

struct CentreButtonView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.yellow.opacity(0.8), Color.yellow.opacity(0.3)], startPoint: .bottom, endPoint: .top)
            
            VStack(spacing: 15) {
                Text("Hi!")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                
                Text("I'm in Centre Button View")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
            }
            .frame(alignment: .bottom)
            .padding([.bottom], 105)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CentreButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CentreButtonView()
    }
}
