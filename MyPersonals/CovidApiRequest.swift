import Foundation

// enum for errors
enum CovidError: Error {
    case noDataFound
    case cannotProcessRequest
}


struct CovidApiRequest {
    let requestUrl: URL
    
    init(countryName:String){
        
        
        
        
        let requestString = "https://coronavirus-19-api.herokuapp.com/countries/\(countryName)"
        print("Getting the country name \(countryName)")
        guard let url = URL(string: requestString) else {
            fatalError()
        }
        self.requestUrl = url
    }
    
    // making a request
    // Source: Brian Advent tutorial for error enumeration
    func getCountryNameFromUrl(completion: @escaping(Result<CovidDetail , CovidError>) -> Void){
        
        let task = URLSession.shared.dataTask(with: requestUrl) {maybeData, maybeResponse, maybeError in
            guard let data = maybeData else {
                completion(.failure(.noDataFound))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(CovidDetail.self, from: data)
                
                completion(.success(decoded))
                
            }
            catch {
                print(error)
                completion(.failure(.cannotProcessRequest))
            }
        }
        
        task.resume()
    }
    
}
