//
//  SearchViewController.swift
//  matchRestaurant
//
//  Created by Kazuki Omori on 2022/01/25.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = ShopViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            loadShopData()
    }
    private func loadShopData(){
        viewModel.getShopData {[weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInsection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopTableViewCell
        
        let shop = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValueOf(shop)
        
        return cell
    }
    
    
}
