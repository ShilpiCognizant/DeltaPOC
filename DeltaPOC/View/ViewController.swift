//
//  ViewController.swift
//  DeltaPOC
//
//  Created by shilpi gupta on 06/05/19.
//  Copyright © 2019 shilpi gupta. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var viewModal : ViewModel!
    @IBOutlet var tableView : UITableView!
    var cellIdentifier = "cell"
    private let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        //Add target to refresh table
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        //Register Cell Identifier
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // Call API
        self.viewModal.fetchData  {
            // GCD
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //Refresh TableView
    @objc private func refreshData(_ sender: Any) {

        // Call API
        self.viewModal.fetchData  {
            // GCD
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
// TableView Extension
 extension ViewController: UITableViewDelegate,UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
           //fetching data from viewmodel
            cell.textLabel?.text = viewModal.cellForRowData(indexPath: indexPath)
            
            //Set Image using kingfisher
            let url = URL(string: viewModal.cellRowImage(indexPath: indexPath))
            cell.imageView?.kf.setImage(with:url)
            
            return cell
    
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModal.numberOfRowsInSection(section: section)
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return 80
        }
 }

// TableView Extension
extension ViewController {
    
}
