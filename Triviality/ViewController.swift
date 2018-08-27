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
    var userGuess:String? = ""
    var questions:[Question] = []
    //var finished = true
    var wrongAnswerCounter = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame() {
        print("Start!")
        setAttributes()
        resetButtons()
        setQuestions()
        loadQuestion(questionNumber: 0)
    }
    
    func setQuestions() {
        self.questions = [Question(question: "What is the name of Luke Skywalker's birth mother?", answers: ["Donald Glover","Princess Amydala","Princess Amygdala","Jar Jar Binks"], correctAnswer: 1),
            Question(question: "In the Infinity War comics, who is Thanos in love with?", answers: ["Wonder Woman","Scarlet Witch","Black Widow","Lady Death"], correctAnswer: 3),
            Question(question: "Question Three?", answers: ["AnswerACorrect","AnswerB","AnswerC","AnswerD"], correctAnswer: 0),
            Question(question: "Question Four?", answers: ["AnswerACorrect","AnswerB","AnswerC","AnswerD"], correctAnswer: 0)]

    }
    
    func setAnswers(questionNumber:Int) {
        AnswerALabel.text = questions[questionNumber].answers[0]
        AnswerBLabel.text = questions[questionNumber].answers[1]
        AnswerCLabel.text = questions[questionNumber].answers[2]
        AnswerDLabel.text = questions[questionNumber].answers[3]
    }
    
    func setAttributes() {
        self.score = 0
        self.currentQuestionIndex = 0
        self.wrongAnswerCounter = 0
    }

    func loadQuestion(questionNumber:Int) {
        //self.view.backgroundColor = UIColor.white
        if questionNumber < questions.count {
            TriviaQuestionLabel.text = questions[questionNumber].question
            setAnswers(questionNumber: questionNumber)
        } else {
            // game over, display total score
            gameOver()
            displayScore()
        }
    }
    
    func checkLoseGame() {
        if self.wrongAnswerCounter == 3 {
            gameOver()
            displayScore()
        } else {
            return
        }
    }
    
    func gameOver() {
        print("buttons disabled")
        AnswerAButton.isEnabled = false
        AnswerBButton.isEnabled = false
        AnswerCButton.isEnabled = false
        AnswerDButton.isEnabled = false
    }
    
    func resetButtons() {
        print("buttons enabled")
        AnswerAButton.isEnabled = true
        AnswerBButton.isEnabled = true
        AnswerCButton.isEnabled = true
        AnswerDButton.isEnabled = true
    }
    
    func displayScore() {
        print("Total score: \(score)")
        let scoreAlert = UIAlertController(title: "Game Over", message: "Total Score: \(self.score)", preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { (action:UIAlertAction!) in self.startGame() }
        scoreAlert.addAction(continueAction)
        self.present(scoreAlert, animated: true, completion:nil)
    }
    
    
    func checkGuess(questionIndex:Int, guess:String) {
        print("Current question index: \(questionIndex)")
        let correctAnswerIndex = questions[questionIndex].correctAnswer
        print("Correct Answer index: \(correctAnswerIndex)")
        let correct = questions[questionIndex].answers[correctAnswerIndex]
        print("Current question: \(questions[questionIndex].question)")
        print("Correct answer: \(correct)")
        if guess == correct {
            //flash green
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = UIColor.green
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = UIColor.white
            })
            print("guess correct")
            self.score+=1
            print("Score: \(score)")
            loadQuestion(questionNumber: (questionIndex + 1))//move on to next question
            currentQuestionIndex+=1
        } else {
            //flash red
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = UIColor.red
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = UIColor.white
            })
            print("guess wrong")
            self.wrongAnswerCounter+=1
            checkLoseGame()
            self.score-=1
            print("Score: \(score)")
            loadQuestion(questionNumber: (questionIndex + 1))//move on to next question
            currentQuestionIndex+=1
        }
      
    }
    
    
    @IBAction func chooseAnswerButtonAction(sender: UIButton) {
        print("button pressed")
        
        if userGuess != nil {
            switch sender {
            case AnswerAButton:
                userGuess = AnswerALabel.text!
                print("AnswerALabel is guess: \(userGuess!)")
            case AnswerBButton:
                userGuess = AnswerBLabel.text!
                print("AnswerBLabel is guess: \(userGuess!)")
            case AnswerCButton:
                userGuess = AnswerCLabel.text!
                print("AnswerCLabel is guess: \(userGuess!)")
            case AnswerDButton:
                userGuess = AnswerDLabel.text!
                print("AnswerDLabel is guess: \(userGuess!)")
            default:
                print("Invalid response")
                return
            }
            checkGuess(questionIndex: currentQuestionIndex, guess: userGuess!)
        } else {
            print("Nothing is happening because userGuess is nil")
        }
        
    }
    
    
}

