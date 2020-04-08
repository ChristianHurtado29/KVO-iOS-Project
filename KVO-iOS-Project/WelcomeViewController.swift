//
//  WelcomeViewController.swift
//  KVO-iOS-Project
//
//  Created by Christian Hurtado on 4/7/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    private var fontSizeObservation: NSKeyValueObservation?
    private var iconNameObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        
    }
    
    private func configureObservers(){
        configureFontSizeObservation()
        configureIconNameObservation()
    }
    
    private func configureFontSizeObservation(){
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            // update UI for font
            guard let newSize = change.newValue else { return }
            let fontSize = CGFloat(newSize)
            self?.welcomeLabel.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    
    private func configureIconNameObservation(){
        iconNameObservation = Settings.shared.observe(\.iconName, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            // update UI for image icon
            guard let iconName = change.newValue else { return }
            self?.iconImageView.image = UIImage(systemName: iconName)
        })
    }
    
    /*
     viewController1
     viewController2
     viewController3
     navigationController
     */
    
    deinit { // gets called when the object is not longer in memory
        fontSizeObservation?.invalidate()
        iconNameObservation?.invalidate()
    }

}
