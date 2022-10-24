
import Foundation

class FilmRepository: Repository {
    
    var plist: PlistManager<Film>
    
    init(with plistName: String) {
        plist = PlistManager<Film>(plistName: plistName)
    }
    
    func readAll() -> [Film] {
        
        // Getting films in plist
        if let films = plist.readPlist() {
            return films
        }
        
        return [Film]()
    }
    
    func read(id: Int) -> Film? {
        // Getting one film in plist
        if let films = plist.readPlist() {
            let film = films.filter{ $0.id == id }.first
            return film
        }
        
        return nil
        
    }
    
    
    func create(object: Film) {
        
        // Saving in plist
        let films = readAll()
        if !films.contains(object) {
            plist.addInPlist(object: object)
        }
    }
    
    func update(object: Film) {
        
        // update plist
        delete(object: object)
        create(object: object)
        
    }
    
    func delete(object: Film) {
        
        // deleting from plist
        if var plist = plist.readPlist() {
            plist = plist.filter { $0.id != object.id }
            self.plist.savePlist(object: plist)
        }
        
    }
    
}

