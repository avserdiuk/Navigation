//
//  FileManagerService.swift
//  Navigation
//
//  Created by Алексей Сердюк on 04.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {
    func contentsOfDirectory(_ url : URL) -> [String]
    func createDirectory(_ url: URL, complition: () -> Void)
    //    func createFile()
    //    func removeContent()
}

class FileManagerService : FileManagerServiceProtocol{

    let documentsDirectoryUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

    func contentsOfDirectory(_ url : URL) -> [String]{
        var content : [String] = []

        do {
            let URLs = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [], options: .skipsHiddenFiles)

            for url in URLs {
                content.append(url.lastPathComponent)
            }

            return content
        } catch {
            print(error)
        }

        return []
    }

    func createDirectory(_ url: URL, complition: () -> Void) {
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
            complition()
        } catch {
            print(error)
        }
    }

    func checkDirectory(_ url : URL) -> Bool {
        url.isDirectory
    }

}

extension URL {
    var isDirectory: Bool {
        (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}



