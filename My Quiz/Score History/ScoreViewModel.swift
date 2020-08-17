//
//  ScoreViewModel.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 14/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation

class ScoreHistoryViewModel: TableViewViewModelType {
    private var scores: [Score] {
        UserData.shared.scores
    }
    
    var numberOfRows: Int {
        scores.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType? {
        ScoreCellViewModel(score: scores[indexPath.row])
    }
}
