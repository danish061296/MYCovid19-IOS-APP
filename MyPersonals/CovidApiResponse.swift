import Foundation

// API struct for countries
struct CovidDetail:Decodable {
    let country:String
    var cases:Int
    var deaths:Int
    var recovered:Int
    var active:Int
    
}

// API struct for states of America
struct StatesCovidDetail:Codable {
    var state:String
    var totalTestResults:Int?
    var death:Int?
    var recovered:Int?
    var positive:Int?
    
}


