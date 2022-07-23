

import Foundation


struct Places: Codable {
    var logo: String
    var city_id: Int
    var lang: Int
    var photo: String
    var creation_date: String
    var visible: Bool
    var text: String
}

struct NamePlaces: Codable {
    var point_key_name: String
    var city: City
    
    struct City: Codable {
        var id: Int
    }
    
}
