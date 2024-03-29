//
//  CompanyDetailsViewController.swift
//  Business Club
//
//  Created by Jerald Abille on 2/18/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol CompanyDetailsViewControllerDelegate: class {
  func didToggleFollow(_ company: Company)
  func didToggleFavorite(_ company: Company)
  func didToggleFavorite(_ member: Member, company: Company)
}

class CompanyDetailsViewController: UIViewController {
  
  // MARK: - Enums
  
  enum CompanyDetailsRow: Int, CaseIterable {
    case main
    case members
    case about
  }
  
  // MARK: - Properties
  
  var company: Company?
  weak var delegate: CompanyDetailsViewControllerDelegate?
  
  // MARK: - UI Properties
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60.0
    tableView.separatorInset = .zero
    tableView.tableFooterView = UIView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: "companyCell")
    tableView.register(CompanyMembersTableViewCell.self, forCellReuseIdentifier: "companyMembersCell")
    tableView.register(CompanyAboutTableViewCell.self, forCellReuseIdentifier: "companyAboutCell")
    
    return tableView
  }()
  
  // MARK: - Initialization
  
  init(_ company: Company) {
    self.company = company
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Company Details"
    setupUI()
  }
  
  // MARK: - Setup
  
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    
    // Table view
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  // MARK: - Actions
  
  private func openWebsite() {
    guard let company = company else { return }
    if let url = URL(string: "http://".appending(company.website)) {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    }
  }
}

extension CompanyDetailsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return CompanyDetailsRow.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = indexPath.row
    guard let detailsRow = CompanyDetailsRow(rawValue: row) else { return UITableViewCell() }
    switch detailsRow {
    case .main:
      let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyTableViewCell
      cell.selectionStyle = .none
      cell.configureWith(company!)
      cell.websiteButton.isUserInteractionEnabled = true
      cell.websiteTapHandler = {
        self.openWebsite()
      }
      cell.followTapHandler = {
        self.company!.toggleFollow()
        self.tableView.reloadData()
        self.delegate?.didToggleFollow(self.company!)
      }
      cell.favoriteTapHandler = {
        self.company!.toggleFavorite()
        self.tableView.reloadData()
        self.delegate?.didToggleFavorite(self.company!)
      }
      return cell
    case .members:
      let cell = tableView.dequeueReusableCell(withIdentifier: "companyMembersCell", for: indexPath) as! CompanyMembersTableViewCell
      cell.configureWith(company!)
      return cell
    case .about:
      let cell = tableView.dequeueReusableCell(withIdentifier: "companyAboutCell", for: indexPath) as! CompanyAboutTableViewCell
      cell.configureWith(company!)
      return cell
    }
  }
}

extension CompanyDetailsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == CompanyDetailsRow.members.rawValue { return 44.0 }
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let row = indexPath.row
    guard let detailsRow = CompanyDetailsRow(rawValue: row) else { return }
    guard let company = self.company else { return }
    if detailsRow == .members {
      let vc = MembersViewController(company)
      vc.delegate = self
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

// MARK: - MembersViewControllerDelegate

extension CompanyDetailsViewController: MembersViewControllerDelegate {
  func didToggleFavorite(_ member: Member) {
    guard let company = company else { return }
    self.company?.toggleFavorite(member)
    self.tableView.reloadData()
    self.delegate?.didToggleFavorite(member, company: company)
  }
}
