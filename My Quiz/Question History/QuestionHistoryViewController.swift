//
//  QuestionHistoryVC.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 14/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit



class QuestionHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = QuestionHistoryViewModel()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension QuestionHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath) as? QuestionCellViewModel
        return cell
    }
}
