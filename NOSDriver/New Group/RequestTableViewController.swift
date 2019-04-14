//
//  RequestTableViewController.swift
//  NOSDriver
//
//  Created by Ian Manor on 13/04/19.
//  Copyright © 2019 Ian Manor. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class RequestTableViewController: UITableViewController, Storyboarded {
    let searchController = UISearchController(searchResultsController: nil)
    var requests = ["Pedido 1", "Pedido 2", "Pedido 3"]
    //var requests: [String] = []
    var filteredRequests = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
        setupSearchController()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar Pedidos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        if isFiltering() {
        return filteredRequests.count
        }
        
        return requests.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath)
        
        var request: String

        if isFiltering() {
            request = filteredRequests[indexPath.row]
        } else {
            request = requests[indexPath.row]
        }
        
        cell.textLabel?.text = request
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toRequest", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! RequestViewController
        
        var selectedRequest: String
        let selectedRow = tableView.indexPathForSelectedRow!.row
        if isFiltering() {
            selectedRequest = filteredRequests[selectedRow]
        } else {
            selectedRequest = requests[selectedRow]
        }
        
        destinationViewController.request = selectedRequest
        destinationViewController.title = selectedRequest
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRequests = requests.filter({( request : String) -> Bool in
            return request.localizedStandardContains(searchText)
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension RequestTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension RequestTableViewController: EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Nenhum pedido recebido.", attributes: nil)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Espere até alguém solicitar a retirada de entulho.", attributes: nil)
    }
}

extension RequestTableViewController: EmptyDataSetDelegate {}
