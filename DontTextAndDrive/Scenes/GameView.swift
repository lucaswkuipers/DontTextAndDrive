import UIKit
import SceneKit

final class GameView: UIView {
    private let textInputHeight: CGFloat = 40
    var keyboardHeight: CGFloat = 301
    var sceneView: GameSceneViewProtocol? {
        didSet {
            guard let sceneView = sceneView else { return }

            addSubview(sceneView)
            addSubview(messageTextField)
            subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            NSLayoutConstraint.activate([
                messageTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -keyboardHeight - 5),
                messageTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                messageTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                messageTextField.heightAnchor.constraint(equalToConstant: textInputHeight),

                sceneView.topAnchor.constraint(equalTo: topAnchor),
                sceneView.leftAnchor.constraint(equalTo: leftAnchor),
                sceneView.rightAnchor.constraint(equalTo: rightAnchor),
                sceneView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -5)
            ])
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.keyboardHeight = keyboardHeight
        print("HEIGHT: \(keyboardHeight)")
    }

    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .asciiCapable
        textField.allowsEditingTextAttributes = false
        textField.clearButtonMode = .always
        textField.enablesReturnKeyAutomatically = false
        textField.spellCheckingType = .no
        textField.backgroundColor = .secondarySystemBackground
        textField.textColor = .label
        textField.layer.cornerRadius = textInputHeight / 2
        return textField
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
