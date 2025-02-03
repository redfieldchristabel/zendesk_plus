import Foundation
import Flutter
import UIKit
import ZendeskSDKMessaging
import ZendeskSDK
import ZendeskSDKLogger

public class ZendeskPlusPlugin: NSObject, FlutterPlugin, ZendeskHostApi {
    
    // MARK: - FlutterPlugin
    private var zendesk: Zendesk?
    var isloggedIn: Bool = false
    var factory = DefaultMessagingFactory()
    private static var zendeskListener: ZendeskListener?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = ZendeskPlusPlugin()
        ZendeskHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
        zendeskListener = ZendeskListener(binaryMessenger: registrar.messenger())
    }
    
    func initialized() throws -> Bool {
        return zendesk != nil
    }
    
    func signedIn() throws -> Bool {
        return isloggedIn
    }

    func initialize(androidChannelId: String?, iosChannelId: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        // Ensure the iOS channel ID is provided
        guard let iosChannelId = iosChannelId else {
            let error = PigeonError(
                code: "invalid_ios_channel_id",
                message: "iOS channel ID is required",
                details: nil
            )
            completion(.failure(error))
            return
        }
        
        // Initialize Zendesk with the provided channel key
        Zendesk.initialize(withChannelKey: iosChannelId, messagingFactory: factory) {  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let zendeskInstance):
                    // Store the initialized Zendesk instance
                    self.zendesk = zendeskInstance
                    print("Zendesk initialized successfully.")
                    completion(.success(()))
                case .failure(let error):
                    print("Zendesk initialization failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    func openChat() throws {
        // Ensure Zendesk is initialized
        guard let zendeskInstance = Zendesk.instance else {
            throw PigeonError(
                code: "zendesk_not_initialized",
                message: "Zendesk instance is not initialized",
                details: nil
            )
        }

        // Ensure messaging is available
        guard let messagingViewController = zendeskInstance.messaging?.messagingViewController() else {
            throw PigeonError(
                code: "messaging_not_available",
                message: "Zendesk messaging view controller is not available",
                details: nil
            )
        }

        // Get the root view controller
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            throw PigeonError(
                code: "root_view_controller_not_found",
                message: "Root view controller is nil",
                details: nil
            )
        }

        // Wrap the messaging view controller in a navigation controller
        let navController = UINavigationController(rootViewController: messagingViewController)

        // Present the navigation controller
        DispatchQueue.main.async {
            if let presentedVC = rootViewController.presentedViewController {
                if presentedVC !== navController {
                    presentedVC.dismiss(animated: true) {
                        rootViewController.present(navController, animated: true, completion: nil)
                    }
                } else {
                    print("Zendesk messaging view controller is already presented")
                }
            } else {
                rootViewController.present(navController, animated: true, completion: nil)
            }
        }
    }
    
    func signIn(jwt: String, completion: @escaping (Result<ZendeskUser, Error>) -> Void) {
        guard let zendesk = Zendesk.instance else {
            completion(.failure(PigeonError(
                code: "zendesk_not_initialized",
                message: "Zendesk SDK is not initialized.",
                details: nil
            )))
            return
        }
        
        zendesk.loginUser(with: jwt) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    let zendeskUser = ZendeskUser(id: user.id, externalId: user.externalId)
                    self.isloggedIn = true
                    completion(.success(zendeskUser))
                case .failure(let error):
                    print("Sign-in failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }

    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let zendesk = Zendesk.instance else {
            completion(.failure(PigeonError(
                code: "zendesk_not_initialized",
                message: "Zendesk instance is not initialized",
                details: nil
            )))
            return
        }

        zendesk.logoutUser { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isloggedIn = false
                    completion(.success(()))
                case .failure(let error):
                    // Propagate the error to the completion handler
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    func getUnreadMessageCount(completion: @escaping (Result<Int64, Error>) -> Void) {
        // Retrieve unread message count
        let count = zendesk?.messaging?.getUnreadMessageCount() ?? 0
        completion(.success(Int64(count)))
    }

    func startListener() {
        
        zendesk?.addEventObserver(self) { event in
            switch event {
                case .unreadMessageCountChanged(let currentUnreadCount):
                    ZendeskPlusPlugin.zendeskListener?.onEvent(event: ZendeskEvent.unreadMessageCountChanged, completion: {_ in })

                    
                case .authenticationFailed(let error as NSError):
                    ZendeskPlusPlugin.zendeskListener?.onEvent(event: ZendeskEvent.authenticationFailed, completion: {_ in })
                
                    if error.code == 401 {
                        ZendeskPlusPlugin.zendeskListener?.onEvent(event: ZendeskEvent.jwtExpiredException, completion: {_ in })
                    }
                    
                case .conversationAdded(conversationId: let conversationId):
                    ZendeskPlusPlugin.zendeskListener?.onEvent(event: ZendeskEvent.conversationAdded , completion: {_ in })
                    
                case .connectionStatusChanged(connectionStatus: let connectionStatus):
                    ZendeskPlusPlugin.zendeskListener?.onEvent(event: ZendeskEvent.connectionStatusChanged , completion: {_ in })
                    
                case .sendMessageFailed(let error as NSError):
                    ZendeskPlusPlugin.zendeskListener?.onEvent(event: ZendeskEvent.sendMessageFailed , completion: {_ in })
                    
                @unknown default:
                    break
            }
        }
    }

    func stopListener() throws {
        // Stop listening for Zendesk events
        zendesk?.removeEventObserver(self)
    }

    func setLightColorRgba(colors: UserColors) {
        // Convert RgbaColor to UIColor
        let onPrimaryColor = UIColor.fromRgbaColor(colors.onPrimary ?? RgbaColor(r: 255.0, g: 0.0, b: 0.0, a: 1.0))
        let onMessageColor = UIColor.fromRgbaColor(colors.onMessage ?? RgbaColor(r: 255.0, g: 0.0, b: 0.0, a: 1.0))
        let onActionColor = UIColor.fromRgbaColor(colors.onAction ?? RgbaColor(r: 255.0, g: 0.0, b: 0.0, a: 1.0))

        // Create ZendeskSDKMessaging.UserColors with UIColor
        let userLightColors = ZendeskSDKMessaging.UserColors(
            onPrimary: onPrimaryColor,
            onMessage: onMessageColor,
            onAction: onActionColor
        )

        // Update the factory with the new colors
        self.factory = DefaultMessagingFactory(userLightColors: userLightColors)
    }

    func setDarkColorRgba(colors: UserColors) throws {
        // Convert RgbaColor to UIColor
        let onPrimaryColor = UIColor.fromRgbaColor(colors.onPrimary!)
        let onMessageColor = UIColor.fromRgbaColor(colors.onMessage!)
        let onActionColor = UIColor.fromRgbaColor(colors.onAction!)

        // Create ZendeskSDKMessaging.UserColors with UIColor
        let userColors = ZendeskSDKMessaging.UserColors(
            onPrimary: onPrimaryColor,
            onMessage: onMessageColor,
            onAction: onActionColor
        )

        // Update the factory with the new colors
        self.factory = DefaultMessagingFactory(userLightColors: ZendeskSDKMessaging.UserColors(onPrimary: nil, onMessage: nil, onAction: nil), userDarkColors: userColors)
    }

    func enableLogging(enabled: Bool) {
        Logger.enabled = enabled
    }

    func loggingEnabled() -> Bool {
        return true;
    }

}


extension UIColor {
    static func fromRgbaColor(_ rgbaColor: RgbaColor) -> UIColor {
        return UIColor(
            red: CGFloat(rgbaColor.r),
            green: CGFloat(rgbaColor.g),
            blue: CGFloat(rgbaColor.b),
            alpha: CGFloat(rgbaColor.a)
        )
    }
}
