//
//  ScoreCell.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 14/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {
    

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreDateLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    weak var viewModel: ScoreCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            scoreLabel.text = viewModel.scoreText
            scoreDateLabel.text = viewModel.scoreDateString
            self.selectionStyle = .none
            infoLabel.text = viewModel.infoString
        }
    }
}

class ScoreCellViewModel: CellViewModelType {
    private var score: Score
    
    private var questionsThatDay: [Question] {
        UserData.shared.questions.filter({
            Calendar.current.isDate($0.date!, equalTo: score.date!, toGranularity: .day)
        })
    }
    
    var infoString: String {
        let correctCount = questionsThatDay.filter( {$0.correctIndex == $0.chosenIndex} ).count
        return "\(correctCount) out of \(questionsThatDay.count) were answered correclty."
    }
    
    var scoreText: String {
        "Score: \(score.score)"
    }
    
    var scoreDateString: String {
        guard let date = score.date else { return "" }
        return getDateString(date: date)
    }
    
    private func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    init(score: Score) {
        self.score = score
    }
}

