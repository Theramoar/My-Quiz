//
//  CoreDataManager.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 14/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager {
    private static var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
//MARK:- Load Data Methods
    static func loadDataFromContainer<T: NSManagedObject>(ofType type: T.Type) -> [T] {
        var data = [ T]()
        let entityName = NSStringFromClass(type)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        do {
            data = try context.fetch(fetchRequest)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return data
    }
    
//MARK:- Save Data Methods
    static func saveQuestionToContainer(data: CurrentQuestion, chosenIndex: Int) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Question", in: context) else { return }
        let question = NSManagedObject(entity: entity, insertInto: context) as! Question
        
        question.answers = data.answers
        question.question = data.question
        question.correctIndex = Int16(data.correctIndex)
        question.date = Date()
        question.chosenIndex = Int16(chosenIndex)
        
        saveContext()
    }
    
    static func saveScoreToContainer(userScore: Int) {
        if let existingScore = checkScoreDate() {
            existingScore.score += Int16(userScore)
        }
        else {
            guard let entity = NSEntityDescription.entity(forEntityName: "Score", in: context) else { return }
            let score = NSManagedObject(entity: entity, insertInto: context) as! Score
            score.score = Int16(userScore)
            score.date = Date()
        }
        saveContext()
    }

//MARK:- Supporting Methods
    private static func checkScoreDate() -> Score? {
        UserData.shared.scores.first(where: { Calendar.current.isDateInToday($0.date!) })
    }
    
    private static func saveContext() {
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
