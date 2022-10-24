
import UIKit

class NewCollectionView: UICollectionView, UICollectionViewDelegate {
    let repository = FilmRepository(with: "paraAssistir")
    var moviesAPI = [Film]()
//    weak var delegatePush: DelegatePushDescriptionViewController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        getNewMovies()
        
        self.dataSource = self
        self.delegate = self
        
        self.decelerationRate = .fast // uncomment if necessary
        self.contentInsetAdjustmentBehavior = .always
        self.register(NewsPosterCell.self, forCellWithReuseIdentifier: "NewsCell")
        self.isPagingEnabled = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getNewMovies() {
        Service.shared.nowPlaying() { films in
            films?.forEach({ film in
                if film.overview != "" {
                    self.moviesAPI.append(film)
                }
            })
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    func saveInPlist(dataFilm: Film?) {
        guard let dataFilm = dataFilm else { return }
        repository.create(object: dataFilm)
    }
}

extension NewCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesAPI.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = moviesAPI[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsPosterCell
        cell.film = movie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        saveInPlist(dataFilm: moviesAPI[indexPath.item])
//        delegatePush?.didSelect(movie: moviesAPI[indexPath.item])
    }
}
