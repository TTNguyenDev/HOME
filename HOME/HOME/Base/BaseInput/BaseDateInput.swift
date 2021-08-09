//
//  BaseDateInput.swift
//  HOME
//
//  Created by Trọng Tín on 27/02/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit

class BaseDateInput: UITextField {
    
    let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createDatePicker()
    }
    
    private func createDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button (done)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        // assign toolbar
        inputAccessoryView = toolbar
        
        // assign date picker to the text field
        inputView = datePicker
        
        // date picker mode
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        // take the date
        text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
     
}
