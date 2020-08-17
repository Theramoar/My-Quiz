//
//  ViewController.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 13/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit



class MenuViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var questionHistoryButton: UIButton!
    @IBOutlet weak var scoreHistoryButton: UIButton!
    
    private let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAppearence(for: playButton)
        setupButtonAppearence(for: questionHistoryButton)
        setupButtonAppearence(for: scoreHistoryButton)
    }
    
    private func setupButtonAppearence(for button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoreLabel.text = viewModel.scorePoints
    }
    
    func updateMenuScore() {
        scoreLabel.text = viewModel.scorePoints
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "GoToQuiz", sender: self)
    }
    
    @IBAction func questionButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "GoToQuestionHistory", sender: self)
    }
    
    @IBAction func scoreButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "GoToScoreHistory", sender: self)
    }
}
