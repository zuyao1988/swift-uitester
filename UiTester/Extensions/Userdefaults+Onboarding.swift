//
//  Userdefaults+Onboarding.swift
//  UiTester
//
//  Created by Tzuu Yao Lee on 20/9/20.
//  Copyright © 2020 Tzuu Yao Lee. All rights reserved.
//

import Foundation


extension UserDefaults {
    var onboardingCompleted: Bool {
        get { return bool(forKey: #function)}
        set {
            setValue(newValue, forKey: #function)
        }
    }
}
