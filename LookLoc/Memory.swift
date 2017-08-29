//
//  Memory.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/28.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

// MARK: - Memory

struct Memory {
    static func clearMemory() {
        // clear cache
        URLCache.shared.removeAllCachedResponses()
        
        // clear temp file
        let fileManager = FileManager.default
        let tempFolderPath = NSTemporaryDirectory()
        
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: NSTemporaryDirectory() + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
}
