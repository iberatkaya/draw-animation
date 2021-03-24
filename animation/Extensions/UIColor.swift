import UIKit

//Taken from https://stackoverflow.com/a/43365841/11701504
//Author: https://stackoverflow.com/users/5555803/orkhan-alikhanov
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
