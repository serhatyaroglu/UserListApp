//
//  UserTableViewCell.swift
//  User List App
//
//  Created by serhat yaroglu on 8.02.2025.
//

import UIKit
import SnapKit
class UserTableViewCell: UITableViewCell {
    
    private let iconImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.image = UIImage(systemName: "person.circle")
        return imageview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 13)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        return imageview
    }()
    
    private let mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.lightGray.cgColor
        return mainView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainView)
        mainView.addSubview(iconImageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(subtitleLabel)
        mainView.addSubview(arrowImageView)
        
        mainView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.left.right.top.equalToSuperview()
            make.height.equalTo(76)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.left.equalTo(iconImageView.snp.right).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        arrowImageView.image = UIImage(named: "ic_chevron")
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.right.equalToSuperview().inset(16)
        }
    }
    //MARK: - celli configure etmek için 
    func configure(with object: UserList) {
        titleLabel.text = object.username
        subtitleLabel.text = object.email
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
