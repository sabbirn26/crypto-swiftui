//
//  NetworkingManager.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 15/1/25.
//

import Foundation
import Combine

class NetworkingManager {
    enum NotworkingError : LocalizedError {
        
        case badURLREsponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLREsponse(url: let url):
                return "[🔥] Bad response from the URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap( { try handleURLResponse(output: $0, url: url) } )
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NotworkingError.badURLREsponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
