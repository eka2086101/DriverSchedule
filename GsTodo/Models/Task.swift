//
//  Task.swift
//  GsTodo
//
//  Created by NaokiKameyama on 2020/05/6.
//  Copyright © 2020 NaokiKameyama. All rights reserved.
//

import Foundation

// Task のクラス。
// プロパティに title と memo を持っている
class Task: Codable {
    var title: String
    var memo: String?
    var date: Date?
    var search: String?
    var lat: String?
    var lon: String?
    
    // init とは、Task を作るときに呼ばれるメソッド。(イニシャライザという)
    // 使い方： let task = Task(title: "プログラミング")
    init(title: String, memo: String = "", date: Date, search: String = "", lat: String = "", lon: String = "") {
        self.title = title
        self.memo = memo
        self.date = date
        self.search = search
        self.lat = lat
        self.lon = lon
    }
}
