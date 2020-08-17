//
//  QuizViewModel.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 13/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import AmazonIVSPlayer

protocol UpdateInterfaceDelegate: AnyObject {
    func updateInterfaceForAnswer(_ question: CurrentQuestion)
    func updateInterfaceWithNewQuestion(_ question: CurrentQuestion)
    func updatePlayerView()
}

class QuizViewModel: NSObject, IVSPlayer.Delegate {
    
    private let player = IVSPlayer()
    private var currentQuestion: CurrentQuestion?
    var earnedPoints = 0
    weak var delegate: UpdateInterfaceDelegate?
    
    
    func setupPlayerForView(_ view: IVSPlayerView) {
        let url = URL(string: "https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.xhP3ExfcX8ON.m3u8")
        player.delegate = self
        view.player = player
        player.load(url)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(applicationDidEnterBackground(_:)),
        name: UIApplication.didEnterBackgroundNotification,
        object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(applicationDidBecomeActive(_:)),
        name: UIApplication.didBecomeActiveNotification,
        object: nil)
    }
    
    @objc func applicationDidEnterBackground(_ notification: NSNotification) {
        pausePlayer()
    }
    
    @objc func applicationDidBecomeActive(_ notification: NSNotification) {
        player.play()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func checkAnswer(forIndex index: Int, closure: @escaping (Bool) -> ()) {
        guard let question = currentQuestion else { return }
        if question.correctIndex == index {
            earnedPoints += 1
            CoreDataManager.saveScoreToContainer(userScore: 1)
        }
        else {
            closure(false)
        }
        CoreDataManager.saveQuestionToContainer(data: question, chosenIndex: index)
        delegate?.updateInterfaceForAnswer(question)
    }
    
    func pausePlayer() {
        player.pause()
    }
    

//MARK: - IVSPlayer Methods
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        if state == .ready {
            player.play()
        }
    }
    
    func player(_ player: IVSPlayer, didChangeVideoSize videoSize: CGSize) {
        delegate?.updatePlayerView()
    }
    
    func player(_ player: IVSPlayer, didOutputCue cue: IVSCue) {
        if let textMetadataCue = cue as? IVSTextMetadataCue {
            setupQuestion(withText: textMetadataCue.text)
        }
    }
    
    
//MARK: - Private Methods
    private func setupQuestion(withText text: String) {
        let data = Data(text.utf8)
        guard let question = decodeJSON(type: CurrentQuestion.self, from: data) else { return }
        currentQuestion = question
        delegate?.updateInterfaceWithNewQuestion(question)
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
