import UIKit

final class KeyboardView: UIView {
    private let keyRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()

    // q w e r t y u i o p
    private let topContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private let topColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()

    // a s d f g h j k l
    private let midContainerView = UIView()
    private let midColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()

    // shift z x c v b n m backspace
    private let bottomContainerView = UIView()
    private let bottomColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()

    // numbers spacebar return
    private let footerContainerView = UIView()
    private let footerColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillProportionally
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {
    }

    private func setupViewHierarchy() {
        addSubview(keyRowStackView)
        keyRowStackView.addArrangedSubview(topContainerView)
        keyRowStackView.addArrangedSubview(midContainerView)
        keyRowStackView.addArrangedSubview(bottomContainerView)
        keyRowStackView.addArrangedSubview(footerContainerView)
        topContainerView.addSubview(topColumnStackView)
        midContainerView.addSubview(midColumnStackView)
        bottomContainerView.addSubview(bottomColumnStackView)
        footerContainerView.addSubview(footerColumnStackView)

        let topKeys = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
        for key in topKeys {
            let keyView = KeyView(title: key)
            keyView.delegate = self
            topColumnStackView.addArrangedSubview(keyView)
        }

        let midKeys = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
        for key in midKeys {
            let keyView = KeyView(title: key)
            keyView.delegate = self
            midColumnStackView.addArrangedSubview(keyView)
        }

        let bottomKeys = ["z", "x", "c", "v", "b", "n", "m"]
        for key in bottomKeys {
            let keyView = KeyView(title: key)
            keyView.delegate = self
            bottomColumnStackView.addArrangedSubview(keyView)
        }

        let footerKey = "space"
        let footerKeyView = KeyView(units: 6, title: footerKey)
        footerKeyView.delegate = self
        footerColumnStackView.addArrangedSubview(footerKeyView)
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        topContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        midContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        bottomContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        footerContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }


        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 220),

            keyRowStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            keyRowStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            keyRowStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            keyRowStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),

            topColumnStackView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            topColumnStackView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            topColumnStackView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),

            midColumnStackView.topAnchor.constraint(equalTo: midContainerView.topAnchor),
            midColumnStackView.bottomAnchor.constraint(equalTo: midContainerView.bottomAnchor),
            midColumnStackView.centerXAnchor.constraint(equalTo: midContainerView.centerXAnchor),

            bottomColumnStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            bottomColumnStackView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            bottomColumnStackView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),

            footerColumnStackView.topAnchor.constraint(equalTo: footerContainerView.topAnchor),
            footerColumnStackView.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor),
            footerColumnStackView.centerXAnchor.constraint(equalTo: footerContainerView.centerXAnchor),
            footerColumnStackView.leftAnchor.constraint(greaterThanOrEqualTo: footerContainerView.leftAnchor),
            footerColumnStackView.rightAnchor.constraint(lessThanOrEqualTo: footerContainerView.rightAnchor)
        ])
    }
}

extension KeyboardView: KeyViewDelegate {
    func didTapKey(with value: String) {
        print("Tapped value: \(value)")
    }
}
