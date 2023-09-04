//
//  ViewController.swift
//  Hive-iOS-Assignment
//
//  Created by MD Faizan on 01/09/23.
//

import UIKit


final class MainViewController: UIViewController {
    
    @IBOutlet weak private var resultTableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    let viewModel = MainViewControllerViewModel()
    
    private var searchTimer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureHeaderView()
        setupListerner()
    }
    
    private func setupTableView() {
        resultTableView.dataSource = self
        searchBar.delegate = self
        resultTableView.register(UINib(nibName: Constants.resultTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.resultTableViewCell)
        
        
    }
    
    private func setupListerner() {
        viewModel.reload = { [weak self] in
            DispatchQueue.main.async {
                self?.resultTableView.reloadData()
            }
        }
    }
    
    private func configureHeaderView() {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: resultTableView.frame.width, height: 40))
        headerView.backgroundColor = .lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: resultTableView.frame.width, height: 40))
        
        headerLabel.text = "Results"
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        resultTableView.tableHeaderView = headerView
    }
}


//MARK:- UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //Upon empty searchBar remove all results from tableview
        if searchText.isEmpty {
            viewModel.searchResults.removeAll()
            resultTableView.reloadData()
        }
        
        // Invalidate the previous timer, so it doesn't fire
        searchTimer?.invalidate()
        
        // Don't search if less than 3 characters are entered
        guard searchText.count >= 3 else { return }
        
        // Start a new timer with a delay of 1.0 seconds
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            
            self?.viewModel.searchWikipedia(query: searchText)
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        // Don't search if less than 3 characters are entered
        guard searchText.count >= 3 else { return }
        
        viewModel.searchWikipedia(query: searchText)
        searchBar.resignFirstResponder()
    }
}

extension MainViewController: UITableViewDataSource,UITableViewDelegate {
    
    //MARK:  UITableViewDataSource method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = resultTableView.dequeueReusableCell(withIdentifier: Constants.resultTableViewCell, for: indexPath) as? ResultTableViewCell
        cell?.configureCell(viewModel.searchResults[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
    //MARK:  UITableViewDelegate method
    // Calculate dynamic cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Set an estimated row height
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
