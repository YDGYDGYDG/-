//
//  Config.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit

// 저장
class Favorite {
    let config = UserDefaults.standard
}

//UI Constants
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

let TileMargin : CGFloat = 20

let soundDing = "Audio/ding.mp3"
let soundWrong = "Audio/wrong.m4a"
let soundWin = "Audio/win.mp3"
let AudioEffectFiles = [soundDing, soundWrong, soundWin]


//Random number generator
func randomNumber(minX:UInt32, maxX:UInt32) -> Int {
  let result = (arc4random() % (maxX - minX + 1)) + minX
  return Int(result)
}

