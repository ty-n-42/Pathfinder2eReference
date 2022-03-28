//
//  Styles.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 20/3/2022.
//

import SwiftUI

// from https://colorcodes.io/
//let neonRed: Color = Color(red: 210.0 / 255.0, green: 39.0 / 255.0, blue: 48.0 / 255.0, opacity: 1.0)
//let maroon: Color = Color(red: 128.0 / 255.0, green: 0.0, blue: 0.0, opacity: 1.0)
//let crimson: Color = Color(red: 220.0 / 255.0, green: 20.0 / 255.0, blue: 60.0 / 255.0, opacity: 1.0)
//let hotPink: Color = Color(red: 1.0, green: 105.0 / 255.0, blue: 180.0 / 255.0, opacity: 1.0)
//let mediumVioletRed: Color = Color(red: 199.0 / 255.0, green: 21.0 / 255.0, blue: 133.0 / 255.0, opacity: 1.0)
//let paleVioletRed: Color = Color(red: 219.0 / 255.0, green: 112.0 / 255.0, blue: 147.0 / 255.0, opacity: 1.0)
let tomato: Color = Color(red: 1.0, green: 99.0 / 255.0, blue: 71.0 / 255.0, opacity: 1.0)
let royalBlue: Color = Color(red: 65.0 / 255.0, green: 105.0 / 255.0, blue: 225.0 / 255.0, opacity: 1.0)
//let limegreen: Color = Color(red: 50.0 / 255.0, green: 205.0 / 255.0, blue: 50.0 / 255.0, opacity: 1.0)
let mediumseagreen: Color = Color(red: 60.0 / 255.0, green: 179.0 / 255.0, blue: 113.0 / 255.0, opacity: 1.0)

/**
 text for a 1st level sub-heading, optionally padded at the top
 */
struct HeadingText: ViewModifier {
    let padded: Bool
    
    func body(content: Content) -> some View {
        if padded {
            content
                .font(.title3)
                .foregroundStyle(.foreground)
                .padding(.top)
        } else {
            content
                .font(.title3)
                .foregroundStyle(.foreground)
        }
    }
}

/**
 text enclosed in a rounded edge border; colored with color (defaults to gray). padded for a horizontal list.
 */
struct ColoredListText: ViewModifier {
    let color: Color?
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(2.0)
            .padding([.leading, .trailing], 2.0)
            .overlay(
                RoundedRectangle(cornerRadius: 2.0)
                    .stroke(lineWidth: 1.5)
            )
            .foregroundStyle(color ?? Color.gray)
    }
}

struct NormalText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(.gray)
    }
}
