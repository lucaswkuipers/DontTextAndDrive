import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = AppWindowComposer.makeWindow()
        log("✅ App finished launching with success!")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        AppAdapter.shared.willApplicationBecomeInactive()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppAdapter.shared.didApplicationBecomeActive()
    }
}
