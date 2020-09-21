//
//  OnboardingPageVC.swift
//  UiTester
//
//  Created by Tzuu Yao Lee on 20/9/20.
//  Copyright © 2020 Tzuu Yao Lee. All rights reserved.
//

import UIKit

class OnboardingPageVC: UIViewController {

    var userDefaults = UserDefaults.standard
    
    @IBAction func doneBtnPressed() {
        userDefaults.onboardingCompleted = true
        dismiss(animated: true, completion: nil)
    }

    @IBAction func alertBtnPressed() {
        let alert = UIAlertController(title: "Oh Yeah", message: "some msg", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.view.accessibilityIdentifier = "Alert"
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
