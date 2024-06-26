//
//  LoginViewController.swift
//  Onboarding
//
//  Created by Nguyen Quang Minh on 26/6/24.
//

import UIKit

class LoginViewController : UIViewController {

    let backgroundImageView = UIImageView()
    let logoImageView = UIImageView()
    let loginLabel = UILabel()
    let emailTextField = PaddedTextField()
    let emailErrorLabel = UILabel()
    let passwordTextField = PaddedTextField()
    let passwordErrorLabel = UILabel()
    let forgotPasswordLabel = UILabel()
    let loginButton = UIButton()
    let containerOr = UIStackView()
    let lineLeadingView = UIImageView()
    let lineTrailingView = UIImageView()
    let orLabel = UILabel()
    let containerSocialButton = UIStackView()
    let googleButton = UIImageView()
    let facebookButton = UIImageView()
    let appleButton = UIImageView()

    let paddingView = CGFloat(20)

    let regaxEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let regaxUsername = "^[a-zA-Z0-9_-]{3,16}$"
    let regaxPhoneNumber = "^\\d{10}$"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setup()
        style()
        layout()
        addGestureRecognizers()
    }
}

// MARK - Setup
extension LoginViewController {
    func setup(){
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(onLoginButtonClick), for: .touchUpInside)
    }
    func style(){
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(loginLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailErrorLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordErrorLabel)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(loginButton)
        view.addSubview(containerOr)
        view.addSubview(loginButton)
        view.addSubview(containerSocialButton)

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "bottom-login")
        backgroundImageView.contentMode = .scaleAspectFill

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo-normal")
        logoImageView.contentMode = .scaleAspectFit

        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Login Details"
        loginLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        loginLabel.textAlignment = .left
        loginLabel.numberOfLines = 0
        loginLabel.textColor = .black
        loginLabel.lineBreakMode = .byWordWrapping

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.textColor = .black
        emailTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emailTextField.textAlignment = .left
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next

        emailTextField.layer.cornerRadius = 5.0
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.borderTextField.cgColor
        emailTextField.layer.masksToBounds = true

        let emailPlaceholderText = "Username, email & phone number"
        let emailPlaceholderColor = UIColor.coooo
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: emailPlaceholderText,
            attributes: [NSAttributedString.Key.foregroundColor: emailPlaceholderColor]
        )

        emailErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        emailErrorLabel.textColor = .red
        emailErrorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        emailErrorLabel.numberOfLines = 0
        emailErrorLabel.text = ""
        emailErrorLabel.textAlignment = .left

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        passwordTextField.textAlignment = .left
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor.borderTextField.cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.returnKeyType = .done

        passwordTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.borderTextField.cgColor
        passwordTextField.layer.masksToBounds = true

        let passwordPlaceholderText = "Password"
        let passwordPlaceholderColor = UIColor.coooo
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: passwordPlaceholderText,
            attributes: [NSAttributedString.Key.foregroundColor: passwordPlaceholderColor]
        )

        passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordErrorLabel.textColor = .red
        passwordErrorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        passwordErrorLabel.numberOfLines = 0
        passwordErrorLabel.text = ""
        passwordErrorLabel.textAlignment = .left

        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordLabel.text = "Forgot Password?"
        forgotPasswordLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        forgotPasswordLabel.textAlignment = .right
        forgotPasswordLabel.textColor = .content

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        loginButton.backgroundColor = .buttonDisable
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.isEnabled = false

        containerOr.translatesAutoresizingMaskIntoConstraints = false
        containerOr.axis = .horizontal
        containerOr.alignment = .fill
        containerOr.distribution = .fill
        containerOr.spacing = 10

        lineLeadingView.translatesAutoresizingMaskIntoConstraints = false
        lineLeadingView.image = UIImage(named: "line-leading")
        lineLeadingView.contentMode = .scaleAspectFit

        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.text = "Or sign up with"
        orLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        orLabel.textAlignment = .center
        orLabel.textColor = .content

        lineTrailingView.translatesAutoresizingMaskIntoConstraints = false
        lineTrailingView.image = UIImage(named: "line-trailing")
        lineTrailingView.contentMode = .scaleAspectFit

        containerSocialButton.translatesAutoresizingMaskIntoConstraints = false
        containerSocialButton.axis = .horizontal
        containerSocialButton.alignment = .center
        containerSocialButton.distribution = .fillEqually
        containerSocialButton.spacing = 1

        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.image = UIImage(named: "google")
        googleButton.contentMode = .scaleAspectFit

        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.image = UIImage(named: "facebook")
        facebookButton.contentMode = .scaleAspectFit

        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.image = UIImage(named: "apple")
        appleButton.contentMode = .scaleAspectFit


    }
    func layout(){
        NSLayoutConstraint.activate([
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: backgroundImageView.image?.size.height ?? 0),
            backgroundImageView.widthAnchor.constraint(equalToConstant: backgroundImageView.image?.size.width ?? 0),
        ])

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: logoImageView.image?.size.width ?? 0),
            logoImageView.heightAnchor.constraint(equalToConstant: logoImageView.image?.size.height ?? 0),
        ])

        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingView),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingView),
        ])

        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingView),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingView),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
        ])

        NSLayoutConstraint.activate([
            emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            emailErrorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingView),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingView),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        ])

        NSLayoutConstraint.activate([
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 10),
            forgotPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingView),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingView),
        ])

        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingView),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingView),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        NSLayoutConstraint.activate([
            containerOr.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            containerOr.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerOr.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerOr.heightAnchor.constraint(equalToConstant: 50),
        ])

        containerOr.addArrangedSubview(lineLeadingView)
        containerOr.addArrangedSubview(orLabel)
        containerOr.addArrangedSubview(lineTrailingView)

        NSLayoutConstraint.activate([
            containerSocialButton.topAnchor.constraint(equalTo: containerOr.bottomAnchor, constant: 20),
            containerSocialButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            containerSocialButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            containerSocialButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        containerSocialButton.addArrangedSubview(googleButton)
        containerSocialButton.addArrangedSubview(facebookButton)
        containerSocialButton.addArrangedSubview(appleButton)
    }

    func addGestureRecognizers() {
        // Add tap gesture to forgot password label
        let forgotPasswordTap = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(forgotPasswordTap)

        // Add tap gesture to social buttons
        let googleTap = UITapGestureRecognizer(target: self, action: #selector(googleButtonTapped))
        googleButton.isUserInteractionEnabled = true
        googleButton.addGestureRecognizer(googleTap)

        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(facebookButtonTapped))
        facebookButton.isUserInteractionEnabled = true
        facebookButton.addGestureRecognizer(facebookTap)

        let appleTap = UITapGestureRecognizer(target: self, action: #selector(appleButtonTapped))
        appleButton.isUserInteractionEnabled = true
        appleButton.addGestureRecognizer(appleTap)
    }
}

// MARK - Actions

extension LoginViewController {

    @objc func textFieldDidChange(_ textField: UITextField) {
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        let isEmailValid = !emailText.isEmpty
        let isPasswordValid = !passwordText.isEmpty
        loginButton.isEnabled = isEmailValid && isPasswordValid

        loginButton.backgroundColor = loginButton.isEnabled ? .buttonNormal : .buttonDisable
    }

    @objc func onLoginButtonClick() {
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""

        var isEmailValid = true
        var isPasswordValid = true

        // Kiểm tra email
        if !isValidInput(emailText, regex: regaxEmail) {
            isEmailValid = false
            emailErrorLabel.text = "Invalid email format"
            emailTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            emailErrorLabel.text = ""
            emailTextField.layer.borderColor = UIColor.borderTextField.cgColor
        }

        // Kiểm tra password
        if passwordText.isEmpty {
            isPasswordValid = false
            passwordErrorLabel.text = "Password cannot be left blank."
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        } else if passwordText.count < 6{
            isPasswordValid = false
            passwordErrorLabel.text = "Password must have at least 6 characters."
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            passwordErrorLabel.text = ""
            passwordTextField.layer.borderColor = UIColor.borderTextField.cgColor
        }

        if isEmailValid && isPasswordValid {
            // Alert login success
            let alert = UIAlertController(title: "Login Success", message: "Welcome back!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                _ in
                let homeViewController = HomeViewController()
                let navigationController = UINavigationController(rootViewController: homeViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: {
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            })

        }
    }



    @objc func forgotPasswordTapped() {
        print("Forgot Password tapped")
        // Handle forgot password action
    }

    @objc func googleButtonTapped() {
        print("Google Button tapped")
        // Handle Google login action
    }

    @objc func facebookButtonTapped() {
        print("Facebook Button tapped")
        // Handle Facebook login action
    }

    @objc func appleButtonTapped() {
        print("Apple Button tapped")
        // Handle Apple login action
    }

    func isValidInput(_ input: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }
}
