//
//  Presenter.swift
//  MVPDesignPattern
//
//  Created by Gabriel on 28/05/21.
//

import Foundation
import UIKit

//https://jsonplaceholder.typicode.com/users

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
    
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    
    weak var delegate: PresenterDelegate?
    
    
    public func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return  }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
            return
        }
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            self?.delegate?.presentUsers(users: users)
        }
        catch {
            print(error)
        }
    }
        task.resume()
}
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
}


