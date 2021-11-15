//
//  SearchResultsTableViewController.swift
//  EventsApp
//
//  Created by Ganesh Somani on 14/11/21.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    private var searchResults = [EventViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    private let searchController = UISearchController(searchResultsController: nil)
    private let service = SearchEventService()
    private var previousRun = Date()
    private let minInterval = 0.05

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        tableView.tableFooterView = UIView()
        setupTableViewBackgroundView()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchController.searchBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchController.searchBar.isHidden = true
    }

    private func setupTableViewBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.text = "Oops, No results to show"
        backgroundViewLabel.textAlignment = NSTextAlignment.center
        backgroundViewLabel.font.withSize(20)
        tableView.backgroundView = backgroundViewLabel
    }

    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search any Event"
        tableView.tableHeaderView = searchController.searchBar
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as? EventSearchTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(searchResults[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchController.searchBar.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let eventDetailVC = storyboard.instantiateViewController(withIdentifier: "EventDetailVC") as? EventDetailViewController else {
            return
        }
        eventDetailVC.eventViewModel = searchResults[indexPath.row]
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
    }
}

// MARK: UISearchBarDelegate
extension SearchResultsTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }

        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchResults(for: textToSearch)
        }
    }

    func fetchResults(for text: String) {
        service.getSeachResults(for: text) { [weak self] data, error in
            if error != nil {
                self?.searchResults.removeAll()
                return
            }

            if let events = data?.events?.map({ EventViewModel(dataModel: $0) }) {
                self?.searchResults = events
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }

}
