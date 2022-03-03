import UIKit
import SceneKit

protocol GameSceneViewProtocol: SCNView {}

final class GameView: UIView {
    var sceneView: GameSceneViewProtocol? {
        didSet {
            guard let sceneView = sceneView else { return }

            addSubview(sceneView)
            sceneView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                sceneView.topAnchor.constraint(equalTo: topAnchor),
                sceneView.leftAnchor.constraint(equalTo: leftAnchor),
                sceneView.rightAnchor.constraint(equalTo: rightAnchor),
                sceneView.heightAnchor.constraint(equalToConstant: 500)
            ])
        }
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
