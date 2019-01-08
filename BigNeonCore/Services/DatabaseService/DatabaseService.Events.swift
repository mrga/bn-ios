
import Foundation

extension DatabaseService {
    
    public func fetchEvents(completion: @escaping (Error?, Events?) -> Void) {
        
        let APIURL = APIService.getEvents
        let request = NSMutableURLRequest(url: NSURL(string: APIURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = APIParameterKeys.GET
        request.setValue(APIParameterKeys.requestSetValue, forHTTPHeaderField: APIParameterKeys.headerField)
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error Fetching Data: \(error)")
                completion(nil, nil)
                return
            }
            
            guard let data = data else {
                print("Error Fetching Data")
                completion(nil, nil)
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let events = try decoder.decode(Events.self, from: data)
                completion(nil, events)
                return
            } catch {
                completion(nil, nil)
            }
            
            }.resume()
    }

}