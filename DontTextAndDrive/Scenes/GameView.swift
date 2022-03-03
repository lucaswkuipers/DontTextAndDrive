import UIKit
import SceneKit

final class GameView: UIView {
    var sceneView: GameSceneViewProtocol? {
        didSet {
            setupViewHierarchy()
            setupViewConstraints()
        }
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewHierarchy() {
        guard let sceneView = sceneView else { return }
        addSubview(sceneView)
    }

    private func setupViewConstraints() {
        guard let sceneView = sceneView else { return }
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: topAnchor),
            sceneView.leftAnchor.constraint(equalTo: leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: rightAnchor),
            sceneView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}
