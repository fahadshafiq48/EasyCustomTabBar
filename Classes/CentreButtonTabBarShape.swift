//
//  CentreButtonTabBarShape.swift
//  Swiftui_Example
//
//  Created by Fahad Shafiq on 08/03/2023.
//

import Foundation
import SwiftUI

struct CentreButtonTabBarShape: Shape {
    
    @State var cornerRadius: CGFloat
    @State var buttonRadius: CGFloat
    @State var buttonPadding: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        path.move(to: .init(x: 0, y: rect.height))
        path.addLine(to: .init(x: 0, y: rect.height - cornerRadius))
        path.addArc(withCenter: .init(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)
        
        let lineEnd = rect.width/2 - 2 * buttonPadding - buttonRadius
        path.addLine(to: .init(x: lineEnd, y: 0))
        path.addArc(withCenter: .init(x: lineEnd, y: buttonPadding), radius: buttonPadding, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        path.addArc(withCenter: .init(x: rect.width/2, y: buttonPadding), radius: buttonPadding + buttonRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: false)
        
        let lineStart = rect.width/2 + 2 * buttonPadding + buttonRadius
        path.addArc(withCenter: .init(x: lineStart, y: buttonPadding), radius: buttonPadding, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)
        
        path.addLine(to: .init(x: rect.width - cornerRadius, y: 0))
        path.addArc(withCenter: .init(x: rect.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        path.addLine(to: .init(x: rect.width, y: rect.height))
        path.close()
        
        return Path(path.cgPath)
    }
}
