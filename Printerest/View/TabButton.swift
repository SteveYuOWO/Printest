//
//  TabButton.swift
//  Printerest
//
//  Created by Steve Yu on 2021/2/16.
//

import SwiftUI

struct TabButton: View {
    var image: String
    var title: String
    @Binding var selected: String
    var animation: Namespace.ID
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = title
            }
        }, label: {
            HStack {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(selected == title ? .black: black)
                    .frame(width: 25)
                Text(title)
                    .fontWeight(selected == title ? .semibold: .none)
                    .animation(.none)
                    .foregroundColor(Color(#colorLiteral(red: 0.1971895844, green: 0.1971895844, blue: 0.1971895844, alpha: 1)))
                
                Spacer()
                
                ZStack {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 3, height: 25)
                    if selected == title {
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 3, height: 25)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            }
            .padding(.leading)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

var black = Color.black.opacity(0.5)

