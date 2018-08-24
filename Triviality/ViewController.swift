//
//  ViewController.swift
//  Triviality
//
//  Created by Britney Smith on 8/23/18.
//  Copyright © 2018 Britney Smith. All rights reserved.
//

/*
 *App Challenge #9: Triviality*
 
 Create a trivia game application consisting of at least 8 questions
 If the user guesses a question correctly, the background of the app should flash green, and the user should be taken to the next question
 If the user chooses an incorrect answer, the background of the app should flash red, and that answer should be disabled
 If the user gets more than 3 questions wrong, the user should lose the game
 At the end of the game, your app should show the user their score
 The user should be able to start over when the game ends
 */

import UIKit

struct Question {
    var question:String
    var answers:[String]
    var correctAnswer:Int
}

class ViewController: UIViewController {

    @IBOutlet weak var TriviaQuestionLabel: UILabel!
    
    @IBOutlet weak var AnswerALabel: UILabel!
    @IBOutlet weak var AnswerBLabel: UILabel!
    @IBOutlet weak var AnswerCLabel: UILabel!
    @IBOutlet weak var AnswerDLabel: UILabel!
    
    @IBOutlet weak var AnswerAButton: UIButton!
    @IBOutlet weak var AnswerBButton: UIButton!
    @IBOutlet weak var AnswerCButton: UIButton!
    @IBOutlet weak var AnswerDButton: UIButton!
    // dictionary - Int key: tuple(String, [String]) value
    //var questions:[ Int: (question:String, answer:[String], correctAnswer:Int) ] = [:]
    
    var score = 0
    var isGuessCorrect = false
    var isAnswerCorrect = false
    var currentQuestionIndex = 0
    var correctAnswer = 0
    
    let questionOne = Question(question: "Question One?", answers: ["AnswerA","AnswerBCorrect","AnswerC","AnswerD"], correctAnswer: 1)
    let questionTwo = Question(question: "Question Two?", answers: ["AnswerA","AnswerB","AnswerC","AnswerDCorrect"], correctAnswer: 3)
    let questionThree = Question(question: "Question Three?", answers: ["AnswerACorrect","AnswerB","AnswerC","AnswerD"], correctAnswer: 0)
    let questionFour = Question(question: "Question Four?", answers: ["AnswerACorrect","AnswerB","AnswerC","AnswerD"], correctAnswer: 0)
    /*
     class MyOwn {
     let myUser: User
     var life: Int
     
         init() {
         self.myUser = User(name: "John", age: 100)
         self.life = myUser.age
         }
     }
     */
    var questions:[Question]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setQuestions() {
        self.questions = [questionOne, questionTwo, questionThree, questionFour]
//        self.questions = [0:(question:"Question1",
//                             answer: ["AnswerA","AnswerBCorrect","AnswerC","AnswerD"],
//                             correctAnswer: 1),
//                          1:(question:"Question2",
//                             answer: ["AnswerA","AnswerB","AnswerC","AnswerDCorrect"], correctAnswer: 3)]
        //                                                                    2:"",
        //                                                                    3:"",
        //                                                                    4:"",
        //                                                                    5:"",
        //                                                                    6:"",
        //                                                                    7:"",]
    }
    

    func loadQuestion(questionNumber: Int) {
        //if let question = questions[questionNumber]?.question {
            TriviaQuestionLabel.text = questions[questionNumber].question
//        } else {
//            TriviaQuestionLabel.text = "err: No question"
//            return
//        }
    }
    
    
    
    func checkGuess(questionIndex:Int, guess: String) {
        let correct = questions[questionIndex].answers[correctAnswer]
        print("Correct answer: \(correct)")
        if guess == correct {
            self.score+=1
            loadQuestion(questionNumber: (questionIndex + 1))//move on to next question
        } else {
            self.score-=1
            loadQuestion(questionNumber: (questionIndex + 1))//move on to next question
        }
      
    }

}

