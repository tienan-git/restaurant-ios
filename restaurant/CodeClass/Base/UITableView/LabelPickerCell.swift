//
//  LabelPickerCell.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import SwiftTips

class LabelPickerCell: UITableViewCell, NibProtocol, UIPickerViewDelegate,
UIPickerViewDataSource {
    typealias NibT = LabelPickerCell
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFieldPicker: UITextField!
    
    var pickerView: UIPickerView? = UIPickerView()
    let pickerContents = ["男性","女性","その他"]
    
    var keyboardToolbar: UIToolbar? = UIToolbar()
    var spaceBarItem: UIBarButtonItem? = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        keyboardToolbar = UIToolbar()
        keyboardToolbar?.sizeToFit()
        let doneButton = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(doneButtonTapped));
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        doneButton.tintColor = UIColor.white
        doneButton.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        keyboardToolbar?.items = ([spaceBarItem!, doneButton])
        keyboardToolbar!.frame = CGRect(x: 0, y: 0, width: kCommonDeviceWidth, height: 38.0)
        keyboardToolbar!.barStyle = .blackTranslucent
        pickerView?.frame = CGRect(x: 0, y: 0, width: kCommonDeviceWidth, height: kCommonDeviceWidth / 2)
        pickerView?.y = kCommonDeviceHeight - pickerView!.height
        pickerView?.delegate = self
        pickerView?.dataSource = self
        textFieldPicker.inputAccessoryView = keyboardToolbar
        textFieldPicker.inputView = pickerView
        self.selectionStyle = .none
    }
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.endEditing(true)
    }
    
    
// ================================================================================
// MARK: - picker delegate, dataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerContents.count
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerContents[row]
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldPicker.text = self.pickerContents[row]
        //TODO
    }
}
