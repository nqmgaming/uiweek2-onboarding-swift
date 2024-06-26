import UIKit

class ViewController: UIPageViewController {

    var pages = [UIViewController]()

    // external controls
    let skipButton = UIButton()
    let nextButton = UIButton()
    let continueButton = UIButton()
    let pageControl = UIPageControl()
    let initialPage = 0

    // animations
    var skipButtonLeadingAnchor: NSLayoutConstraint?
    var nextButtonTrailingAnchor: NSLayoutConstraint?
    var continueButtonBottomAnchor: NSLayoutConstraint?

    override init(transitionStyle: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: transitionStyle, navigationOrientation: navigationOrientation, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("hello")
        setup()
        style()
        layout()
    }
}

extension ViewController {
    func setup() {
        dataSource = self
        delegate = self

        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        let page1 = OnboardingViewController(imageName: "first", titleText: "Track your work and get the result", subtitleText: "Remember to keep track of your professional accomplishments.")
        let page2 = OnboardingViewController(imageName: "second", titleText: "Stay organized with team", subtitleText: "But understanding the contributions our colleagues make to our teams and companies")
        let page3 = OnboardingViewController(imageName: "third", titleText: "Get notified when work happens", subtitleText: "Take control of notifications, collaborate live or on your own time")

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }

    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage

        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.backgroundColor = .white
        skipButton.setTitleColor(.black, for: .normal)
        skipButton.setTitle("SKIP", for: .normal)
        skipButton.titleLabel?.textAlignment = .center
        skipButton.cornerRadius = 25
        skipButton.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.titleLabel?.textAlignment = .center
        nextButton.cornerRadius = 25
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.isHidden = true
        continueButton.backgroundColor = .black
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.setTitle("START", for: .normal)
        continueButton.titleLabel?.textAlignment = .center
        continueButton.cornerRadius = 25
        continueButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)

    }

    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),

            skipButton.widthAnchor.constraint(equalToConstant: 100),
            skipButton.heightAnchor.constraint(equalToConstant: 50),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),

            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),

            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 0),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)

        ])

        // For animation
        skipButtonLeadingAnchor = skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        nextButtonTrailingAnchor = nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        continueButtonBottomAnchor = continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)

        skipButtonLeadingAnchor?.isActive = true
        nextButtonTrailingAnchor?.isActive = true
        continueButtonBottomAnchor?.isActive = true
    }
}

// Datasource
extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
}

// Delegate
extension ViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }

        pageControl.currentPage = currentIndex

        animateControlsIfNeeded()
    }

    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1

        if lastPage {
            hideControls()
        } else {
            showControls()
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func hideControls() {
        skipButtonLeadingAnchor?.constant = -150
        nextButtonTrailingAnchor?.constant = 150
        continueButton.isHidden = false
    }

    private func showControls() {
        skipButtonLeadingAnchor?.constant = 16
        nextButtonTrailingAnchor?.constant = -16
        continueButton.isHidden = true
    }
}

// Actions
extension ViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }

    @objc func skipButtonTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex

        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        animateControlsIfNeeded()
    }

    @objc func nextButtonTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }

    @objc func startButtonTapped(_ sender: UIButton) {
        // navigate to the next screen

        let homeViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

// Extensions
extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?.first else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }

    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?.first else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

        setViewControllers([prevPage], direction: .reverse, animated: animated, completion: completion)
    }

    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
