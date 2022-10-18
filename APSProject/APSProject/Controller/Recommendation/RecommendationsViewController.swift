
import UIKit

class RecommendationsViewController: UIViewController {
    let indicationCollection = RecoCollectionView(frame: .zero, collectionViewLayout: ZoomAndSnapFlowLayout())
    let newsCollection = NewCollectionView(frame: .zero, collectionViewLayout: HorizontalFlowLayout())

    lazy var NewName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.text = "Lançamentos"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.viewControllers.first?.navigationItem.title = "Recomendações"
        navigationController?.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath.circle.fill"), style: .done, target: self, action: #selector(teste))
        
        navigationController?.navigationBar.tintColor = .actionColor
        
        // Change large title color from rootViewController 
        self.navigationController?.viewControllers.first?.navigationController?.navigationBar.largeTitleTextAttributes = [                 NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle  = .black
  
//        indicationCollection.delegatePush = self
        indicationCollection.translatesAutoresizingMaskIntoConstraints = false
        indicationCollection.backgroundColor = .black
        view.addSubview(indicationCollection)
        
//        newsCollection.delegatePush = self
        newsCollection.backgroundColor = .black
        newsCollection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsCollection)
        

        view.addSubview(NewName)
        
        configureAutoLayout()
    }
    
    @objc func teste() {
        print("teste")
    }

    func configureAutoLayout() {
        // Indication collection.
        NSLayoutConstraint.activate([
            indicationCollection.topAnchor.constraint(equalTo: view.topAnchor),
            indicationCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicationCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicationCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 6/10)
        ])
        
        // Label new name.
        NSLayoutConstraint.activate([
            NewName.topAnchor.constraint(equalTo: indicationCollection.bottomAnchor, constant: 8),
            NewName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            NewName.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //News collection
        NSLayoutConstraint.activate([
            newsCollection.topAnchor.constraint(equalTo: NewName.bottomAnchor, constant: -40),
            newsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// Custom delegate to push the description screen.
//extension RecommendationsViewController: DelegatePushDescriptionViewController {
//    func didSelect(movie: Film) {
//        let destination = DescriptionViewController()
//        destination.dataFilm = movie
//        navigationController?.pushViewController(destination, animated: true)
//    }
//}

