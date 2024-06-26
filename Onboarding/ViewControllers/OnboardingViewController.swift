import UIKit

class OnboardingViewController: UIViewController {

    let stackView = UIStackView()

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let spaceView = UIView()

    init(imageName: String, titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension OnboardingViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0

        spaceView.translatesAutoresizingMaskIntoConstraints = false
        spaceView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        spaceView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }

    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(spaceView)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
