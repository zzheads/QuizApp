//
//  Sounds.swift
//  QuizApp
//
//  Created by Alexey Papin on 05.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import AudioToolbox

struct Sound {
    let name: String
    var soundId: SystemSoundID
    
    init(name: String) {
        self.name = name
        self.soundId = 0
        let pathToSoundFile = Bundle.main.path(forResource: self.name, ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &self.soundId)
    }
    
    func play() {
        AudioServicesPlaySystemSound(self.soundId)
    }
}
