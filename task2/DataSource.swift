//
//  DataSource.swift
//  task2
//
//  Created by Volosandro on 01.11.2022.
//

import Foundation

class DataSource
{
    private var data: [String] = []
    
    init()
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
