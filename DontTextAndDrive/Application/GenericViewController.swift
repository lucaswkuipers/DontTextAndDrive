import UIKit
import SceneKit

protocol GenericViewControllerDelegate: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillLayoutSubviews()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

extension GenericViewControllerDelegate {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewWillLayoutSubviews() {}
    func viewDidLayoutSubviews() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}

final class GenericViewController: UIViewController {
    weak var delegate: GenericViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.viewWillAppear()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        delegate?.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        delegate?.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.viewWillDisappear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.viewDidDisappear()
    }
}
