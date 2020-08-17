//
//  QuestionCell.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 14/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var answer1Label: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    @IBOutlet weak var answer3Label: UILabel!
    @IBOutlet weak var answer4Label: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    weak var viewModel: QuestionCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            questionLabel.text = viewModel.questionText
            answer1Label.text = viewModel.questionAnswers[0]
            answer2Label.text = viewModel.questionAnswers[1]
            answer3Label.text = viewModel.questionAnswers[2]
            answer4Label.text = viewModel.questionAnswers[3]
            dateLabel.text = viewModel.questionDate
            setupResultLabel(chosenIndex: viewModel.chosenAnswerIndex,
                             correctIndex: viewModel.correctAnswerIndex)
            
            reloadLabelColors()
            highlightCorrectAnswer(with: viewModel.correctAnswerIndex)
            highlightChosenAnswer(chosenIndex: viewModel.chosenAnswerIndex,
                                      correctIndex: viewModel.correctAnswerIndex)
            
            self.selectionStyle = .none
        }
    }
    
    
//MARK:- Label Color Update Methods
    private func reloadLabelColors() {
        answer1Label.textColor = .label
        answer2Label.textColor = .label
        answer3Label.textColor = .label
        answer4Label.textColor = .label
    }
    
    private func highlightCorrectAnswer(with index: Int) {
        switch index {
        case 0:
            answer1Label.textColor = .green
        case 1:
            answer2Label.textColor = .green
        case 2:
            answer3Label.textColor = .green
        case 3:
            answer4Label.textColor = .green
        default:
            break
        }
    }
    
    private func highlightChosenAnswer(chosenIndex: Int, correctIndex: Int) {
        guard chosenIndex != correctIndex else { return }
        switch chosenIndex {
        case 0:
            answer1Label.textColor = .red
        case 1:
            answer2Label.textColor = .red
        case 2:
            answer3Label.textColor = .red
        case 3:
            answer4Label.textColor = .red
        default:
            break
        }
    }
    
    private func setupResultLabel(chosenIndex: Int, correctIndex: Int) {
        resultLabel.text = chosenIndex == correctIndex ? "You have chosen correctly!" : "You have chosen incorrectly"
        resultLabel.textColor = chosenIndex == correctIndex ? .green : .red
    }
}


class QuestionCellViewModel: CellViewModelType {
    private let question: Question
    
    var questionText: String {
        question.question ?? ""
    }
    var questionAnswers: [String] {
        question.answers ?? []
    }
    
    
    var questionDate: String {
        guard let date = question.date else { return "" }
        return Date().offset(from: date)
    }
    
    var correctAnswerIndex: Int {
        Int(question.correctIndex)
    }
    
    var chosenAnswerIndex: Int {
         Int(question.chosenIndex)
     }
    
    init(question: Question) {
        self.question = question
    }
}


