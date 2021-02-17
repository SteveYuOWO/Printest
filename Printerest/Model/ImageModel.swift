//
//  ImageModel.swift
//  Printerest
//
//  Created by Steve Yu on 2021/2/17.
//

import Foundation

struct ImageModel: Codable, Identifiable {
    var id: String
    var download_url: String
    var onHover: Bool? // optional not for json...
}
