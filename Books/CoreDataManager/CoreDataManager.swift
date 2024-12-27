//
//  CoreDataManager.swift
//  Books
//
//  Created by Edgar Adamyan on 26.12.24.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
  static let shared = CoreDataManager()
  private init() {}
  
  private let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
  
  
  func addBook(title: String, author: String, price: String, image: String, rating: String) -> Book {
    let newBook = Book(context: context )
    newBook.title = title
    newBook.price = price
    newBook.author = author
    newBook.image = image
    newBook.rating = rating
    
    do{
      try context.save()
      
    }catch{
      print("\(error.localizedDescription)")
    }
    return newBook
  }
  
  func fetchBooks() -> [Book]{
    let request: NSFetchRequest<Book> = Book.fetchRequest() as NSFetchRequest<Book>
    do{
      return try context.fetch(request)
    }catch{
      print("\(error.localizedDescription)")
    }
    return []
  }
  func deleteBooks(book: Book) {
    context.delete(book)
    do{
      try context.save()
    }catch{
      print("\(error.localizedDescription)")
    }
  }
}
