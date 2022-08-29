//
//  Helper.swift
//  ChartsExample
//
//  Created by Tim Owings on 8/9/22.
//

import Foundation
import SwiftUI


struct Wtx: ViewModifier {
    
    let fontName: String
    let fontSize: CGFloat
    let fgColor: Color
    let pad: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(fontName, size: fontSize))
            .foregroundColor(fgColor)
            .padding(pad)
    }
}

struct FontSize: ViewModifier {
       
    let fontSize: CGFloat
    let fgColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .foregroundColor(fgColor)
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

func chartDate(ts: String) -> String {
    
    let df = DateFormatter()
    df.locale = Locale.current
    df.dateFormat = "yyyy-MM-dd"
    let dt = df.date(from: ts)
    df.dateFormat = "MM-dd"
    let str = df.string(from: dt!)
    return str
}
