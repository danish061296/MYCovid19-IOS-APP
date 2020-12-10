
import Foundation

// covid api request for all states
struct CovidApiDetailRequest {
    
    func getCovidDetails(completion: @escaping ([StatesCovidDetail]) -> ()) {
        
        let covidUrl = "https://api.covidtracking.com/v1/states/current.json"
        
        guard let url = URL(string: covidUrl) else {
            fatalError()
        }
        let task = URLSession.shared.dataTask(with: url) { (maybeData, maybeResponse, maybeError) in
            guard let jsonData = maybeData else {
                print("DataNotFound")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let covidList = try decoder.decode([StatesCovidDetail].self, from: jsonData)
                completion(covidList)
                print("Data Received")
                
            }
            catch {
                print(error)
                
            }
        }
        
        task.resume()
        
    }
    
}
