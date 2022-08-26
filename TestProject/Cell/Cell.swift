//
//  Cell.swift
//  TestProject
//
//  Created by Dmitriy Eni on 24.08.2022.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(profile: Profile) {
        nameLabel.text = profile.name
        idLabel.text = "№ \(profile.id)"
        
        if let imageUrl = profile.image {
            profileImage.setImageFromURL(imageUrl)
        }
        profileImage.image = UIImage(systemName: "camera.metering.unknown")!
        profileImage.tintColor = UIColor.lightGray
    }
    
    override func prepareForReuse() {
        profileImage.image = nil
    }
}
