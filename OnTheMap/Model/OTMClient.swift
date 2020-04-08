//
//  OTMClient.swift
//  OnTheMap
//
//  Created by Kittikawin Sontinarakul on 7/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation

class OTMClient {
    
    struct Auth {
        static var accontKey: String = ""
        static var session: String = ""
    }
    
    enum Endpoint {
        static let baseURL = "https://onthemap-api.udacity.com/v1"
        
        case login
        case getStudentLocation
        
        var stringValue: String {
            switch self {
            case .login: return Endpoint.baseURL + "/session"
            case .getStudentLocation: return Endpoint.baseURL + "/StudentLocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func taskForPOSTRequest<ResponseType: Decodable,RequestType: Encodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?,Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["udacity":body])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let newData = data.subdata(in: 5..<data.count)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        }
        task.resume()
    }
    
    class func createNewStudentLocation() {

    }
    
    class func login(username: String, password: String, completion: @escaping (Bool,Error?) -> Void) {
        let body = LoginRequest(username: username, password: password)

        taskForPOSTRequest(url: Endpoint.login.url, responseType: LoginResponse.self, body: body) { (response, error) in
            if let responseObject = response {
                if responseObject.account.registered {
                    print(responseObject.account.key)
                    print(responseObject.session.id)
                    Auth.accontKey = responseObject.account.key
                    Auth.session = responseObject.session.id
                        completion(true,nil)
                }
            } else {
                completion(false,error)
            }
        }
    }
    
    class func getStudentLocation(completion: @escaping (Bool,Error?) -> Void) {
        taskForGETRequest(url: Endpoint.getStudentLocation.url, responseType: StudentLocation.self) { (response, error) in
            if let response = response {
                StudentModel.student = response.results
                completion(true,nil)
            } else {
                completion(false,error)
            }
        }
    }
}
