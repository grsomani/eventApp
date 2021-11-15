//
//  EventViewModel.swift
//  EventsApp
//
//  Created by Ganesh Somani on 15/11/21.
//

import Foundation

struct EventViewModel {

    private var dataModel: Event

    init(dataModel: Event) {
        self.dataModel = dataModel
    }

    var eventTitle: String {
        return self.dataModel.title ?? ""
    }

    var imageURL: URL? {
        guard let urlString = self.dataModel.performers?.first?.image else {
            return nil
        }
        return URL(string: urlString)
    }

    var location: String {
        return (self.dataModel.venue?.city ?? "") + ", " + (self.dataModel.venue?.country ?? "")
    }

    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let dateString = self.dataModel.datetimeUTC,
              let date = dateFormatter.date(from: dateString) else {
                  return ""
              }
        
        dateFormatter.dateFormat = "E, d MMM yyyy h:mm a"
        return dateFormatter.string(from: date)
    }
}
