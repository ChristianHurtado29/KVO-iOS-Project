//
//  SettingsViewController.swift
//  KVO-iOS-Project
//
//  Created by Christian Hurtado on 4/7/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

struct Icon {
    var name: String
    var color: UIColor
}


import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var fontSizeObservation: NSKeyValueObservation?
    
    // data for the picker view
    private let iconNames = ["sun.haze.fill","moon", "globe", "icloud"] // SF image name e.g "moon"

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureFontSizeObservation()
    }
    
    private func configurePickerView(){
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func configureFontSizeObservation(){
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            guard let newSize = change.newValue else { return }
            self?.fontSizeLabel.text = newSize.description
        })
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let newSize = Int(sender.value) // Float to Int as our settings fontsize is an Int
        Settings.shared.fontSize = newSize
    }
    

}

extension SettingsViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of columns
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iconNames.count
    }
}

extension SettingsViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return iconNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let iconName = iconNames[row]
        Settings.shared.iconName = iconName
        // after setting the iconName on the Settings class the WelcomeViewController will be updated via KVO observation
    }
    
}
