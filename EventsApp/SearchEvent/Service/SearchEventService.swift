//
//  SearchEventService.swift
//  EventsApp
//
//  Created by Ganesh Somani on 15/11/21.
//

import Foundation

class EventSearch: RequestData {

    var searchText: String = ""

    var path: String {
        var completeUrl = "https://api.seatgeek.com/2/events?client_id=MjQ0NDM3MTh8MTYzNjg2ODkyMS45NzczMjA0&q="
        completeUrl.append(searchText)
        let urlString = completeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlString ?? ""
    }
}

class SearchEventService {

    private let searchRequest = EventSearch()

    func getSeachResults(for text: String, completion: @escaping (SearchEventResponse?, NetworkError?) -> Void) {
        searchRequest.searchText = text
        let basePath = searchRequest.path.components(separatedBy: "?")[0]
        NetworkManager.instance.cancelTask(with: basePath)
        NetworkManager.instance.performOperation(request: searchRequest,
                                                 reponseType: SearchEventResponse.self) { response in
            debugPrint(response)
            completion(response, nil)
        } onError: { error in
            completion(nil, .forwarded(error))
        }
    }
}
