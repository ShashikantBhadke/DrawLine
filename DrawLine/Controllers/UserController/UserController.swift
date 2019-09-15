//
//  UserController.swift
//  DrawLine
//
//  Created by Shashikant Bhadke on 14/09/19.
//  Copyright © 2019 Shashikant Bhadke. All rights reserved.
//

import UIKit

class UserController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var btnUser1: UIButton!
    @IBOutlet private weak var btnUser2: UIButton!
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        btnUser1.layer.cornerRadius = 5
        btnUser2.layer.cornerRadius = 5
        
        btnUser1.layer.borderWidth = 1
        btnUser2.layer.borderWidth = 1
        
        btnUser1.layer.borderColor = (btnUser1.titleLabel?.textColor ?? UIColor.blue).cgColor
        btnUser2.layer.borderColor = (btnUser2.titleLabel?.textColor ?? UIColor.blue).cgColor
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Select You as- "
    }
    
    // MARK:- Button Actions
    @IBAction private func btnSelectUserPressed(_ sender: UIButton) {
        self.title = ""
        switch sender {
        case btnUser1:
            Constant.strUserID = UserName.user1.rawValue
        case btnUser2:
            Constant.strUserID = UserName.user2.rawValue
        default:
            break
        }
        if !Constant.strUserID.isEmpty {
            pushViewController()
        }
    }
    
    // MARK:- Custom Methods
    private func pushViewController() {
        performSegue(withIdentifier: "UserController", sender: self)
    }
    
    // MARK:- Receive Memory Warning
    override func didReceiveMemoryWarning() {
        debugPrint("\(self) receive memory warning.")
    }
    
    // MARK:- deinit
    deinit {
        debugPrint("\(self) is removed.")
    }
} //class
