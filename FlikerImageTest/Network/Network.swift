//
//  Network.swift
// FlikerImageTest
//
//  Created by Reshmi Divi on 26/09/24.
//

import Foundation
enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
class WebService {
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            do{
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            }catch{
                print(error.localizedDescription)
            }
        }
        catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        }
        catch {
            print(error.localizedDescription)
            print("An error occured downloading the data")
        }
        
        return nil
    }
}
