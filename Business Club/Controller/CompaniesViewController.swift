//
//  CompaniesViewController.swift
//  Business Club
//
//  Created by Jerald Abille on 2/15/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit

class CompaniesViewController: UIViewController {
  
  // MARK: - Properties
  
  var companies: Companies? {
    didSet {
      tableView.reloadData()
    }
  }
  
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60.0
    tableView.tableFooterView = UIView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: "companyCell")
    
    return tableView
  }()
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Companies"
    setupUI()
    loadCompanies()
  }
  
  // MARK: -
  
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func loadCompanies() {
    let api = BusinessClubAPI.getCompanyList()
    NetworkManager.shared.get(api, resultType: Companies.self) { result, error in
      guard error == nil else {
        return
      }
      if let companies = result {
        self.companies = companies
      }
    }
  }
}

// MARK: - UITableViewDataSource

extension CompaniesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.companies?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyTableViewCell
    if let company = companies?[indexPath.row] { cell.configureWith(company) }
    return cell
  }
}

extension CompaniesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let company = companies?[indexPath.row] else { return }
    print(company)
  }
}
