import Foundation
import Alamofire


class NetworkHandler : NetworkHandlerProtocol {
   
   private let baseUrl = "https://apiv2.allsportsapi.com/"
   private let apiKey = "&APIkey=60ac2c656dd3ef121cfc7abfef05b8289ad04d9950682c14b119339eeadabe5d"
   
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
