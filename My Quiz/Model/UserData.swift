//
//  UserData.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 15/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation

class UserData {
    static let shared = UserData()
    var questions: [Question] {
        let questions = CoreDataManager.loadDataFromContainer(ofType: Question.self)
        let sorted = questions.sorted(by: { $0.date ?? Date() > $1.date ?? Date() })
        return sorted
    }
    var scores: [Score] {
        let scores = CoreDataManager.loadDataFromContainer(ofType: Score.self)
        let sorted = scores.sorted(by: { $0.date ?? Date() > $1.date ?? Date() })
        return sorted
    }
    private init() {}
}


struct CurrentQuestion: Decodable {
    let question: String
    let answers: [String]
    let correctIndex: Int
}
