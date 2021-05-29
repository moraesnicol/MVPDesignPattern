//
//  ViewController.swift
//  MVPDesignPattern
//
//  Created by Gabriel on 28/05/21.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserPresenterDelegate {
    
 
    
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
        
    }()
    
    
    private var  users = [User]()
    private let presenter = UserPresenter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Users"

        //table
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Ask presenter to handle the tap
        presenter.didTap(user: users[indexPath.row])
    }
    
    //Hey  delegate Presenter users for me
    func presentUsers(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func presentAlert(title: String, message: String) {
       }
    
    
   
    
}

