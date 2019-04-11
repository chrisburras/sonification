//
//  SettingsViewController.swift
//  sonification
//
//  Created by Amit Enand on 4/4/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var colors = ["Red","Orange","Green","Blue", "Purple"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self


        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    @IBOutlet weak var pickerView: UIPickerView!
    @IBAction func homeButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
