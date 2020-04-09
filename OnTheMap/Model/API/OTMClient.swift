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
        static var objectId: String = ""
    }
    
    enum Endpoint {
        static let baseURL = "https://onthemap-api.udacity.com/v1"
        
        case login
        case getStudentLocation
        case createNewlocation
        case updateLocation(String)
        case deleteSession
        case signupOnWeb
        
        var stringValue: String {
            switch self {
            case .login: return Endpoint.baseURL + "/session"
            case .getStudentLocation: return Endpoint.baseURL + "/StudentLocation?order=-updatedAt"
            case .createNewlocation: return Endpoint.baseURL + "/StudentLocation"
            case .updateLocation(let objectId): return Endpoint.baseURL + "/StudentLocation/\(objectId)"
            case .deleteSession: return Endpoint.baseURL + "/session"
            case .signupOnWeb: return "https://auth.udacity.com/sign-in"
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
                do {
                    let errorObject = try decoder.decode(OTMResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil,errorObject)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForPOSTPUTRequest<ResponseType: Decodable,RequestType: Encodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?,Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = ResponseType.self == updateResponse.self ? "PUT" : "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
                        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                do {
                    let errorObject = try decoder.decode(OTMResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil,errorObject)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func createNewStudentLocation(mapString: String, mediaURL: String, latitude: Double, longtitude: Double, completion: @escaping (Bool,Error?) -> Void) {
        let body = StudentLocationRequest(uniqueKey: Auth.accontKey, firstName: K.MyName.firstName, lastName: K.MyName.lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longtitude)
        
        taskForPOSTPUTRequest(url: Endpoint.createNewlocation.url, responseType: CreateNewLocationResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.objectId = response.objectId
                completion(true,nil)
            } else {
                completion(false,error)
            }
        }
    }
    
    class func updateStudentLocation(mapString: String, mediaURL: String, latitude: Double, longtitude: Double, completion: @escaping (Bool,Error?) -> Void) {
        let body = StudentLocationRequest(uniqueKey: Auth.accontKey, firstName: K.MyName.firstName, lastName: K.MyName.lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longtitude)
        
        taskForPOSTPUTRequest(url: Endpoint.updateLocation(Auth.objectId).url, responseType: updateResponse.self, body: body) { (response, error) in
            if response != nil {
                completion(true, error)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func logout() {
        var request = URLRequest(url: Endpoint.deleteSession.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            Auth.accontKey = ""
            Auth.objectId = ""
            Auth.session = ""
        }
        task.resume()
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool,Error?) -> Void) {
        var request = URLRequest(url: Endpoint.login.url)
        let body = LoginRequest(username: username, password: password)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(["udacity":body])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            
            let newData = data.subdata(in: 5..<data.count)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(LoginResponse.self, from: newData)
                Auth.accontKey = responseObject.account.key
                Auth.session = responseObject.session.id
                DispatchQueue.main.async {
                    completion(true,nil)
                }
            } catch {
                do {
                    let errorObject = try decoder.decode(OTMResponse.self, from: newData)
                    DispatchQueue.main.async {
                        completion(false,errorObject)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false,error)
                    }
                }
            }
        }
        task.resume()
        
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
