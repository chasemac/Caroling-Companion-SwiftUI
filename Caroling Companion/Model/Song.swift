//
//  Song.swift
//  Caroling Companion
//
//  Created by Chase McElroy on 4/17/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation

class Song: Identifiable {
    var id: String
    var title: String
    var lyrics: String
    
    init(_id: String, _title: String, _lyrics: String) {
        self.id = _id
        self.title = _title
        let lyricsSwift = _lyrics.replacingOccurrences(of: "<br>", with: "\n")

        self.lyrics = lyricsSwift
    }
}
