//
//  File.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import Foundation

protocol WebServiceProtocol {
   func fetchList<T: Codable>(for: T.Type, endPoint: EndPoints) async throws -> [T]
}

enum WebServiceError: Error {
   case urlError
   case decodingError
   case otherError
   case badRequest
   case notFound
}

final class SWAPIWebService: WebServiceProtocol {
   private let baseURL = Constants.baseURLString
   
   func fetchList<T: Codable>(for: T.Type, endPoint: EndPoints) async throws -> [T] {
      guard let url = URL(string: "\(baseURL)\(endPoint.path)/") else {
         throw WebServiceError.urlError
      }
      let (data, response) = try await URLSession.shared.data(from: url)
      guard let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 else {
         throw WebServiceError.decodingError
      }
      
      let decoded = try JSONDecoder().decode([T].self, from: data)
      return decoded
   }
}
