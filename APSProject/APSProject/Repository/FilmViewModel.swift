
import Foundation

class FilmViewModel {
    
    var films: [Film]?
    
    var repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        films = self.repository.readAll()
    }
    
}
