//
//  MenuViewModel.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 15/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation

class MenuViewModel {
    private var currentScore: Score? {
        UserData.shared.scores.first(where: {
            guard let date = $0.date else { return false }
            return Calendar.current.isDateInToday(date)
        })
    }
    
    var scorePoints: String {
        "Your points today: \(currentScore?.score ?? 0)"
    }
}
