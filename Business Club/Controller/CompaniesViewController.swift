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
  
  // MARK: - Enums
  
  private enum NameOrder {
    case none
    case asc
    case desc
  }
  
  // MARK: - Properties
  
  private var companies: Companies? {
    didSet {
      tableView.reloadData()
    }
  }
  private var nameOrder = NameOrder.none
  private var searchResults: Companies? {
    get {
      var results = companies
      // Sorting
      if let _ = results {
        switch nameOrder {
        case .asc: results!.sort(by: { $0.name < $1.name })
        case .desc: results!.sort(by: { $0.name > $1.name })
        case .none: break
        }
      }
      // Filtering
      if searchController.isActive {
        guard let searchText = searchController.searchBar.text, searchText.count > 0 else { return results }
        if let _ = results {
          results = results!.filter { $0.name.localizedStandardContains(searchText) }
          results!.sort(by: { $0.name < $1.name }) // Always sort names in ascending order when searching.
        }
      }
      return results
    }
  }
  
  // MARK: - UI Properties
  
  private lazy var tableView: UITableView = {
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
  private let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Companies"
    setupNavigationItems()
    setupUI()
    setupSearchController()
    loadCompanies()
  }
  
  // MARK: - Setup
  
  private func setupNavigationItems() {
    let sortBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "sort"), style: .plain, target: self, action: #selector(showSortController))
    navigationItem.rightBarButtonItems = [ sortBarButton ]
  }
  
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search by Company Name"
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  private func refresh() {
    updateSearchResults(for: searchController)
  }
  
  // MARK: - Actions
  
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
    alert.addAction(UIAlertAction(title: "Name descending A → Z", style: .default, handler: { _ in
      self.nameOrder = .asc
      self.updateSearchResults(for: self.searchController)
    }))
    alert.addAction(UIAlertAction(title: "Name descending Z → A", style: .default, handler: { _ in
      self.nameOrder = .desc
      self.updateSearchResults(for: self.searchController)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource

extension CompaniesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // return self.companies?.count ?? 0
    return searchResults?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyTableViewCell
    if let company = searchResults?[indexPath.row] { cell.configureWith(company) }
    if indexPath.row == 1 {
      cell.followButton.setTitle("+ Follow", for: .normal)
    }
    return cell
  }
}

// MARK: - UITableViewDelegate

extension CompaniesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let company = searchResults?[indexPath.row] else { return }
    print(company)
  }
}

// MARK: - UISearchResultsUpdating

extension CompaniesViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    tableView.reloadData()
  }
}
