import UIKit

protocol KeyViewDelegate {
    func didTapKey(with value: String)
}

final class KeyView: UIView {
    let color: UIColor = .tintColor
    var delegate: KeyViewDelegate?
    var units = 1
    var title = ""
    var value = ""
    private let baseWidth = 32

    private let titleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.contentVerticalAlignment = .top
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 8
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
        titleButton.addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
        titleButton.addTarget(self, action: #selector(didTouchUp), for: .touchUpOutside)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func didTapKey() {
        titleButton.backgroundColor = color
        transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        //        log("Value: \(value)")
        //        print("Title: \(title)")
        delegate?.didTapKey(with: value)
    }

    @objc func didTouchUp() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: { [weak self] in
                self?.titleButton.backgroundColor = self?.color
                self?.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            }, completion: {_ in
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5,
                    options: .curveEaseIn,
                    animations: { [weak self] in
                        self?.titleButton.backgroundColor = .clear
                        self?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                )
            }
        )
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

