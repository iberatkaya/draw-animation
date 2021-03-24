import UIKit

//Taken from https://stackoverflow.com/a/48592991/11701504.
//Author: https://stackoverflow.com/users/1066828/fahim-parkar
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
