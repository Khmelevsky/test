//
//  ListViewController.swift
//  test
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    fileprivate var dataSource = [Place]()
    fileprivate var refreshControl: UIRefreshControl!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure tableView
        tableView.tableFooterView = UIView()
        
        // pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ListViewController.pullToRefresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        
        updateData()
    }
    
    // MARK: - Actions
    func pullToRefresh() {
        updateData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Logic
    func updateData() {
        LocationManager.getUserLocation { location in
            API.places(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
                self.dataSource = result?.places ?? []
                self.tableView.reloadData()
            }
        }
    }
    

}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.listPlaceCell.identifier, for: indexPath) as! ListPlaceCell
        let place = dataSource[indexPath.row]
        cell.titleLabel.text = place.name
        cell.imageView?.image = UIImage()
        if let url = place.photos.first?.url(size: 400) {
            cell.previewImageView.setImageWith(URL(string: url)!, placeholderImage:UIImage())
        } else if let url = place.iconURL {
            cell.previewImageView.setImageWith(URL(string: url)!, placeholderImage:UIImage())
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
}

// MARK: - Place cell 
class ListPlaceCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}
