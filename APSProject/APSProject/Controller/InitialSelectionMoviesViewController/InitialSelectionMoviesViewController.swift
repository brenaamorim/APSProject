
import UIKit
import GoogleSignIn
import Firebase

class InitialSelectionMoviesViewController: UIViewController {
    private var randomMovies = [Film]()
    private var moviesSelectedIds: [Int] = []
    private var page: Int = 1
    
    let lbltitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Selecione 3 filmes que você gosta"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonContinue: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.setTitleColor(.actionColor, for: .normal)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.isEnabled = false
        button.tintColor = .actionColor
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: 105, height: 151)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.indicatorStyle = .white
        collectionView.tintColor = .actionColor
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .actionColor
        spinner.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 44)
        spinner.startAnimating()
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        navigationController?.isNavigationBarHidden = true
        buttonContinue.addTarget(self, action: #selector(didContinueButton), for: .touchUpInside)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(TitlesCollectionCell.self, forCellWithReuseIdentifier: "TitlesCell")
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startLoading()
        getRandomMovies(page: 1)
    }

    func setupLayout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(buttonContinue)
        stackView.addArrangedSubview(lbltitle)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lbltitle.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setConstraints(for view: UIView?) {
        view?.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        view?.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }

    func startLoading() {
        collectionView.backgroundView = activityIndicator
        setConstraints(for: activityIndicator)
    }
    
    func stopLoading() {
        collectionView.backgroundView = nil
    }

    @objc func didContinueButton() {
        print(moviesSelectedIds)
        print("continue")
    }

//    @objc func didTapLogOutButton() {
//        GIDSignIn.sharedInstance().signOut()
//        UserDefaults.standard.set(false, forKey: "isLogged")
//        navigationController?.popViewController(animated: true)
//    }
}

extension InitialSelectionMoviesViewController {
    func getRandomMovies(page: Int) {
        stopLoading()
        Service.shared.getRandomMovies(page: page) { films in
            guard let films = films else {
                return
            }
            films.forEach({ film in
                if film.poster_path != nil && !self.randomMovies.contains(film) {
                    self.randomMovies.append(film)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
            
        }
    }
}

extension InitialSelectionMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if moviesSelectedIds.count < 3 {
            moviesSelectedIds.append(randomMovies[indexPath.row].id)
        }
        
        if moviesSelectedIds.count == 3 {
            buttonContinue.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let index = moviesSelectedIds.firstIndex(of: randomMovies[indexPath.row].id) {
            moviesSelectedIds.remove(at: index)
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.indexPathsForSelectedItems!.count <=  2
    }
}

extension InitialSelectionMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitlesCell", for: indexPath) as! TitlesCollectionCell
        
        let urlPoster = "https://image.tmdb.org/t/p/w500" + randomMovies[indexPath.row].poster_path!
        cell.imageTitle.downloaded(from: urlPoster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = randomMovies.count - 1
        if indexPath.row == lastElement {
            startLoading()
            page = page + 1
            getRandomMovies(page: page)
        }
    }
}
