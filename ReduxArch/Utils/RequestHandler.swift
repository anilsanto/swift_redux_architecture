//
//  RequestHandler.swift
//
//  Created by Anil Santo on 29/10/18.
//

import Foundation
import Security

enum RequestMethod : String{
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

class RequestHandler: NSObject ,URLSessionDelegate{
    
    let configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        return config
    }()
    
    var session : URLSession!
    var trustedCertificatesPath : [String]?
    class var shared: RequestHandler {
        struct Static {
            static let instance : RequestHandler = RequestHandler()
        }
        return Static.instance
    }
    
    override init(){
        super.init()
        configuration.timeoutIntervalForRequest = TimeInterval(300)
        configuration.timeoutIntervalForResource = TimeInterval(300)
        session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
    }
    
    init(withTimeout timeout: TimeInterval,sslPinningEnable enabled: Bool = false){
        super.init()
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout
        if enabled{
            session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        }
        else{
            session = URLSession(configuration: configuration, delegate: nil, delegateQueue:OperationQueue.main)
        }
    }
    
    func httpCancelRequest(){
        session.getTasksWithCompletionHandler { (tasks : [URLSessionDataTask], _: [URLSessionUploadTask], _: [URLSessionDownloadTask]) in
            for task in tasks{
                task.cancel()
            }
        }
    }
    
    func request<T: Decodable,E: Decodable>(forUrl urlString : String,method : RequestMethod,needEncoding : Bool = false,withHeader header : Dictionary<String,String>?,withBody body : Data? = nil,completionHandler: @escaping (T?,E?,Int?) ->()){
        var encodedString = ""
        if needEncoding {
            guard let percentageEncoded = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{ return}
            encodedString = percentageEncoded.trimWhiteSpace
        }
        else{
            encodedString = urlString.trimWhiteSpace
        }
        consoleLogger(string: "URL----------------------------")
        consoleLogger(string: encodedString)
        guard let url = URL(string: encodedString) else{ return }
        var requestObj = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: configuration.timeoutIntervalForRequest)
        requestObj.httpMethod = method.rawValue
        if let headerField = header{
            let allKeys = headerField.keys
            for key in allKeys{
                requestObj.addValue(headerField[key] ?? "", forHTTPHeaderField: key)
            }
            consoleLogger(string: "Header----------------------------")
            consoleLogger(string: headerField.jsonString() ?? "")
        }
        if body != nil{
            requestObj.httpBody = body
            consoleLogger(string: "Body----------------------------")
            consoleLogger(string: requestObj.httpBody?.toString() ?? "")
        }
        invokeRequest(requestObj: requestObj, completionHandler: completionHandler)
    }
    
    func invokeRequest<T: Decodable,E: Decodable>(requestObj: URLRequest,completionHandler: @escaping (T?,E?,Int?) ->()){
        guard let urlSession = session else{
            completionHandler(nil,nil,nil)
            return
        }
        
        urlSession.dataTask(with: requestObj) { ( data, response, err) in
            guard err == nil else {
                completionHandler(nil,nil,nil)
                return
            }
            guard let dataObj = data else {
                completionHandler(nil,nil,nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(nil,nil,nil)
                return
            }
            consoleLogger(string: "Response----------------------------")
            consoleLogger(string: data?.toString() ?? "")
            if (200..<300).contains(httpResponse.statusCode) {
                do{
                    let obj = try JSONDecoder().decode(T.self, from: dataObj)
                    completionHandler(obj,nil,httpResponse.statusCode)
                }
                catch let error{
                    consoleLogger(string: "Error----------------------------")
                    consoleLogger(string: error.localizedDescription)
                    do{
                        let obj = try JSONDecoder().decode(E.self, from: dataObj)
                        completionHandler(nil,obj,httpResponse.statusCode)
                    }
                    catch let error{
                        consoleLogger(string: "Error----------------------------")
                        consoleLogger(string: error.localizedDescription)
                        completionHandler(nil,nil,httpResponse.statusCode)
                    }
                }
            }
            else{
                do{
                    let obj = try JSONDecoder().decode(T.self, from: dataObj)
                    completionHandler(obj,nil,httpResponse.statusCode)
                }
               catch let error{
                    consoleLogger(string: "Error----------------------------")
                    consoleLogger(string: error.localizedDescription)
                    do{
                        let obj = try JSONDecoder().decode(E.self, from: dataObj)
                        completionHandler(nil,obj,httpResponse.statusCode)
                    }
                    catch let error{
                        consoleLogger(string: "Error----------------------------")
                        consoleLogger(string: error.localizedDescription)
                        completionHandler(nil,nil,httpResponse.statusCode)
                    }
                }
            }
        }.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else{return}
        guard let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else{return}
        
        // Set SSL policies for domain name check
        let policies = NSMutableArray();
        policies.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString)))
        SecTrustSetPolicies(serverTrust, policies);
        
        // Evaluate server certificate
        guard var result: SecTrustResultType = SecTrustResultType(rawValue: 0) else{
            return
        }
        SecTrustEvaluate(serverTrust, &result)
        let isServerTrusted : Bool = (result == .unspecified || result == .proceed)
        let credential:URLCredential = URLCredential(trust: serverTrust)
        
        
        let remoteCertificateData:NSData = SecCertificateCopyData(certificate)
        guard let paths = trustedCertificatesPath else{
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        paths.forEach { (path) in
            guard let localCertificate: NSData = NSData(contentsOfFile: path) else{
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
            }
            if (isServerTrusted && remoteCertificateData.isEqual(to: localCertificate as Data)) {
                completionHandler(.useCredential, credential)
                return
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        completionHandler(nil)
    }
}
