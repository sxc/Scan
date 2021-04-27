//
//  Model.swift
//  Scan
//
//  Created by Xiaochun Shen on 2021/4/27.
//

import Foundation



class TextItem: Identifiable {
    var id: String
    var text: String = ""
    
    init() {
        id = UUID().uuidString
    }
}

class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}
