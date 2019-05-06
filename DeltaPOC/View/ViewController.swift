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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
}
// TableView Extension
 extension ViewController: UITableViewDelegate,UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
           //fetching data from viewmodel
            cell.textLabel?.text = viewModal.cellForRowData(index: indexPath)
            
            //Set Image using kingfisher
            let url = URL(string: viewModal.cellForRowImage(index: indexPath))
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


