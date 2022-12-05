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
    //    func createDirectory(name: String, complition: (String) -> Void)
    //    func createFile()
    //    func removeContent()
}

class FileManagerService : FileManagerServiceProtocol{

    let documentsDirectoryUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

    func contentsOfDirectory(_ url : URL) -> [String]{
        print("Get content for: \(url)")
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

    //    func createDirectory(name: String, complition: (String) -> Void) {
    //        let name = documentsDirectoryUrl.appendingPathComponent(name)
    //
    //        do {
    //            try FileManager.default.createDirectory(at: name, withIntermediateDirectories: false)
    //            complition("success")
    //        } catch {
    //            complition("\(error)")
    //        }
    //    }

    func checkDirectory(url : URL) -> Bool {
        url.isDirectory
    }

}













extension URL {
    var isDirectory: Bool {
        (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))

        self.present(alert, animated: true, completion: nil)
    }
}


