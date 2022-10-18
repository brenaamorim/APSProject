//
//  ProfileViewController.swift
//  APSProject
//
//  Created by Brena Amorim on 17/10/22.
//

import UIKit
import GoogleSignIn
import Firebase

class ProfileViewController: UIViewController {
    
    let buttonLogOut: UIButton = {
        let button = UIButton()
        button.setTitle("Sair", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.setTitleColor(.actionColor, for: .normal)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.isEnabled = true
        button.tintColor = .actionColor
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupLayout()
        buttonLogOut.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
    }

    func setupLayout() {
        view.addSubview(buttonLogOut)
        NSLayoutConstraint.activate([
            buttonLogOut.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogOut.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func didTapLogOutButton() {
        GIDSignIn.sharedInstance().signOut()
        UserDefaults.standard.set(false, forKey: "isLogged")

        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let loginVC = UINavigationController(rootViewController: LoginViewController())
            scene.window?.rootViewController = loginVC
            scene.window?.rootViewController?.dismiss(animated: true)
        }
    }
}
