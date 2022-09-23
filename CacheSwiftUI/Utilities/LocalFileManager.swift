//
//  LocalFileManager.swift
//  CacheSwiftUI
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    private let folderName = "MyApp_Images"
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(
                    atPath: path,
                    withIntermediateDirectories: true)
                print("successfully create folder")
            } catch let error {
                print("fail to create folder \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
                print("successfully remove folder")
            } catch let error {
                print("fail to create folder \(error)")
            }
        }
    }
    
    func add(with key: String, image: UIImage) {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathOfData(to: key) else {
            print("Error getting data!")
            return
        }
        do {
            try data.write(to: path)
            print("Success saving!")
        } catch let error {
            print("Error saving \(error)")
        }
    }
    
    func get(to key: String) -> UIImage? {
        guard
            let path = getPathOfData(to: key)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("not found file!")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func remove(from key: String) {
        guard
            let path = getPathOfData(to: key)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("not found file!")
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success to delete")
        } catch let error {
            print("Error deleting item. \(error)")
        }
    }
    
    private func getPathOfData(to key: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(key).jpg") else {
            print("Error getting path")
            return nil
        }
        
        return path
    }
}
