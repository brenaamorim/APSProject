
protocol Repository {
    
    func readAll() -> [Film]
    func read(id: Int) -> Film?
    func create(object: Film)
    func update(object: Film)
    func delete(object: Film)
    
}
