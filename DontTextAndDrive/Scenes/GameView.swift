import UIKit
import SceneKit

final class GameView: UIView {
    var sceneView: GameSceneViewProtocol? {
        didSet {
            setupViewHierarchy()
            setupViewConstraints()
        }
    }

    private let keyboardView = KeyboardView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .opaqueSeparator
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewHierarchy() {
        guard let sceneView = sceneView else { return }
        addSubview(keyboardView)
        addSubview(sceneView)
    }

    private func setupViewConstraints() {
        guard let sceneView = sceneView else { return }
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            keyboardView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            keyboardView.leftAnchor.constraint(equalTo: leftAnchor),
            keyboardView.rightAnchor.constraint(equalTo: rightAnchor),

            sceneView.topAnchor.constraint(equalTo: topAnchor),
            sceneView.leftAnchor.constraint(equalTo: leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: rightAnchor),
            sceneView.bottomAnchor.constraint(equalTo: keyboardView.topAnchor)
        ])
    }
}
