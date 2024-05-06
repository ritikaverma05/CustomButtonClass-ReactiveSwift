//
//  ViewController.swift
//  CustomButtonClass
//
//  Created by Ritika Verma on 06/12/23.
//

import UIKit
import ReactiveSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonApple: CustomButton!
    @IBOutlet weak var buttonGoogle: CustomButton!
    @IBOutlet weak var buttonFacebook: CustomButton!
    @IBOutlet weak var buttonSignUp: CustomButton!
    @IBOutlet weak var buttonContinue: CustomButton!
    
    let disposable = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        buttonApple.buttonConfiguration = CustomButtonConfiguration(title: "Continue with Apple", titleColor: .white, backgroundColor: .black, imageBeforeTitle: UIImage(named: "symbolApple"))
        
        buttonGoogle.buttonConfiguration = CustomButtonConfiguration(title: "Continue with Google", backgroundColor: UIColor(red: 0.937, green: 0.945, blue: 0.965, alpha: 1), imageBeforeTitle: UIImage(named: "symbolGoogle"))
        
        buttonFacebook.buttonConfiguration = CustomButtonConfiguration(title: "Continue with Facebook", titleColor: .white, backgroundColor: UIColor(red: 0, green: 0.325, blue: 0.812, alpha: 1), imageBeforeTitle: UIImage(named: "symbolFacebook"))
        
        buttonSignUp.buttonConfiguration = CustomButtonConfiguration(title: "Sign Up", showShadow: true)
        
        buttonContinue.buttonConfiguration = CustomButtonConfiguration(title: "Continue", titleColor: .white, backgroundColor: .black, showShadow: true)
        
        
        self.disposable += buttonApple.actionSignal.output.producer.startWithValues { value in
            print("Apple Action")
            self.buttonFacebook.closeActivityIndicator()
        }
        
        self.disposable += buttonGoogle.actionSignal.output.producer.startWithValues { value in
            print("Google Action")
            self.buttonFacebook.showActivityIndicator()
        }
        
        self.disposable += buttonFacebook.actionSignal.output.producer.startWithValues { value in
            print("Facebook Action")
        }
        
        self.disposable += buttonSignUp.actionSignal.output.producer.startWithValues { value in
            print("Sign Up Action")
        }
        
    }
    
    deinit {
        self.disposable.dispose()
    }
    
}

