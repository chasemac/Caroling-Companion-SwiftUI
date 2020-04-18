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
    @Environment(\.presentationMode) var presentationMode
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("backArrowCreamColor")
        }
    }

    var body: some View {
        ScrollView {
            Text(song.lyrics)
                .multilineTextAlignment(.center)
            .padding()
            
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.init(hex: "FDFCF6"))
        .navigationBarTitle(Text(song.title), displayMode: .inline)
    .navigationBarItems(leading: btnBack)
    .navigationBarBackButtonHidden(true)
    }
}

//struct SongView_Previews: PreviewProvider {
//    static var previews: some View {
//        SongView(song: <#Song#>)
//    }
//}
