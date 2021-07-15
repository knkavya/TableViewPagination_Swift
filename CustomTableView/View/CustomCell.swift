//
//  CustomCell.swift
//  CustomTableView
//
//  Created by Kavya KN on 15/07/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var backgroundContentView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
