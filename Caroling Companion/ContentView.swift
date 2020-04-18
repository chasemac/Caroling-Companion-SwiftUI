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
    let redish = UIColor(red: 183/255, green: 79/255, blue: 79/255, alpha: 1)
    let user = FUser()
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().backgroundColor = redish
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            //            .font : UIFont(name:"Papyrus", size: 40)!]
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white,
            //            .font : UIFont(name: "HelveticaNeue-Thin", size: 20)!
        ]
        UINavigationBar.appearance().barTintColor = redish
        UINavigationBar.appearance().tintColor = UIColor(red: 253/255, green: 252/255, blue: 246/255, alpha: 1)
        
        
    }
    
    var body: some View {
        ZStack {
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
                .navigationBarTitle(
                    Text("Caroling Companion")
                        .foregroundColor(.blue)
                )
                //                .navigationBarColor(.green)
            }
                
            .onAppear {
                self.signInAnonymously()
            }
            .padding(.top, 50)
            .edgesIgnoringSafeArea(.top)
            .zIndex(1)
            Color(redish)
                .edgesIgnoringSafeArea(.top)
                .zIndex(0)
            
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
