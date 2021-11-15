//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Ganesh Somani on 16/11/21.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    var eventViewModel: EventViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTitle()
        self.locationLbl.text = eventViewModel?.location
        self.dateLbl.text = eventViewModel?.date

        if let imageURL = self.eventViewModel?.imageURL {
            NetworkManager.instance.downloadImage(from: imageURL) { image in
                self.eventImage.image = image
            }
        }
    }

    private func setupTitle() {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = eventViewModel?.eventTitle
        self.navigationItem.titleView = label
    }

}
