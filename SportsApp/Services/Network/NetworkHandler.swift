import Foundation
import Alamofire


class NetworkHandler : NetworkHandlerProtocol {
   
   private let baseUrl = "https://apiv2.allsportsapi.com/"
   private let apiKey = "&APIkey=abc02ea64120a2a2b030bed665f226a1d66f109fa9f94eae9a6c66c8ca00d785"
   
   static let instance = NetworkHandler()
   
   private init(){}
   
   func loadData<T: Decodable>(onCompletion: @escaping (T) -> Void , url: String) {
       let endPoint = baseUrl + url + apiKey
       AF.request(endPoint).responseDecodable(of: T.self) { response in
           switch response.result {
           case .success(let value):
               onCompletion(value)
           case .failure(let error):
               onCompletion(error as! T)
           }
       }
   }
}
