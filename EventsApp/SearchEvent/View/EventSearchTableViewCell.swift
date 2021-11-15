//
//  EventSearchTableViewCell.swift
//  EventsApp
//
//  Created by Ganesh Somani on 15/11/21.
//

import UIKit

class EventSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    var viewModel: EventViewModel?

    func configure(_ data: EventViewModel) {
        self.viewModel = data
        setupUI()
    }

    private func setupUI() {
        if let imageURL = self.viewModel?.imageURL {
            NetworkManager.instance.downloadImage(from: imageURL) { image in
                self.eventImage.image = image
            }
        } else {
            self.eventImage.image = nil
        }
        self.titleLbl.text = self.viewModel?.eventTitle
        self.locationLbl.text = self.viewModel?.location
        self.dateLbl.text = self.viewModel?.date
    }

}
