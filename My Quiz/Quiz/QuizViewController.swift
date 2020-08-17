//
//  QuizViewController.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 13/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit
import AmazonIVSPlayer

class QuizViewController: UIViewController, UpdateInterfaceDelegate {
    
    @IBOutlet weak var playerView: IVSPlayerView!
    @IBOutlet weak var earnedPointsLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel = QuizViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStackView.isHidden = true
        viewModel.setupPlayerForView(playerView)
        viewModel.delegate = self
        
        setupButtonAppearence(for: answer1Button)
        setupButtonAppearence(for: answer2Button)
        setupButtonAppearence(for: answer3Button)
        setupButtonAppearence(for: answer4Button)
        
        activityIndicator.startAnimating()
    }
    
    private func setupButtonAppearence(for button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.pausePlayer()
    }
    
//MARK: - Methods For Buttons
    @IBAction func answer1Pressed(_ sender: Any) {
        viewModel.checkAnswer(forIndex: 0) {
            if !$0 { self.answer1Button.backgroundColor = .red }
        }
    }
    
    @IBAction func answer2Pressed(_ sender: Any) {
        viewModel.checkAnswer(forIndex: 1) {
            if !$0 { self.answer2Button.backgroundColor = .red }
        }
    }
    
    
    @IBAction func answer3Pressed(_ sender: Any) {
        viewModel.checkAnswer(forIndex: 2) {
            if !$0 { self.answer3Button.backgroundColor = .red }
        }
    }
    
    
    @IBAction func answer4Pressed(_ sender: Any) {
        viewModel.checkAnswer(forIndex: 3) {
            if !$0 { self.answer4Button.backgroundColor = .red }
        }
    }
    
//MARK: - UpdateInterfaceDelegate Methods
    func updateInterfaceWithNewQuestion(_ question: CurrentQuestion) {
        buttonStackView.isHidden = false
        questionLabel.text = question.question
        answer1Button.setTitle("\(question.answers[0])", for: .normal)
        answer1Button.backgroundColor = .systemIndigo
        answer1Button.isEnabled = true
        answer2Button.setTitle("\(question.answers[1])", for: .normal)
        answer2Button.backgroundColor = .systemIndigo
        answer2Button.isEnabled = true
        answer3Button.setTitle("\(question.answers[2])", for: .normal)
        answer3Button.backgroundColor = .systemIndigo
        answer3Button.isEnabled = true
        answer4Button.setTitle("\(question.answers[3])", for: .normal)
        answer4Button.backgroundColor = .systemIndigo
        answer4Button.isEnabled = true
    }
    
    func updateInterfaceForAnswer(_ question: CurrentQuestion) {
        switch question.correctIndex {
        case 0:
            answer1Button.backgroundColor = .green
        case 1:
            answer2Button.backgroundColor = .green
        case 2:
            answer3Button.backgroundColor = .green
        case 3:
            answer4Button.backgroundColor = .green
        default:
            break
        }
        earnedPointsLabel.text = "Earned Points: \(viewModel.earnedPoints)"
        answer1Button.isEnabled = false
        answer2Button.isEnabled = false
        answer3Button.isEnabled = false
        answer4Button.isEnabled = false
    }
    
    func updatePlayerView() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        guard
            let height = playerView.player?.videoSize.height,
            let width = playerView.player?.videoSize.width
        else { return }

        let ratio = width / height

        viewHeightConstraint.constant = UIScreen.main.bounds.width / ratio
    }
    
}

