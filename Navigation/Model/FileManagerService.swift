//
//  FileManagerService.swift
//  Navigation
//
//  Created by Алексей Сердюк on 04.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import UIKit


//struct Content {
//    var url : URL
//    var isDirectory : Bool
//    var name : String
//}
//
//var content : [Content] = []

protocol FileManagerServiceProtocol {
    func contentsOfDirectory() -> [String]
    //    func createDirectory()
    //    func createFile()
    //    func removeContent()
}

class FileManagerService : FileManagerServiceProtocol{

    private let documentsDirectoryUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

    func contentsOfDirectory() -> [String]{
        do {
            let content = try FileManager.default.contentsOfDirectory(atPath: documentsDirectoryUrl.path)
            return content
        } catch {
            print(error)
        }

        return []
    }

    func createDirectory(name: String, complition: (String) -> Void) {
        let name = documentsDirectoryUrl.appendingPathComponent(name)

        do {
            try FileManager.default.createDirectory(at: name, withIntermediateDirectories: false)
            complition("success")
        } catch {
            complition("\(error)")
        }
    }

    func checkDirectory(name : String) -> Bool {
        let URL = documentsDirectoryUrl.appendingPathComponent(name)
        return URL.isDirectory
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


