//
//  MemberTableViewCell.swift
//  Business Club
//
//  Created by Jerald Abille on 2/18/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
  
  var memberImageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.backgroundColor = .lightGray
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 44 * 0.5
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  var initialsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
    label.numberOfLines = 1
    label.textAlignment = .center
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
    label.numberOfLines = 0
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var ageLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    label.numberOfLines = 0
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var emailButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.borderWidth = 0
    button.contentHorizontalAlignment = .leading
    button.setTitle("", for: .normal)
    button.setTitleColor(.darkGray, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isUserInteractionEnabled = true
    return button
  }()
  
  var phoneButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.borderWidth = 0
    button.contentHorizontalAlignment = .leading
    button.setTitle("", for: .normal)
    button.setTitleColor(.darkGray, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isUserInteractionEnabled = true
    return button
  }()
  
  lazy var favoriteButton: UIButton = {
    let button = UIButton(type: .custom)
    button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    button.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
    button.setTitle("", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  typealias buttonTapHandler = (() -> ())
  var favoriteTapHandler: buttonTapHandler = {}
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    memberImageView.backgroundColor = .lightGray
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    memberImageView.backgroundColor = .lightGray
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(memberImageView)
    contentView.addSubview(initialsLabel)
    contentView.addSubview(nameLabel)
    contentView.addSubview(ageLabel)
    contentView.addSubview(emailButton)
    contentView.addSubview(phoneButton)
    contentView.addSubview(favoriteButton)
    
    var constraints = [NSLayoutConstraint]()
    
    // image
    constraints.append(memberImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor))
    constraints.append(memberImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
    constraints.append(memberImageView.widthAnchor.constraint(equalToConstant: 44.0))
    constraints.append(memberImageView.heightAnchor.constraint(equalToConstant: 44.0))
    
    // initials
    constraints.append(initialsLabel.leadingAnchor.constraint(equalTo: memberImageView.leadingAnchor))
    constraints.append(initialsLabel.topAnchor.constraint(equalTo: memberImageView.topAnchor))
    constraints.append(initialsLabel.trailingAnchor.constraint(equalTo: memberImageView.trailingAnchor))
    constraints.append(initialsLabel.bottomAnchor.constraint(equalTo: memberImageView.bottomAnchor))
    
    // favorite
    constraints.append(favoriteButton.widthAnchor.constraint(equalToConstant: 32.0))
    constraints.append(favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor))
    constraints.append(favoriteButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor))
    constraints.append(favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
    
    // name
    constraints.append(nameLabel.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 8.0))
    constraints.append(nameLabel.topAnchor.constraint(equalTo: memberImageView.topAnchor))
    constraints.append(nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8.0))
    constraints.append(nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20.0))
    
    // age
    constraints.append(ageLabel.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 8.0))
    constraints.append(ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0))
    constraints.append(ageLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8.0))
    constraints.append(ageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10.0))
    
    // email
    constraints.append(emailButton.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 8.0))
    constraints.append(emailButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8.0))
    constraints.append(emailButton.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 0))
    constraints.append(emailButton.heightAnchor.constraint(equalToConstant: 16.0))
    
    // phone
    constraints.append(phoneButton.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 8.0))
    constraints.append(phoneButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor))
    constraints.append(phoneButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8.0))
    constraints.append(phoneButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 0))
    constraints.append(phoneButton.heightAnchor.constraint(equalToConstant: 16.0))
    
    NSLayoutConstraint.activate(constraints)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configureWith(_ member: Member) {
    initialsLabel.text = "\(member.name.firstName.prefix(1))\(member.name.lastName.prefix(1))"
    nameLabel.text = "\(member.name.firstName) \(member.name.lastName)"
    ageLabel.text = "\(member.age) yrs old"
    let buttonAttribs: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .light),
      NSAttributedString.Key.foregroundColor: UIColor.darkGray,
      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
      NSAttributedString.Key.underlineColor: UIColor.lightGray
    ]
    emailButton.setAttributedTitle(NSAttributedString(string: member.email, attributes: buttonAttribs), for: .normal)
    phoneButton.setAttributedTitle(NSAttributedString(string: member.phone, attributes: buttonAttribs), for: .normal)
    favoriteButton.setImage(member.isFavorite ? #imageLiteral(resourceName: "unfavorite") : #imageLiteral(resourceName: "favorite"), for: .normal)
  }
  
  @objc private func didTapFavorite() {
    self.favoriteTapHandler()
  }
}
