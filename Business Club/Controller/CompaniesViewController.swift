//
//  CompaniesViewController.swift
//  Business Club
//
//  Created by Jerald Abille on 2/15/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    
    let refreshControl = UIRefreshControl(frame: .zero)
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    return tableView
  }()
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Companies"
    setupNavigationItems()
    setupUI()
    loadCompanies()
  }
  
  // MARK: -
  
  private func setupNavigationItems() {
    let sortBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "sort"), style: .plain, target: self, action: #selector(showSortController))
    self.navigationItem.rightBarButtonItems = [ sortBarButton ]
  }
  
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  @objc private func refresh() {
    tableView.refreshControl?.endRefreshing()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
      self.loadCompanies()
    }
  }
  
  private func loadCompanies() {
    SVProgressHUD.show()
    let api = BusinessClubAPI.getCompanyList()
    NetworkManager.shared.get(api, resultType: Companies.self) { result, error in
      SVProgressHUD.dismiss()
      guard error == nil else {
        SVProgressHUD.showError(withStatus: error?.localizedDescription)
        return
      }
      if let companies = result {
        self.companies = companies
      }
    }
  }
  
  @objc private func showSortController() {
    let alert = UIAlertController(title: "Sort Company List by", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Name ascending A → Z", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "Name descending Z → A", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
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
    if indexPath.row == 1 {
      cell.followButton.setTitle("+ Follow", for: .normal)
    }
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
