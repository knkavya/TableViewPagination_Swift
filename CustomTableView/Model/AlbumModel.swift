//
//  AlbumModel.swift
//  CustomTableView
//
//  Created by Kavya KN on 14/07/21.
//

import Foundation

// MARK: Model data our ViewModel will use.
struct Album: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

