//
//  HomeView.swift
//  Printerest
//
//  Created by Steve Yu on 2021/2/16.
//

import SwiftUI
import SDWebImageSwiftUI

var window = NSScreen.main!.visibleFrame

struct Home: View {
    @State var selected = "Home"
    
    @State var search: String = ""
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 4)
    
    @StateObject var imageData = ImageViewModel()
    
    var body: some View {
        HStack {
            SideBar(selected: $selected)
            VStack {
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(.gray))
                        TextField("Search", text: $search)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(BlurWindow())
                    .cornerRadius(10)
                    
                    Button(action: {}, label: {
                        Image(systemName: "slider.vertical.3")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1),
                                    radius: 5,
                                    x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.1),
                                    radius: 5,
                                    x: -5, y: -5)
                        
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {}, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black)
                            .cornerRadius(10)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                
                GeometryReader { reader in
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(imageData.images.indices, id: \.self) { index in
                                ZStack {
                                    WebImage(url: URL(string: imageData.images[index].download_url))
                                        .placeholder {
                                            ProgressView()
                                        }
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: (reader.frame(in: .global).width - 45) / 4,
                                               height: 150)
                                        .cornerRadius(15)
                                    
                                    Color.black.opacity(imageData.images[index].onHover ?? false ? 0.2: 0)
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                                Image(systemName: "hand.thumbsup.fill")
                                                    .foregroundColor(.yellow)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .cornerRadius(10)
                                            })
                                            .buttonStyle(PlainButtonStyle())
                                            
                                            Button(action: {
                                                saveImage(index: index)
                                            }, label: {
                                                Image(systemName: "folder.fill")
                                                    .foregroundColor(.yellow)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .cornerRadius(10)
                                            })
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                            .padding(10)
                                        Spacer()
                                    }
                                    .opacity(imageData.images[index].onHover ?? false ? 1: 0)
                                }
                                .onHover(perform: { hovering in
                                    withAnimation {
                                        imageData.images[index].onHover = hovering
                                    }
                                })
                            }
                        }
                    }
                }
                .padding()
            }
            
        }
        .frame(minWidth: window.width - 400,
               idealWidth: window.width - 400,
               maxWidth: .infinity,
               minHeight: window.height - 150,
               idealHeight: window.height - 150,
               maxHeight: .infinity,
               alignment: .center)
        .background(Color.white.opacity(0.6))
        .background(BlurWindow())
    }
    
    func saveImage(index: Int) {
        // getting Image data from url
        
        let manager = SDWebImageDownloader(config: .default)
        manager.downloadImage(with: URL(string: imageData.images[index].download_url)!) { (image, _, _, _) in
            guard let imageOriginal = image else { return }
            let data = imageOriginal.sd_imageData(as: .JPEG)
            
            // save pannel
            let pannel = NSSavePanel()
            
            pannel.canCreateDirectories = true
            pannel.nameFieldStringValue = "\(imageData.images[index].id).jpg"
            pannel.begin { resp in
                if resp.rawValue == NSApplication.ModalResponse.OK.rawValue {
                    do {
                        try data?.write(to: pannel.url!, options: .atomicWrite)
                        print("success")
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set {}
    }
}



