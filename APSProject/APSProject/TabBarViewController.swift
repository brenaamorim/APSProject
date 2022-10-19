
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    func setupTabBar() {
        
        self.tabBar.tintColor = .actionColor
        self.tabBar.barTintColor = .black
        
        let recommendations = RecommendationsViewController()
        let recommendationsVC = UINavigationController(rootViewController: RecommendationsViewController())
        recommendationsVC.tabBarItem = UITabBarItem(title: "Recomendações", image: UIImage(named: "rolinho"), tag: 0)

        let categoriesVC = UINavigationController(rootViewController: CategoriesViewController())
        categoriesVC.tabBarItem = UITabBarItem(title: "Buscar", image: UIImage(named: "buscar"), tag: 1)

        let myListVC = UINavigationController(rootViewController: MyListViewController())
        myListVC.tabBarItem = UITabBarItem(title: "Minha Lista", image: UIImage(named: "line.horizontal.3"), tag: 2)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Perfil", image: UIImage(systemName: "person.fill"), tag: 3)

        viewControllers = [recommendationsVC, categoriesVC, myListVC, profileVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let navigations = viewControllers else { return }
        let navigation = navigations[item.tag] as? UINavigationController
        navigation?.popToRootViewController(animated: true)
    }


}

