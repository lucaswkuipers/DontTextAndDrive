import UIKit

protocol KeyViewDelegate {
    func didTapKey(with value: String)
}

final class KeyView: UIView {
    var delegate: KeyViewDelegate?
    var units = 1
    var title = ""
    var value = ""
    private let baseWidth = 32

    private let titleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.contentVerticalAlignment = .top
        return button
    }()

    init(units: Int = 1, title: String) {
        self.units = units
        self.title = title
        self.value = title == "space" ? " " : title
        self.titleButton.setTitle(title, for: .normal)
        super.init(frame: .zero)
        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()
        titleButton.addTarget(self, action: #selector(didTapKey), for: .touchDown)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func didTapKey() {
//        log("Value: \(value)")
//        print("Title: \(title)")
        delegate?.didTapKey(with: value)
    }

    private func setupViewStyle() {
        backgroundColor = UIColor(named: "KeyBackground")
        layer.cornerRadius = 8
    }

    private func setupViewHierarchy() {
        addSubview(titleButton)
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: CGFloat(baseWidth * units)),
            titleButton.topAnchor.constraint(equalTo: topAnchor),
            titleButton.leftAnchor.constraint(equalTo: leftAnchor),
            titleButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

