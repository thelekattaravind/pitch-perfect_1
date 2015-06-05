//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Aravind on 5/28/15.
//  Copyright (c) 2015 Aravind. All rights reserved.
//

import Foundation

class RecordedAudio {
    var title : String!
    var filePathURL : NSURL!
    init(title: String!, filePathURL: NSURL!){
        self.title = title
        self.filePathURL = filePathURL
    }
}