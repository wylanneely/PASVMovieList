//
//  NetworkController.swift
//  MovieList
//
//  Created by Wylan L Neely on 1/13/25.
//

import Foundation
import UIKit

class NetworkController {
    
    
    
    //Declare Method Keys
    
    enum HTTPMethod: String {
        
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
        
    }
    
    
    // function for requesting data from the internet or posting of any of the methods above
    
   
    static func performRequest(for url: URL,
                               httpMethod: HTTPMethod,
                               urlParameters: [String: String]? = nil,
                               headers: [String: String]? = nil,
                               body: Data? = nil,
                               completion: ((Data?, Error?) -> Void)? = nil) {
        
        
        
        //get the url that the request will perform on, add parameters later
        let requestURL = self.url(byAdding: urlParameters, to: url)
        
        //create a request that acts upon the given URL using the function below
        var request = URLRequest(url: requestURL)
        //// set the raw values from the enum HTTPMethod declared above
        request.httpMethod = httpMethod.rawValue
        //pass in data to the request, generally json data
        request.httpBody = body
        
        request.timeoutInterval = 10 //default is 60 seconds
        
        //add the headers to the request
        request.allHTTPHeaderFields = headers
        
        // create a data task using the request
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion?(data, error)
        }
        
        dataTask.resume()
        
    }
    
    static func url(byAdding parameters: [String: String]?, to url: URL) -> URL {
        
        
        // gab url to pass to URLComponents
        var componets = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // convert the parameters to URLQueryItems.
        componets?.queryItems = parameters?.compactMap{ URLQueryItem(name: $0.key, value: $0.value) }
        
        //Unwrap URL based off of components
        guard let url = componets?.url else { fatalError("URL Optional is nil") }
        
        
        return url
        
    }
    
    static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
           let task = URLSession.shared.dataTask(with: url) { data, _, error in
               if let error = error {
                   print("Error downloading image: \(error.localizedDescription)")
                   completion(nil)
                   return
               }

               guard let data = data, let image = UIImage(data: data) else {
                   print("Failed to decode image data")
                   completion(nil)
                   return
               }

               completion(image)
           }
           task.resume()
       }
    
}
