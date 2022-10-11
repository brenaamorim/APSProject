
import UIKit
import GoogleSignIn
import Firebase

class InitialSelectionMoviesViewController: UIViewController {
    var data = [UIColor.white]
    
    let lbltitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.text = "Selecione 3 filmes que você gosta"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonLogOut: UIButton = {
        let button = UIButton()
        button.setTitle("Sair", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.actionColor, for: .normal)
        button.tintColor = .actionColor
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        navigationController?.isNavigationBarHidden = true
        buttonLogOut.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(TitlesCollectionCell.self, forCellWithReuseIdentifier: "TitlesCell")
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .black
    }

    func setupLayout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(lbltitle)
        stackView.addArrangedSubview(buttonLogOut)
        
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

    @objc func didTapLogOutButton() {
        GIDSignIn.sharedInstance().signOut()
        UserDefaults.standard.set(false, forKey: "isLogged")
        navigationController?.popViewController(animated: true)
    }
}

extension InitialSelectionMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitlesCell", for: indexPath) as! TitlesCollectionCell
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = CGColor(red: 1.00, green: 0.86, blue: 0.38, alpha: 1.00)
    }
}

extension InitialSelectionMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitlesCell", for: indexPath) as! TitlesCollectionCell
        
        let urlPoster = "https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"
        cell.imageTitle.downloaded(from: urlPoster)
        return cell
    }
}
