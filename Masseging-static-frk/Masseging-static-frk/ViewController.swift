//
//  ViewController.swift
//  Masseging-static-frk
//
//  Created by discussolutions on 9/13/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate
{

    
    @IBOutlet var toolView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var tblMessage: UITableView!
    
    
    var textfieldBottomAnchor: NSLayoutConstraint?
    
    var arrr:NSMutableArray = ["Wellcom to Odin Messanger","11111111222132132132132132131322132132","Wellcom to Odin Messanger11111111222132132132132132131322132132"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        toolView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        toolView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        toolView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textfieldBottomAnchor = toolView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        textfieldBottomAnchor?.isActive = true
        
        //self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        setUpKeyBoardObservers()

    }
    func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        return arrr.count
     }
   
    @IBAction func btnSend(_ sender: Any)
    {
        dismissKeyboard()
        
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BubbleTableViewCell
        cell.lblMassage.text = arrr[indexPath.row] as? String
        cell.lblMassage.numberOfLines = 0
        cell.lblMassage.lineBreakMode = NSLineBreakMode.byTruncatingTail
        cell.lblMassage.preferredMaxLayoutWidth = 190
        
       // cell.lblMassage.sizeToFit()
        
        
        return cell
     }
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BubbleTableViewCell
       
        return cell.lblMassage.frame.height + 40
    }
    
    //4 Use NSnotificationCenter to monitor the keyboard updates
    func setUpKeyBoardObservers()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //5 toggle the bottom layout global variable based on the keyboard's height
    func handleKeyboardWillShow(notification: NSNotification) {
        
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        if let keyboardFrame = keyboardFrame {
            textfieldBottomAnchor?.constant = -keyboardFrame.height
        }
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        if let keyboardDuration = keyboardDuration {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func handleKeyboardWillHide(notification: NSNotification) {
        arrr.add(textField.text)
        textField.text = ""
        tblMessage.reloadData()
        textfieldBottomAnchor?.constant = 5
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        if let keyboardDuration = keyboardDuration {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    //6 remove the observers
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    /*
    override func viewDidAppear(_ animated: Bool) {
        let lastItem = IndexPath(item: arrr.count, section: 0)
        tblMessage.scrollToRow(at: lastItem, at: .top, animated: true)
    }*/
    func textFieldShouldBeginEditing(_textField: UITextField) -> Bool {
        let txtFieldPosition = textField.convert(textField.bounds.origin, to: tblMessage)
        let indexPath = tblMessage.indexPathForRow(at: txtFieldPosition)
        if indexPath != nil {
            tblMessage.scrollToRow(at: indexPath!, at: .top, animated: true)
        }
        return true
    }
   
    

}
//extension UIViewController {
//    func hideKeyboardOnTap(_ selector: Selector) {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//}
