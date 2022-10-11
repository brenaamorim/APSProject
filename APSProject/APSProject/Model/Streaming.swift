
import Foundation

struct StreamingResults: Decodable {
    let collection: UtellyMovie
//    let id: String?
}

struct UtellyMovie: Decodable {
    let id: String?
    let picture: String
    let name: String
    let locations: [Streaming]
    let provider: String
}

struct Streaming: Codable {
    var id: String? = nil
    let name: String
    var icon: String? = nil
    var display_name: String? = nil
    var url: String? = nil
    var selected: Bool? = false
}
