//
//  DataSource.swift
//  task2
//
//  Created by Volosandro on 01.11.2022.
//

import Foundation

class DataSource: NSObject, NSCoding
{
    var data: [String] = []
    
    func encode(with coder: NSCoder) {
        coder.encode(self.data, forKey: "__data")
    }
    
    required init?(coder: NSCoder) {
        self.data = coder.decodeObject(forKey: "__data") as? [String] ?? []
    }

    override init()
    {
        self.data = (0..<Int.random(in: 30...35)).map{ _ in Int.random(in: 1 ... 20).description}
    }
    
    func getData() -> [String]
    {
        return self.data
    }
    
    func getStringByIndex(index: Int) -> String
    {
        return self.data[index]
    }
    
    func getDataCount() -> Int
    {
        return self.data.count
    }
}
