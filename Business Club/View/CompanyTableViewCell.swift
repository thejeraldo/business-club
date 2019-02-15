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
    
    var constraints = [NSLayoutConstraint]()
    
    // companyImageView
    constraints.append(companyImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor))
    constraints.append(companyImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
    constraints.append(companyImageView.widthAnchor.constraint(equalToConstant: 44.0))
    constraints.append(companyImageView.heightAnchor.constraint(equalToConstant: 44.0))
    // constraints.append(companyImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor))
    
    // websiteLabel
    constraints.append(websiteLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8.0))
    constraints.append(websiteLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor))
    constraints.append(websiteLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor))
    constraints.append(websiteLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10.0))
    
    // nameLabel
    constraints.append(nameLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8.0))
    constraints.append(nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
    constraints.append(nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor))
    constraints.append(nameLabel.bottomAnchor.constraint(equalTo: websiteLabel.topAnchor, constant: -8.0))
    
    NSLayoutConstraint.activate(constraints)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let height = companyImageView.frame.height
    companyImageView.layer.cornerRadius = height * 0.5
  }
  
  public func configureWith(_ company: Company) {
    nameLabel.text = company.name
    websiteLabel.text = company.website
    if let url = URL(string: company.logo) {
      companyImageView.setURL(url)
    }
  }
}
