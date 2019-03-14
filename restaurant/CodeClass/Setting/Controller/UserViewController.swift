//
//  UserViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import RMUniversalAlert

class UserViewController: UIViewController,
ProfileSettingHeaderViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var userTableView: UITableView!
    fileprivate var headerView: ProfileSettingHeaderView!
    var pickerNavigationBarView: NavigationBarView?
    var tmpUser: User = User()

    fileprivate var sections = [Section]()

    fileprivate enum ProfileSettingTableViewSectionType: Int {
        case profileSetting
    }
    
    fileprivate enum ProfileSettingTableViewRowType {
        case profileSettingNickName
        case profileSettingGender
        case profileSettingBio
        case profileSettingSaveButton
    }
    
    fileprivate struct Section {
        var sectionType: ProfileSettingTableViewSectionType
        var rowItems: [ProfileSettingTableViewRowType]
    }
    
    func initializeTableViewStruct() {
        sections = [Section(sectionType: .profileSetting, rowItems: [.profileSettingNickName, .profileSettingGender, .profileSettingBio, .profileSettingSaveButton])]
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        title = "プロフィール設定"
        initializeTableViewStruct()
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.backgroundColor = kBackGroundColor
        headerView = ProfileSettingHeaderView.init(delegate: self)
        headerView?.user = tmpUser
        userTableView.tableHeaderView = headerView
        let nickNameCell = UINib(nibName: LabelTextFieldCell.nibName, bundle: nil)
        userTableView.register(nickNameCell, forCellReuseIdentifier: LabelTextFieldCell.reuseID)
        let genderCell = UINib(nibName: LabelPickerCell.nibName, bundle: nil)
        userTableView.register(genderCell, forCellReuseIdentifier: LabelPickerCell.reuseID)
        let commentCell = UINib(nibName: CommentCell.nibName, bundle: nil)
        userTableView.register(commentCell, forCellReuseIdentifier: CommentCell.reuseID)
        let buttonCell = UINib(nibName: ButtonCell.nibName, bundle: nil)
        userTableView.register(buttonCell, forCellReuseIdentifier: ButtonCell.reuseID)
    }
    
// ================================================================================
// MARK: - headerView delegate
    
    func headerViewIconButtonTapped(_ view: ProfileSettingHeaderView) {
        showPhotoActionSheet()
    }
    
    func showPhotoActionSheet() {
        _ =  RMUniversalAlert.showActionSheet(in: self,
                                              withTitle: nil,
                                              message: nil,
                                              cancelButtonTitle:"キャンセル",
                                              destructiveButtonTitle: nil,
                                              otherButtonTitles: ["写真を撮影","アルバムから選択"],
                                              popoverPresentationControllerBlock: { [weak self] (popover) in
                                                popover.sourceView = self?.view
                                                popover.sourceRect = self!.view.frame
        }) { [weak self] (alert, buttonIndex) in
            DBLog(buttonIndex)
            
            if buttonIndex != alert.cancelButtonIndex {
                self?.showImagePicker(buttonIndex != alert.firstOtherButtonIndex)
            }
        }
    }
    
    func showImagePicker(_ isAlubum: Bool) {
        let picker: BaseImagePickerController = BaseImagePickerController()
        if isAlubum {
            pickerNavigationBarView = NavigationBarView()
            picker.view.addSubview(pickerNavigationBarView!)
            picker.view.bringSubviewToFront(picker.navigationBar)
        }
        picker.view.backgroundColor = UIColor.white
        picker.navigationBar.barTintColor = UIColor.orange
        picker.sourceType = isAlubum ? .photoLibrary : .camera
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
// ================================================================================
// MARK: - image picker delegate
     open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img: UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        tmpUser.photo = Photo(image: img)
        headerView?.user = tmpUser
        picker.dismiss(animated: true, completion: nil)
    }
}
// ================================================================================
// MARK: - UITableViewDataSource
    
extension UserViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return  sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowItems.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section].rowItems[indexPath.row] {
        case .profileSettingNickName:
            return 50
        case .profileSettingBio:
            return 85
        case .profileSettingSaveButton:
            return 50
        default:
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].rowItems[indexPath.row] {
        case .profileSettingNickName:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelTextFieldCell.reuseID, for: indexPath) as! LabelTextFieldCell
            cell.titleLabel.text = "ニックネーム"
            return cell
        case .profileSettingGender:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelPickerCell.reuseID, for: indexPath) as! LabelPickerCell
            cell.titleLabel.text = "性別"
            return cell
        case .profileSettingBio:
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseID, for: indexPath) as! CommentCell
            cell.textField.placeholder = "何かコメントがある場合はどうぞ"
            return cell
        case .profileSettingSaveButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseID, for: indexPath) as! ButtonCell
            cell.button.setTitle("変更する", for: .normal)
            return cell
        }
        
    }
}
    
// ================================================================================
// MARK: - UITableViewDelegate
    
extension UserViewController: UITableViewDelegate {}
