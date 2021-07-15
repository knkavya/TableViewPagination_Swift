//
//  Extensions.swift
//  CustomTableView
//
//  Created by Kavya KN on 15/07/21.
//

import Foundation
import UIKit

// MARK: Loading image using image URL.
extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIViewController {
    
    // MARK: Show loader on View controller.
    func showLoader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait..", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        self.parent?.present(alert, animated: true, completion: nil)
        return alert
    }
    
    // MARK: Show loader on View controller.
    func hideLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Set custom back button.
    func setBackButton(){
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(back(sender:)))
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }
}

// MARK: Capitalize first letter in sentance.
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
