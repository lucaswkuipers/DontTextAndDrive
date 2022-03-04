import UIKit

protocol KeyViewDelegate {
    func didTapKey(with value: String)
}

final class KeyView: UIButton {
    var delegate: KeyViewDelegate?
    private var title = ""
    private var value = ""
    private var units = 1
    private let baseWidth = 31
    private let pressedColor: UIColor = .systemBlue
    private let fillColor = UIColor(named: "KeyBackground")

    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = false
        return view
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "KeyBackground")
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = false
        return view
    }()

    private let keyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .label
        label.isUserInteractionEnabled = false
        return label
    }()

    init(units: Int = 1, title: String) {
        self.units = units
        self.title = title
        self.value = title == "space" ? " " : title
        self.keyLabel.text = title
        super.init(frame: .zero)
        setupViewHierarchy()
        setupViewConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func didTapKey() {

        if title == "space" {
            SoundManager.shared.play(systemSound: .modifierKeyPress)
        } else {
            SoundManager.shared.play(systemSound: .primaryKeyPress)
        }

        containerView.backgroundColor = pressedColor
        borderView.backgroundColor = .clear
        containerView.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)

        delegate?.didTapKey(with: value)
    }

    @objc func didTouchUp() {
        animateButtonPress()
    }

    private func setupViewHierarchy() {
        addSubview(borderView)
        addSubview(containerView)
        containerView.addSubview(keyLabel)
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        containerView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: CGFloat(baseWidth * units)),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 3),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -3),

            borderView.topAnchor.constraint(equalTo: containerView.topAnchor),
            borderView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            borderView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 2),
            borderView.rightAnchor.constraint(equalTo: containerView.rightAnchor),

            keyLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5),
            keyLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupActions() {
        addTarget(self, action: #selector(didTapKey), for: .touchDown)
        addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(didTouchUp), for: .touchUpOutside)
    }

    private func animateButtonPress() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: { [weak self] in
                self?.containerView.backgroundColor = self?.pressedColor
                self?.borderView.backgroundColor = .clear
                self?.containerView.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            }, completion: {_ in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5,
                    options: .curveEaseIn,
                    animations: { [weak self] in
                        self?.containerView.backgroundColor = self?.fillColor
                        self?.borderView.backgroundColor = .black
                        self?.containerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                )
            }
        )
    }
}
