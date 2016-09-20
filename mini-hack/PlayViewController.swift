//
//  PlayViewController.swift
//  mini-hack
//
//  Created by Admin on 9/19/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CircleProgressView
class PlayViewController: UIViewController {

    
    
    @IBOutlet weak var lblCurrentScore: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    
    
    @IBOutlet weak var lblNamePokemon: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    var score = 0
    var old = [Int]()
    var rightPokemon : Int!
    var nameRight : String!
    var nameWrong = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func btnDidTap(sender: UIButton) {
        imgPokemon.image = UIImage(named: ModelManager.pokemon[self.rightPokemon].img)
        lblNamePokemon.text = ModelManager.pokemon[self.rightPokemon].tag + " " + ModelManager.pokemon[self.rightPokemon].name
        if sender.titleLabel!.text! == nameRight {
            sender.backgroundColor = UIColor.blueColor()
            score += 1
            lblCurrentScore.text = String(score)
        }
        else{
            sender.backgroundColor = UIColor.redColor()
            let btn = [btn1,btn2,btn3,btn4]
            for i in 0...btn.count-1 {
                if btn[i].titleLabel?.text == nameRight {
                    btn[i].backgroundColor = UIColor.blueColor()
                }
                btn[i].enabled = false
            }
        }
        
        reSetupView()
    }
    
    func setupView(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        lblNamePokemon.text = ""
        lblCurrentScore.text = String(score)
        //important ============
        setupOther()
        self.view.backgroundColor = UIColor.hexStringToUIColor(ModelManager.pokemon[rightPokemon].color)
        var btn = [btn1,btn2,btn3,btn4]
        print("btn : \(btn.count)")
        for i in 0...btn.count-1 {
            btn[i].backgroundColor = UIColor.whiteColor()
            btn[i].cornerView(10)
            btn[i].tintColor = UIColor.blackColor()
            btn[i].enabled = true
        }
        imgPokemon.cornerView(10)
        let rightButton = randomButtonForRightAnswer()
        btn[rightButton].setTitle(self.nameRight, forState: UIControlState.Normal)
        btn.removeAtIndex(rightButton)
        for i in 0...2 {
            btn[i].setTitle(ModelManager.pokemon[nameWrong[i]].name, forState: UIControlState.Normal)
        }
        print(btn1.titleLabel?.text)
        print(btn2.titleLabel?.text)
        let image = UIImage(named: ModelManager.pokemon[self.rightPokemon].img)
        self.imgPokemon.image = UIImage.processPixelsInImage(image!)
        self.nameWrong.removeAll()
    }
    
    
    func reSetupView() {
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //put your code which should be executed with a delay here
            self.setupView()
        }
    }
    
    
    
    func setupOther() {
        self.rightPokemon = randomPokemon()
        self.nameRight = ModelManager.pokemon[rightPokemon].name
        randomNameOther()
        randomNameOther()
        randomNameOther()
    }
    
    func randomPokemon() -> Int{
        var random = Int(arc4random_uniform(UInt32(ModelManager.pokemon.count -  1 )))
        
        while old.contains(random) {
            random = Int(arc4random_uniform(UInt32(ModelManager.pokemon.count - 1 )))
        }
        
        old.append(random)
        return random
    }
    
    func randomNameOther() {
        var random = Int(arc4random_uniform(UInt32(ModelManager.pokemon.count - 1)))
        while ModelManager.pokemon[random].name == self.nameRight || nameWrong.contains(random){
            random = Int(arc4random_uniform(UInt32(ModelManager.pokemon.count - 1)))
        }
        nameWrong.append(random)
    }
    func randomButtonForRightAnswer() -> Int{
        let random = Int(arc4random_uniform(UInt32(4)))
        return random
    }
}
