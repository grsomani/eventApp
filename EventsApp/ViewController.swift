//
//  ViewController.swift
//  EventsApp
//
//  Created by Ganesh Somani on 14/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let req = EventSearch()
        
        NetworkManager.instance.performOperation(request: req,
                                                 reponseType: SearchEventResponse.self) { response in
            print(response)
        } onError: { error in
            print(error)
        }

    }
}

class EventSearch: RequestData {
    var path: String {
        return "https://api.seatgeek.com/2/events?client_id=MjQ0NDM3MTh8MTYzNjg2ODkyMS45NzczMjA0&q=Texas+Ranger"
    }
}
