//import UIKit
//import Flutter
//import ZendeskSDKMessaging
//import ZendeskSDK
//
//public class ZendeskMessaging: NSObject {
//    private static let unreadMessages: String = "unread_messages"
//    private let TAG = "[ZendeskMessaging]"
//    
//    private weak var zendeskPlugin: ZendeskPlusPlugin?
//    private let channel: FlutterMethodChannel
//
//    init(flutterPlugin: ZendeskPlusPlugin, channel: FlutterMethodChannel) {
//        self.zendeskPlugin = flutterPlugin
//        self.channel = channel
//    }
//    
//    func initialize(iosChannelId: String, completion: @escaping (FlutterError?) -> Void) {
//        print("\(TAG) - Channel Key - \(iosChannelId)\n")
//        Zendesk.initialize(withChannelKey: iosChannelId, messagingFactory: DefaultMessagingFactory()) { result in
//            DispatchQueue.main.async {
//                if case let .failure(error) = result {
//                    self.zendeskPlugin?.isInitialized = false
//                    print("\(self.TAG) - initialize failure - \(error.localizedDescription)\n")
//                    completion(FlutterError(
//                        code: "initialize_error",
//                        message: error.localizedDescription,
//                        details: nil)
//                    )
//                } else {
//                    self.zendeskPlugin?.isInitialized = true
//                    print("\(self.TAG) - initialize success")
//                    completion(nil)
//                }
//            }
//        }
//    }
//
//    func invalidate() {
//        Zendesk.invalidate()
//        self.zendeskPlugin?.isInitialized = false
//        print("\(TAG) - invalidate")
//    }
//    
//    func show(rootViewController: UIViewController?, flutterResult: @escaping FlutterResult) {
//        guard let messagingViewController = Zendesk.instance?.messaging?.messagingViewController() else {
//            print("\(TAG) - Unable to create Zendesk messaging view controller")
//            flutterResult(FlutterError(
//                code: "show_error",
//                message: "Unable to create Zendesk messaging view controller",
//                details: nil)
//            )
//            return
//        }
//        guard let rootViewController = rootViewController else {
//            print("\(TAG) - Root view controller is nil")
//            flutterResult(FlutterError(
//                code: "show_error",
//                message: "Root view controller is nil",
//                details: nil)
//            )
//            return
//        }
//        let navController = UINavigationController(rootViewController: messagingViewController)
//        DispatchQueue.main.async {
//            if let presentedVC = rootViewController.presentedViewController {
//                presentedVC.dismiss(animated: true) {
//                    rootViewController.present(navController, animated: true, completion: nil)
//                }
//            } else {
//                rootViewController.present(navController, animated: true, completion: nil)
//            }
//            flutterResult(nil)
//        }
//    }
//
//    func loginUser(jwt: String, flutterResult: @escaping FlutterResult) {
//        Zendesk.instance?.loginUser(with: jwt) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let user):
//                    self.zendeskPlugin?.isLoggedIn = true
//                    flutterResult([
//                        "id": user.id,
//                        "externalId": user.externalId
//                    ])
//                case .failure(let error):
//                    flutterResult(FlutterError(
//                        code: "login_error",
//                        message: error.localizedDescription,
//                        details: nil)
//                    )
//                }
//            }
//        }
//    }
//    
//    func logoutUser(flutterResult: @escaping FlutterResult) {
//        Zendesk.instance?.logoutUser { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    self.zendeskPlugin?.isLoggedIn = false
//                    flutterResult(nil)
//                case .failure(let error):
//                    flutterResult(FlutterError(
//                        code: "logout_error",
//                        message: error.localizedDescription,
//                        details: nil)
//                    )
//                }
//            }
//        }
//    }
//    
//    func getUnreadMessageCount() -> Int {
//        return Zendesk.instance?.messaging?.getUnreadMessageCount() ?? 0
//    }
//    
//    func listenMessageCountChanged() {
//        Zendesk.instance?.addEventObserver(self) { event in
//            if case let .unreadMessageCountChanged(currentUnreadCount) = event {
//                self.channel.invokeMethod(
//                    Self.unreadMessages,
//                    arguments: ["messages_count": currentUnreadCount]
//                )
//            }
//        }
//    }
//}
