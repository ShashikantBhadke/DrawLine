//
//  ViewController.swift
//  DrawLine
//
//  Created by Shashikant Bhadke on 14/09/19.
//  Copyright © 2019 Shashikant Bhadke. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet internal weak var viewBoard       : CanvasView!
    @IBOutlet private weak var btnMenu          : UIButton!
    @IBOutlet private weak var btnClear         : UIButton!
    @IBOutlet private weak var btnUndoLast      : UIButton!
    
    // MARK:- Variables
    var alertController: UIAlertController!
    
    // MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        confirmObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        viewBoard.backgroundColor = UIColor.white
    }
    
    // MARK:- Button Action
    @IBAction func btnMenuPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            
            self.btnClear.alpha = self.btnClear.isHidden ? 1 : 0
            self.btnUndoLast.alpha = self.btnUndoLast.isHidden ? 1 : 0
            
            self.btnClear.isHidden.toggle()
            self.btnUndoLast.isHidden.toggle()
            sender.setImage(self.btnClear.isHidden ? #imageLiteral(resourceName: "plusIcon") : #imageLiteral(resourceName: "minusIcon"), for: .normal)
        }
    }
    
    @IBAction func btnClearPressed(_ sender: UIButton) {
        showAlert()
        viewBoard.clearAll()
    }
    
    @IBAction func btnUndoLastPressed(_ sender: UIButton) {
        showAlert()
        viewBoard.undoLast()
    }
    
    // MARK:- Custom Methods
    func showAlert() {
        if alertController == nil {
            alertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        }
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alertController.view.addSubview(loadingIndicator)
        present(alertController!, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK:- DB Methods
    func confirmObservers() {
        DataBase.addListners(.Point, self)
    }
    
    func removeObservers() {
        DataBase.removeObervers()
    }
    // MARK:- Receive Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        debugPrint("Receive Memory Warning in \(String(describing: self))")
    }
    
    // MARK:- Deinit
    deinit {
        debugPrint("\(String(describing: self)) controller removed...")
    }
} //class

