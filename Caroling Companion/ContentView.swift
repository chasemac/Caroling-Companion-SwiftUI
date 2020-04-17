//
//  ContentView.swift
//  Caroling Companion
//
//  Created by Chase McElroy on 4/16/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var isLoggedIn = false
    @State var songList: [Song] = []
    let user = FUser()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(songList) { song in
                        
                        NavigationLink(destination: SongView(song: song)) {
                            Text(song.title)
                        }
                        
                    }
                }
            }
        .navigationBarTitle("Caroling Companion")
        }
            
        .onAppear {
            self.signInAnonymously()
        }
    }
    private func signInAnonymously() {
        user.loginUserAnonymously { (error, isLoggedInFirebase) in
            if isLoggedInFirebase {
                self.isLoggedIn = true
                self.getSongList()
            } else {
                print("Error logging in:", error?.localizedDescription ?? "")
            }
        }
    }
    private func getSongList() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let prodRef = ref.child(DBEnvironment.production)
        let songsRef = prodRef.child(DBTopLevel.songs)
        
        songsRef.observeSingleEvent(of: .value) { (snapshot) in
            let dict = snapshot.value as! [String: Any]
            dict.forEach { (key, value) in
                let specificSongDict = value as! [String: Any]
                let song = Song(_id: key, _title: specificSongDict["title"] as! String, _lyrics: specificSongDict["lyrics"] as! String)
                self.songList.append(song)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
