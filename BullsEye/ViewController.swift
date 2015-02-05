//
//  ViewController.swift
//  BullsEye
//
//  Created by Ryan on 2015/2/4.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
  var currentValue = 0
  var targetValue = 0
  var score = 0
  var round = 0
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var slider: UISlider!


  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    startNewGame()
    updateLabels()
    
    
    let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
    slider.setThumbImage(thumbImageNormal , forState: .Normal)
    let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
    slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
    
    let insets = UIEdgeInsets(top: 0, left:14, bottom: 0, right: 14)
    
    if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
      let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
      slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
    }
    
    if let trackRightImage = UIImage(named: "SliderTrackRight") {
      let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
      slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func  startNewRound() {
    self.targetValue = 1 + Int(arc4random_uniform(100))
    self.currentValue = 50
    self.slider.value = Float(currentValue)
    self.round += 1
  }
  
  func updateLabels() {
    self.targetLabel.text = String(self.targetValue)
    self.scoreLabel.text = String(self.score)
    self.roundLabel.text = String(self.round)
  }
  func startNewGame() {
    
    self.round = 0
    self.score = 0
    startNewRound()
  }
    
  @IBAction func showAlert() {
    
    /*
    var difference = self.currentValue - self.targetValue
    if difference < 0 {
      difference = difference * -1
    }
    */
    
    let difference = abs(self.targetValue - self.currentValue)
    var points = 100 - difference

    var title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "You almost had it"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      title = "Pretty good!"
    } else {
      title = "not even close..."
    }

    self.score += points

    let message = "The value of the slider is: \(self.currentValue) \n" + "the target value is: \(self.targetValue)"
        
    let alert = UIAlertController(title: title,
                                    message: message,
                             preferredStyle: .Alert)
        
    let action = UIAlertAction(title: "OK", style: .Default,
      handler: {
        action in
          self.startNewRound()
          self.updateLabels()
      })
        
    alert.addAction(action)
    
    // Here you make the alert vivible
    presentViewController(alert, animated: true, completion: nil)
    
    //startNewRound()
    //updateLabels()
    
  }
    
    
  @IBAction func sliderMoved(slider: UISlider) {
      self.currentValue = lroundf(slider.value)
      println(" The value of the slider is now: \(self.currentValue)")
  }
    

  @IBAction func startOver() {
    startNewGame()
    updateLabels()
    
    let transition = CATransition()
    transition.type = kCATransitionFade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    view.layer.addAnimation(transition, forKey: nil)
  }

}

