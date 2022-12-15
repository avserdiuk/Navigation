//
//  CoreDataModel.swift
//  Navigation
//
//  Created by Алексей Сердюк on 14.12.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataModel {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    var favoritePosts : [Favorite] = []

    @discardableResult func getPosts() -> [Favorite] {
        let answer = Favorite.fetchRequest()
        do {
            let posts = try persistentContainer.viewContext.fetch(answer)
            favoritePosts = posts
            return favoritePosts
        } catch {
            print(error)
        }
        return []
    }

    init() {
        getPosts()
    }

    func delete(){
        let answer = Favorite.fetchRequest()
        do {
            let posts = try persistentContainer.viewContext.fetch(answer)
            let context = persistentContainer.viewContext
            for post in posts {
                context.delete(post)
            }
            saveContext()
        } catch {
            print(error)
        }

    }

    func addToFavorite(pid: Int, autor: String, desc: String, likes: Int, views: Int, img : String){
        let post = Favorite(context: persistentContainer.viewContext)
        post.pid = Int32(pid)
        post.autor = autor
        post.desc = desc
        post.likes = Int32(likes)
        post.views = Int32(views)
        post.img = img
        saveContext()
    }
}
