//
//  Storage.swift
//  task2
//
//  Created by Volosandro on 01.11.2022.
//

import Foundation

class Storage
{
    // MARK: - Constants
    private let filename = "VCs.dat"
    static let shared = Storage()
    
    // MARK: - Variables
    private var array: [ViewController] = []
    
    // MARK: - Actions
    func addVC(vc: ViewController)
    {
        if !self.array.contains(vc)
        {
            self.array.append(vc)
            self.save()
        }
    }
    
    func removeVC(vc: ViewController)
    {
        if let index = self.array.firstIndex(of: vc)
        {
            self.array.remove(at: index)
        }
        self.save()
    }
    
    func getControllersArray() -> [ViewController]
    {
        return self.array
    }
    
    // MARK: - Save/Load
    func save()
    {
        guard let path = self.getPath() else { return }
        let documentPath = path + "/" + self.filename
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self.array)
        let dict: NSDictionary = ["__array": archivedData]

        dict.write(toFile: documentPath, atomically: true)
    }
    
    func load()
    {
        guard let path = self.getPath() else { return }
        
        let documentsPath = path + "/" + self.filename
        if (!FileManager.default.fileExists(atPath: documentsPath))
        {
            self.array.append(ViewController())
            return
        }
        
        let dict = NSDictionary.init(contentsOfFile: documentsPath)
        let archivedData = dict?.value(forKey: "__array") as! Data
        self.array.removeAll()
        self.array = NSKeyedUnarchiver.unarchiveObject(with: archivedData) as! [ViewController]
    }
    
    // MARK: - Helpers
    private func getPath() -> String?
    {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first
        return documentsDirectory
    }
}
