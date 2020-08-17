//
//  QuestionHistoryViewModel.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 14/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation

class QuestionHistoryViewModel: TableViewViewModelType {
    
    private var questions: [Question] {
        UserData.shared.questions
    }
    var numberOfRows: Int {
        questions.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType? {
        QuestionCellViewModel(question: questions[indexPath.row])
    }
}
