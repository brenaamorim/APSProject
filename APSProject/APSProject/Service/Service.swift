
import Foundation
import UIKit

class Service {
    static let shared = Service()
    
    private init() { }
    
    func getRandomMovies(page: Int, completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .discover(page: page))
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
//    func findFilmByGenre(with genresId: [String], completion: @escaping ([Film]?) -> Void) {}
    
    func getTrailer(filmId: String, mediaType: String, completion: @escaping ([Trailer]?) -> Void) {
        
        let api = FilmsAPI(route: .trailer(id: filmId, mediaType:  mediaType))
        
        guard let url = api.url else { return }
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(TrailerResult.self, from: data)
                let trailers = results.results
                completion(trailers)
            } catch {
                print(error)
            }
        }
    }
    
    func getRecomendations(filmId: String, completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .recommendations(id: filmId))
        
        guard let url = api.url else { return }
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
    func getTrendings(completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .latest)
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
    func nowPlaying(completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .nowPlaying)
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
                
            }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
    func searchByName(name: String, completion: @escaping ([Film]?) -> Void) {
        
        let api = FilmsAPI(route: .searchByName(name: name))
        
        guard let url = api.url else { return }
        
        
        HTTP.get.request(url: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(FilmResult.self, from: data)
                let films = results.results
                completion(films)
            } catch {
                print(error)
            }
            
        }
    }
    
//    func getStreamings(tmdb_id: String, completion: @escaping ([Streaming]?) -> Void) {}
}


