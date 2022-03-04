import UIKit

final class KeyView: UIView {
    let baseWidth = 34
    var units = 1

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        return label
    }()

    init(units: Int = 1, title: String) {
        self.titleLabel.text = title
        super.init(frame: .zero)
        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {
        backgroundColor = UIColor(named: "KeyBackground")
        layer.cornerRadius = 8
    }

    private func setupViewHierarchy() {
        addSubview(titleLabel)
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: CGFloat(baseWidth * units)),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

