import UIKit

final class KeyboardView: UIView {
    private let keyRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    // q w e r t y u i o p
    private let topContainerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
        return view
    }()

    private let topColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
//        stackView.backgroundColor = .systemBlue
        return stackView
    }()

    // a s d f g h j k l
    private let midContainerView = UIView()
    private let midColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .systemRed
        return stackView
    }()

    // shift z x c v b n m backspace
    private let bottomContainerView = UIView()
    private let bottomColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.backgroundColor = .systemGreen
        return stackView
    }()

    // numbers spacebar return
    private let footerContainerView = UIView()
    private let footerColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemYellow
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
            topColumnStackView.addArrangedSubview(KeyView(title: key))
        }
//
//        let midKeys = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
//        for key in midKeys {
//            midColumnStackView.addArrangedSubview(KeyView(title: key))
//        }
//
//        let bottomKeys = ["^", "z", "x", "c", "v", "b", "n", "m", "<"]
//        for key in bottomKeys {
//            bottomColumnStackView.addArrangedSubview(KeyView(title: key))
//        }
//
//        let footerKeys = ["1", "space", ">"]
//        for key in footerKeys {
//            footerColumnStackView.addArrangedSubview(KeyView(title: key))
//        }
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
//        subviews.forEach { _ in subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }}
        topContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        midContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        bottomContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        footerContainerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }


        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 250),

            keyRowStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            keyRowStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            keyRowStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            keyRowStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),

            topColumnStackView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            topColumnStackView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            topColumnStackView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
//            topColumnStackView.leftAnchor.constraint(greaterThanOrEqualTo: topContainerView.leftAnchor),
//            topColumnStackView.rightAnchor.constraint(lessThanOrEqualTo: topContainerView.rightAnchor),
//            topColumnStackView.leftAnchor.constraint(equalTo: topContainerView.leftAnchor),
//            topColumnStackView.rightAnchor.constraint(equalTo: topContainerView.rightAnchor),


            midColumnStackView.topAnchor.constraint(equalTo: midContainerView.topAnchor),
            midColumnStackView.bottomAnchor.constraint(equalTo: midContainerView.bottomAnchor),
            midColumnStackView.centerXAnchor.constraint(equalTo: midContainerView.centerXAnchor),
            midColumnStackView.leftAnchor.constraint(greaterThanOrEqualTo: midContainerView.leftAnchor),
            midColumnStackView.rightAnchor.constraint(lessThanOrEqualTo: midContainerView.rightAnchor),

            bottomColumnStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            bottomContainerView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            bottomColumnStackView.leftAnchor.constraint(greaterThanOrEqualTo: bottomContainerView.leftAnchor),
            bottomColumnStackView.rightAnchor.constraint(lessThanOrEqualTo: bottomContainerView.rightAnchor),

            footerColumnStackView.topAnchor.constraint(equalTo: footerContainerView.topAnchor),
            footerColumnStackView.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor),
            footerColumnStackView.centerXAnchor.constraint(equalTo: footerContainerView.centerXAnchor),
            footerColumnStackView.leftAnchor.constraint(greaterThanOrEqualTo: footerContainerView.leftAnchor),
            footerColumnStackView.rightAnchor.constraint(lessThanOrEqualTo: footerContainerView.rightAnchor)
        ])
    }
}
