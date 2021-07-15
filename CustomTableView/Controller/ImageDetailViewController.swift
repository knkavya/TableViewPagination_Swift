//
//  ImageDetailViewController.swift
//  CustomTableView
//
//  Created by Kavya KN on 15/07/21.
//

import UIKit

protocol DeleteData {
    func deleteSelectedDataInTableView(index: IndexPath)
}

class ImageDetailViewController: UIViewController {
    
    var imageUrl : String = ""
    var selectedAlbumIndex : IndexPath = IndexPath()
    
    var delegate : DeleteData?
    
    @IBOutlet weak var detailedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBarButtonItem()
        self.setBackButton()
        self.detailedImageView.load(urlString: imageUrl)
    }
    
    func createCustomBarButtonItem(){
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "delete"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.deleteButtonPressed), for: UIControl.Event.touchUpInside)
        button.tintColor = .red
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func deleteButtonPressed() {
        delegate?.deleteSelectedDataInTableView(index: selectedAlbumIndex)
        self.navigationController?.popViewController(animated: true)
    }
}
