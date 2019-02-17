//
//  ViewController.swift
//  changeProfile
//
//  Created by b1018193 on 2/17/19.
//  Copyright © 2019 b1018193. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //星の形を決める変数
    var starNumber: Int = 1 //アカウント情報から持ってくる必要あり
    
    var starImage: UIImage!
    
    @IBOutlet weak var starView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextView!
    
    @IBAction func selectStar(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            starNumber = 1
        case 1:
            starNumber = 2
        case 2:
            starNumber = 3
        case 3:
            starNumber = 4
        case 4:
            starNumber = 5
        case 5:
            starNumber = 6
        default:
            starNumber = 1
        }
        View()
    }
    @IBAction func returnButton(_ sender: UIButton) {
    }
    
    func View() {
        starImage = UIImage(named:"star\(starNumber).png")
        starView.image = starImage
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        View()
        nameTextField.text = "太郎"//アカウント情報から値を持ってくる
        messageTextField.text = "テニスと音楽が好きな男子大学１年生です。友達がほしいので気軽に友だち追加してください"//アカウント情報から値を持ってくる
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

