//
//  CompanyTableViewCell.swift
//  Business Club
//
//  Created by Jerald Abille on 2/15/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
  
  var companyImageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.backgroundColor = .lightGray
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 44 * 0.5
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  var nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
    label.numberOfLines = 0
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var websiteButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.borderWidth = 0
    button.contentHorizontalAlignment = .leading
    button.setTitle("", for: .normal)
    button.setTitleColor(.darkGray, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  var followButton: UIButton = {
    let color = UIColor.blue
    let button = UIButton(type: .custom)
    button.layer.borderColor = color.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 4
    button.setTitle("+ Follow", for: .normal)
    button.setTitleColor(color, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  var favoriteButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
    button.setTitle("", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  typealias buttonTapHandler = (() -> ())
  var websiteTapHandler: buttonTapHandler = {}
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(companyImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(websiteButton)
    contentView.addSubview(followButton)
    contentView.addSubview(favoriteButton)
    
    var constraints = [NSLayoutConstraint]()
    
    // image
    constraints.append(companyImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor))
    constraints.append(companyImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
    constraints.append(companyImageView.widthAnchor.constraint(equalToConstant: 44.0))
    constraints.append(companyImageView.heightAnchor.constraint(equalToConstant: 44.0))
    
    // favorite
    constraints.append(favoriteButton.heightAnchor.constraint(equalToConstant: 24.0))
    constraints.append(favoriteButton.widthAnchor.constraint(equalToConstant: 24.0))
    constraints.append(favoriteButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor))
    constraints.append(favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
    
    // follow
    constraints.append(followButton.heightAnchor.constraint(equalToConstant: 24.0))
    constraints.append(followButton.widthAnchor.constraint(equalToConstant: 90.0))
    constraints.append(followButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8.0))
    constraints.append(followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
    
    // website
    constraints.append(websiteButton.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8.0))
    constraints.append(websiteButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor))
    constraints.append(websiteButton.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -8.0))
    constraints.append(websiteButton.heightAnchor.constraint(equalToConstant: 16.0))
    
    // name
    constraints.append(nameLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8.0))
    constraints.append(nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
    constraints.append(nameLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -8.0))
    constraints.append(nameLabel.bottomAnchor.constraint(equalTo: websiteButton.topAnchor, constant: -8.0))
    
    NSLayoutConstraint.activate(constraints)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func configureWith(_ company: Company) {
    nameLabel.text = company.name
    
    let websiteButtonAttribs: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .light),
      NSAttributedString.Key.foregroundColor: UIColor.darkGray,
      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
      NSAttributedString.Key.underlineColor: UIColor.lightGray
    ]
    let websiteTitle = NSAttributedString(string: company.website, attributes: websiteButtonAttribs)
    websiteButton.setAttributedTitle(websiteTitle, for: .normal)
    websiteButton.addTarget(self, action: #selector(didTapWebsiteButton), for: .touchUpInside)
    
    if let url = URL(string: company.logo) {
      companyImageView.setURL(url)
    }
    layoutSubviews()
  }
  
  @objc private func didTapWebsiteButton() {
    self.websiteTapHandler()
  }
}
