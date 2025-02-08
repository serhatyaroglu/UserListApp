//
//  UserTableView.swift
//  User List App
//
//  Created by serhat yaroglu on 8.02.2025.
//

import Foundation
import UIKit
protocol UserTableViewDelegate: AnyObject {
    func didSelectUserList(userList: UserList)
    func numberOfRows() -> Int
    func item(for row: Int) -> UserList
}

class UserTableView: UITableView ,UITableViewDataSource, UITableViewDelegate{
    
    weak var userListDelegate: UserTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        self.separatorStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        dataSource = self
        delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userListDelegate!.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let item = self.userListDelegate!.item(for: indexPath.row)
        cell.configure(with: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.userListDelegate!.item(for: indexPath.row)
        self.userListDelegate?.didSelectUserList(userList: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
}
