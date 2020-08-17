//
//  ScoreHistoryVC.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 14/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit


class ScoreHistoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ScoreHistoryViewModel()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ScoreHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath) as? ScoreCellViewModel
        return cell
    }
    
    
}
