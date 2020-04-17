//
//  FUser.swift
//  Caroling Companion
//
//  Created by Chase McElroy on 4/16/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation
import FirebaseAuth

class FUser: ObservableObject {
    @Published var id: String?
    
//    init(_id: String) {
//        self.id = _id
//    }
    
func loginUserAnonymously(completion: @escaping (_ error: Error?, _ isLoggedIn: Bool) -> Void) {
        Auth.auth().signInAnonymously { (authResult, error) in
            if error != nil {
                completion(error, false)
                return
            } else {
                guard let user = authResult?.user else {
                    completion(nil, false)
                    return
                }
                self.id = user.uid
                completion(nil, true)
            }
        }
    }
}
