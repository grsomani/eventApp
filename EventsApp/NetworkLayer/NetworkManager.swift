//
//  NetworkManager.swift
//  EventsApp
//
//  Created by Ganesh Somani on 14/11/21.
//

import Foundation
import UIKit

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

        self.getData(from: urlRequest) { (data, _, taskError) in
            DispatchQueue.main.async {
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
            }
        }
    }

    public func cancelTask(with path: String) {
        URLSession.shared.getAllTasks { tasks in
            let oldTasks = tasks.filter { $0.originalRequest?.url?.absoluteString.hasPrefix(path) ?? false }
            oldTasks.forEach { $0.cancel() }
        }
    }

    public func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let urlRequest = URLRequest(url: url)
        getData(from: urlRequest) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                if response?.url?.absoluteString == url.absoluteString {
                    completion(UIImage(data: data))
                } else {
                    completion(nil)
                }
            }
        }
    }

    private func getData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}
