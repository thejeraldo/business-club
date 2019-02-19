//
//  CompanyInfoTableViewCell.swift
//  Business Club
//
//  Created by Jerald Abille on 2/18/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit

class CompanyInfoTableViewCell: UITableViewCell {
  
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
  
  var websiteLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
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
    contentView.addSubview(websiteLabel)
    contentView.addSubview(followButton)
    contentView.addSubview(favoriteButton)
    
    var constraints = [NSLayoutConstraint]()
    
    // image
    constraints.append(companyImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor))
    constraints.append(companyImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
    constraints.append(companyImageView.widthAnchor.constraint(equalToConstant: 44.0))
    constraints.append(companyImageView.heightAnchor.constraint(equalToConstant: 44.0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configureWith(_ company: Company) {
    nameLabel.text = company.name
    websiteLabel.text = company.website
    if let url = URL(string: company.logo) {
      companyImageView.setURL(url)
    }
    layoutSubviews()
  }
}
