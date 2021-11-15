//
//  NetworkManager.swift
//  EventsApp
//
//  Created by Ganesh Somani on 14/11/21.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case parsingFailure
    case forwarded(Error)
}

public struct NetworkManager {
    public static let instance = NetworkManager()
    private init() {}

    public func performOperation<T: Decodable>(request: RequestData,
                                               reponseType: T.Type,
                                               onSuccess: @escaping (T) -> Void,
                                               onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(NetworkError.invalidURL)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, _, taskError) in
            if let taskError = taskError {
                onError(taskError)
                return
            }

            guard let apiData = data else {
                onError(NetworkError.noData)
                return
            }
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(reponseType.self, from: apiData)
                onSuccess(parsedData)
            } catch {
                debugPrint(error)
                onError(NetworkError.parsingFailure)
            }
        }.resume()
    }

    public func cancelTask(with path: String) {
        URLSession.shared.getAllTasks { tasks in
            let oldTasks = tasks.filter { $0.originalRequest?.url?.absoluteString.hasPrefix(path) ?? false }
            oldTasks.forEach { $0.cancel() }
        }
    }
}
