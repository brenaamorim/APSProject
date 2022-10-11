
import Foundation

struct TrailerResult: Codable {
    let id: Int
    let results: [Trailer]?
}

struct Trailer: Codable {
    let id: String
    let iso_639_1: String
    let iso_3166_1: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}
