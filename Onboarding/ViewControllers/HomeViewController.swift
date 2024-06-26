import UIKit

class HomeViewController: UIViewController {

    // Promodoro

    let timerLabel = UILabel()
    let circleView = UIView()

    let containerButton = UIStackView()
    let startButton = UIButton()
    let resetButton = UIButton()

    let startTime = 25 * 60
    var timer: Timer?
    var remainingTime = 25 * 60

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        setup()
        style()
        layout()

        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Setup
extension HomeViewController {
    func setup(){}
    func style(){
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = view.frame.width / 2.35
        circleView.layer.masksToBounds = true
        circleView.layer.borderWidth = 6
        circleView.layer.borderColor = UIColor.main.cgColor

        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.text = "25:00"
        timerLabel.font = UIFont.monospacedSystemFont(ofSize: 60, weight: .bold)
        timerLabel.textColor = UIColor.white


        containerButton.translatesAutoresizingMaskIntoConstraints = false
        containerButton.axis = .horizontal
        containerButton.distribution = .fillEqually
        containerButton.spacing = 20
        containerButton.alignment = .center

        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        startButton.backgroundColor = .main
        startButton.layer.cornerRadius = 10
        startButton.borderWidth = 3
        startButton.borderColor = .main

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        resetButton.backgroundColor = .black
        resetButton.layer.cornerRadius = 10
        resetButton.borderWidth = 3
        resetButton.borderColor = .white
    }
    func layout(){
        view.addSubview(circleView)
        circleView.addSubview(timerLabel)
        view.addSubview(containerButton)

        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            circleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
        ])

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            containerButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 35),
            containerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            containerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            containerButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        containerButton.addArrangedSubview(startButton)
        containerButton.addArrangedSubview(resetButton)

        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalTo: containerButton.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            resetButton.heightAnchor.constraint(equalTo: containerButton.heightAnchor),
        ])

    }
}

// MARK: - Action
extension HomeViewController {
    @objc func startButtonTapped(){
        print("Start")
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            startButton.setTitle("Pause", for: .normal)
        } else {
            timer?.invalidate()
            timer = nil
            startButton.setTitle("Start", for: .normal)
        }
    }

    @objc func resetButtonTapped(){
        print("Reset")
        timer?.invalidate()
        timer = nil
        remainingTime = startTime
        updateTimerLabel()
        startButton.setTitle("Start", for: .normal)
    }

    @objc func updateTimer() {
        print("Update Timer")
        if remainingTime > 0 {
            remainingTime -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            startButton.setTitle("Start", for: .normal)
        }
    }

    func updateTimerLabel() {
        print("Update Timer Label")
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
}
