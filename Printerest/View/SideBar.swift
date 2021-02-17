//
//  SideBar.swift
//  Printerest
//
//  Created by Steve Yu on 2021/2/16.
//

import SwiftUI

struct SideBar: View {
    @Binding var selected: String
    
    @Namespace var animation
    
    var body: some View {
        HStack {
            VStack(spacing: 22) {
                Group {
                    HStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                        Text("Printest")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 35)
                    .padding(.leading, 10)
                    
                    TabButton(image: "house.fill", title: "Home", selected: $selected, animation: animation)
                    TabButton(image: "clock.fill", title: "Recents", selected: $selected, animation: animation)
                    TabButton(image: "person.2.fill", title: "Following", selected: $selected, animation: animation)
                    
                    
                    HStack {
                        Text("Insights")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    
                    TabButton(image: "message.fill", title: "Messages", selected: $selected, animation: animation)
                    
                    TabButton(image: "bell.fill", title: "Notifications", selected: $selected, animation: animation)
                }
                
                VStack(spacing: 5) {
                    Image("thinking")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    
                }, label: {
                    Text("Computer Tools")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                })
                .buttonStyle(PlainButtonStyle())
                
                Text("hurry! Up Now you can unlock our new computer tools at your convinence")
                    .foregroundColor(Color("Description"))
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 0)
                
                // Profile View
                HStack(spacing: 10) {
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Steve Yu")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(#colorLiteral(red: 0.1971895844, green: 0.1971895844, blue: 0.1971895844, alpha: 1)))
                        Text("Last Login 16/Feb/20")
                            .font(.caption2)
                            .foregroundColor(Color("Description"))
                    })
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
                .background(Color("ProfileColor"))
                .cornerRadius(10)
                .shadow(radius: 5, x: 5, y: 5)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            Divider()
                .offset(x: -2)
        }
        .frame(width: 220)
    }
}
