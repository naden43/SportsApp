import Foundation
import Alamofire
     
     
class NetworkHandler : NetworkHandlerProtocol {
            
       private let baseUrl = "https://apiv2.allsportsapi.com/"
       private let apiKey = "&APIkey=abc02ea64120a2a2b030bed665f226a1d66f109fa9f94eae9a6c66c8ca00d785"
       
       static let instance = NetworkHandler()
       
       private init(){}
       
      func loadData<T: Decodable>(url: String, onCompletion: @escaping (T?, Error?) -> Void) {
        let endPoint = baseUrl + url + apiKey
        print("Requesting data from: \(endPoint)")
        
        AF.request(endPoint).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                print("Data received: \(value)")
                onCompletion(value, nil)
            case .failure(let error):
                print("Error: \(error)")
                onCompletion(nil, error)
            }
        }
    }

}
