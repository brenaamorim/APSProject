//
//  ViewController.swift
//  APSProject
//
//  Created by Brena Amorim on 02/10/22.
//

import UIKit
import AuthenticationServices
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CineTimeIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let signInAppleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .continue, style: .white)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signInGoogleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonNoAuth: UIButton = {
        let button = UIButton()
        button.setTitle("Iniciar sem sessão", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(.actionColor, for: .normal)
        button.tintColor = .actionColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIconImageLayout()
        loginWithApple()
        loginWithGoogle()
        
        buttonNoAuth.addTarget(self, action: #selector(didTapSignWithoutAuth), for: .touchUpInside)
    }

    func loginWithApple() {
        setupLoginWithAppleButton()
    }
    
    func loginWithGoogle() {
        setupLoginWithGoogleButton()
        GIDSignIn.sharedInstance().presentingViewController = self
        
        if GIDSignIn.sharedInstance().currentUser != nil {
            //direcionar pra próxima tela
            let destination = InitialSelectionMoviesViewController()
            navigationController?.pushViewController(destination, animated: true)
        } else if !GIDSignIn.sharedInstance().presentingViewController.isViewLoaded {
            GIDSignIn.sharedInstance().signIn()
        }
    }

    func setupLoginWithAppleButton() {
        view.addSubview(signInAppleButton)
        NSLayoutConstraint.activate([
            signInAppleButton.topAnchor.constraint(equalTo: iconImage.bottom, constant: 48),
            signInAppleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInAppleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signInAppleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            signInAppleButton.heightAnchor.constraint(equalToConstant: 38),
            signInAppleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        signInAppleButton.addTarget(self, action: #selector(didTapSignInAppleButton), for: .touchUpInside)
    }

    func setupLoginWithGoogleButton() {
        view.addSubview(signInGoogleButton)
        view.addSubview(buttonNoAuth)
        
        NSLayoutConstraint.activate([
            signInGoogleButton.topAnchor.constraint(equalTo: signInAppleButton.bottom, constant: 24),
            signInGoogleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signInGoogleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            signInGoogleButton.heightAnchor.constraint(equalToConstant: 50),
            signInGoogleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            buttonNoAuth.topAnchor.constraint(equalTo: signInGoogleButton.bottom, constant: 8),
            buttonNoAuth.centerXAnchor.constraint(equalTo: signInGoogleButton.centerXAnchor)
        ])
        
    }

    func setupIconImageLayout() {
        view.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 150),
            iconImage.widthAnchor.constraint(equalToConstant: 150),
        ])
    }

    @objc func didTapSignInAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @objc func didTapSignWithoutAuth() {
        let destination = InitialSelectionMoviesViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization With Apple Fail")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let email = credentials.email
            print(email as Any)
            break
        default:
            break
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
