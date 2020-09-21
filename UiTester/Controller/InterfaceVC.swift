//
//  InterfaceVC.swift
//  UiTester
//
//  Created by Tzuu Yao Lee on 20/9/20.
//  Copyright © 2020 Tzuu Yao Lee. All rights reserved.
//

import UIKit

class InterfaceVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loadImageBtn: UIButton!
    @IBOutlet weak var someImageIV: UIImageView!
    @IBOutlet weak var imageLbl: UILabel!
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("yyy")
        
        imageLbl.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("xxxxx")
        super.viewDidAppear(animated)
        if !userDefaults.onboardingCompleted {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let onboardingVC = storyboard.instantiateViewController(withIdentifier: STORYBOARD_ID_ONBOARDING_VC) as? OnboardingVC else {return}
            
            //only full screen will trigger the viewdidAppear again
            onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "You did it!", message: "awesome", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "YAY!", style: .default, handler: nil)
            
            alertVC.addAction(alertAction)
            present(alertVC, animated: true, completion: nil)
        }
    }

    //return nth
    func downloadImage(fromURL urlString: String, completion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                fatalError()
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                fatalError()
            }
            
            completion(image)
        }.resume()
    }
    
    @IBAction func loadImageBtnPressed() {
        if someImageIV.image == nil {
            downloadImage(fromURL: IMAGE_URL) { (image) in
                DispatchQueue.main.async {
                    self.someImageIV.image = image
                    self.imageLbl.isHidden = false
                }
            }
        }
    }
}
