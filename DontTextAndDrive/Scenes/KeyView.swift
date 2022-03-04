//import UIKit
//
//protocol KeyViewDelegate {
//    func didTapKey(with value: String)
//}
//
//final class KeyView: UIView {
//    let color: UIColor = .systemBlue
//    var delegate: KeyViewDelegate?
//    var units = 1
//    var title = ""
//    var value = ""
//    private let baseWidth = 34
//
//    private let titleButton: UIButton = {
//        let button = UIButton()
//        button.titleLabel?.font = .systemFont(ofSize: 24)
//        button.contentVerticalAlignment = .top
//        button.setTitleColor(.label, for: .normal)
//        return button
//    }()
//
//    init(units: Int = 1, title: String) {
//        self.units = units
//        self.title = title
//        self.value = title == "space" ? " " : title
//        self.titleButton.setTitle(title, for: .normal)
//        super.init(frame: .zero)
//        setupViewStyle()
//        setupViewHierarchy()
//        setupViewConstraints()
//        titleButton.addTarget(self, action: #selector(didTapKey), for: .touchDown)
//        titleButton.addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
//        titleButton.addTarget(self, action: #selector(didTouchUp), for: .touchUpOutside)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    @objc func didTapKey() {
//        SoundManager.shared.playKeySound()
//        backgroundColor = color
//        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//        //        log("Value: \(value)")
//        //        print("Title: \(title)")
//        delegate?.didTapKey(with: value)
//    }
//
//    @objc func didTouchUp() {
//        UIView.animate(
//            withDuration: 0.1,
//            delay: 0,
//            usingSpringWithDamping: 0.5,
//            initialSpringVelocity: 0.5,
//            options: .curveEaseIn,
//            animations: { [weak self] in
//                self?.backgroundColor = self?.color
//                self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//            }, completion: {_ in
//                UIView.animate(
//                    withDuration: 0.1,
//                    delay: 0,
//                    usingSpringWithDamping: 0.5,
//                    initialSpringVelocity: 0.5,
//                    options: .curveEaseIn,
//                    animations: { [weak self] in
//                        self?.backgroundColor = UIColor(named: "KeyBackground")
//                        self?.transform = CGAffineTransform(scaleX: 1, y: 1)
//                    }
//                )
//            }
//        )
//    }
//
//    private func setupViewStyle() {
//        backgroundColor = UIColor(named: "KeyBackground")
//        layer.cornerRadius = 8
//    }
//
//    private func setupViewHierarchy() {
//        addSubview(titleButton)
//    }
//
//    private func setupViewConstraints() {
//        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
//
//        NSLayoutConstraint.activate([
//            widthAnchor.constraint(equalToConstant: CGFloat(baseWidth * units)),
//            titleButton.topAnchor.constraint(equalTo: topAnchor),
//            titleButton.leftAnchor.constraint(equalTo: leftAnchor),
//            titleButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            titleButton.rightAnchor.constraint(equalTo: rightAnchor)
//        ])
//    }
//}

import UIKit

protocol KeyViewDelegate {
    func didTapKey(with value: String)
}

final class KeyView: UIButton {
    var delegate: KeyViewDelegate?
    private var title = ""
    private var value = ""
    private var units = 1
    private let baseWidth = 32
    private let pressedColor: UIColor = .systemBlue
    private let fillColor = UIColor(named: "KeyBackground")

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
        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func didTapKey() {

        if title == "space" {
            SoundManager.shared.playModifierKeySound()
        } else {
            SoundManager.shared.playPrimaryKeySound()
        }

        containerView.backgroundColor = pressedColor
        containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        delegate?.didTapKey(with: value)
    }

    @objc func didTouchUp() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: { [weak self] in
                self?.containerView.backgroundColor = self?.pressedColor
                self?.containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: {_ in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5,
                    options: .curveEaseIn,
                    animations: { [weak self] in
                        self?.containerView.backgroundColor = self?.fillColor
                        self?.containerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                )
            }
        )
    }

    private func setupViewStyle() {
//        backgroundColor = .
    }

    private func setupViewHierarchy() {
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

            keyLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5),
            keyLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupActions() {
        addTarget(self, action: #selector(didTapKey), for: .touchDown)
        addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(didTouchUp), for: .touchUpOutside)
    }
}
