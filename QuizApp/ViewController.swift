//
//  ViewController.swift
//  QuizApp
//
//  Created by Alexey Papin on 05.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let soundStart = Sound(name: "start")
    let soundCompleted = Sound(name: "completed")
    let soundSuccess = Sound(name: "success")
    let soundFailure = Sound(name: "failure")

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton3: UIButton!
    @IBOutlet weak var choiceButton4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func playAgain(_ sender: Any) {
        soundStart.play()
        buttonFlash(sender: playAgainButton)
    }

    func buttonFlash(sender: UIButton) {
        let bounds = sender.bounds
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 7.0,
            options: [.curveEaseInOut, .curveLinear, .beginFromCurrentState],
            animations: {
                sender.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y - 20, width: bounds.size.width + 60, height: bounds.size.height + 30)
                sender.isEnabled = false
            },
            completion: nil
        )
        
        sender.bounds = CGRect(x: Double(bounds.origin.x), y: Double(bounds.origin.y), width: Double(bounds.size.width), height: Double(bounds.size.height))
        sender.isEnabled = true
    }
    
}
