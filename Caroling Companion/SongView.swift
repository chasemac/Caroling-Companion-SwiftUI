//
//  SongView.swift
//  Caroling Companion
//
//  Created by Chase McElroy on 4/17/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import SwiftUI

struct SongView: View {
    var song: Song
    var body: some View {
        Text(song.lyrics)
    }
}

//struct SongView_Previews: PreviewProvider {
//    static var previews: some View {
//        SongView(song: <#Song#>)
//    }
//}
