//
//  MembersViewController.swift
//  Business Club
//
//  Created by Jerald Abille on 2/18/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController {
  
  // MARK: - Enums
  
  private enum Order {
    case none
    case nameAsc
    case nameDesc
    case ageAsc
    case ageDesc
  }
  
  // MARK: - Properties
  
  private var company: Company?
  private var order = Order.none
  private var searchResults: Members? {
    get {
      var results = company?.members
      return results
    }
  }
  
  // MARK: - UI Properties
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 72.0
    tableView.tableFooterView = UIView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: "memberCell")
    
    return tableView
  }()
  private let searchController = UISearchController(searchResultsController: nil)
  
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
    
    title = company?.name.appending(" members")
    setupNavigationItems()
    setupUI()
    setupSearchController()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    searchController.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Setup
  
  private func setupNavigationItems() {
    let sortBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "sort"), style: .plain, target: self, action: #selector(showSortController))
    navigationItem.rightBarButtonItems = [ sortBarButton ]
  }
  
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    
    // Table view
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func setupSearchController() {
    searchController.delegate = self
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search by Member Name"
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  // MARK: - Actions
  
  @objc private func showSortController() {
    let alert = UIAlertController(title: "Sort Company List by", message: nil, preferredStyle: .actionSheet)
    var sortAscendingTitle = "Name ascending A → Z"
    alert.addAction(UIAlertAction(title: sortAscendingTitle, style: .default, handler: { _ in
      self.updateSearchResults(for: self.searchController)
    }))
    var sortDescendingTitle = "Name descending Z → A"
    alert.addAction(UIAlertAction(title: sortDescendingTitle, style: .default, handler: { _ in
      self.updateSearchResults(for: self.searchController)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

extension MembersViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberTableViewCell
    if let member = searchResults?[indexPath.row] { cell.configureWith(member) }
    return cell
  }
}

extension MembersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let member = searchResults?[indexPath.row] else { return }
  }
}

extension MembersViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    tableView.reloadData()
  }
  
  func willPresentSearchController(_ searchController: UISearchController) {
    navigationItem.rightBarButtonItem = nil
  }
  
  func willDismissSearchController(_ searchController: UISearchController) {
    setupNavigationItems()
  }
}
