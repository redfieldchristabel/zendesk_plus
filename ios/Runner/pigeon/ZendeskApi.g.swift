// Autogenerated from Pigeon (v22.7.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
      }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> PigeonError {
  return PigeonError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum ZendeskEvent: Int {
  case jwtExpiredException = 0
  case authenticationFailed = 1
  case connectionStatusChanged = 2
  case conversationAdded = 3
  case fieldValidationFailed = 4
  case sendMessageFailed = 5
  case unreadMessageCountChanged = 6
}

/// Represents a user in the Zendesk system.
///
/// This class stores the unique identifier (`id`) and an external identifier (`externalId`)
/// for a user. It is typically returned after authenticating a user with the Zendesk SDK.
///
/// See also:
/// - [ZendeskHostApi.signIn]: Authenticates a user and returns a [ZendeskUser].
///
/// Generated class from Pigeon that represents data sent in messages.
struct ZendeskUser {
  /// The unique identifier for the user in Zendesk.
  ///
  /// This ID is assigned by Zendesk and is used to uniquely identify the user
  /// within the Zendesk system.
  var id: String
  /// The external identifier for the user.
  ///
  /// This ID is used to map the user to an external system (e.g., a CRM or another database).
  /// It is typically provided by the application integrating with Zendesk.
  var externalId: String


  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> ZendeskUser? {
    let id = pigeonVar_list[0] as! String
    let externalId = pigeonVar_list[1] as! String

    return ZendeskUser(
      id: id,
      externalId: externalId
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      externalId,
    ]
  }
}

private class ZendeskApiPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return ZendeskEvent(rawValue: enumResultAsInt)
      }
      return nil
    case 130:
      return ZendeskUser.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class ZendeskApiPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? ZendeskEvent {
      super.writeByte(129)
      super.writeValue(value.rawValue)
    } else if let value = value as? ZendeskUser {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class ZendeskApiPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return ZendeskApiPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return ZendeskApiPigeonCodecWriter(data: data)
  }
}

class ZendeskApiPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = ZendeskApiPigeonCodec(readerWriter: ZendeskApiPigeonCodecReaderWriter())
}


/// A host API for interacting with the Zendesk SDK from Flutter.
///
/// This class provides methods to initialize the Zendesk SDK, open a chat session,
/// authenticate users with JWT, and retrieve unread message counts.
/// It also allows enabling or disabling logging for debugging purposes.
///
/// Example:
/// ```dart
/// final zendesk = ZendeskHostApi();
/// await zendesk.initialize(androidAppId: 'your-android-app-id');
/// zendesk.openChat();
/// ```
///
///
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol ZendeskApi {
  /// Initializes the Zendesk SDK.
  ///
  /// Throws a [PlatformException] if initialization fails (e.g., invalid app ID).
  /// Otherwise, prepares the SDK for use with the provided app IDs.
  ///
  /// Equivalent to setting up the SDK with the required configuration for Android or iOS.
  ///
  /// Example:
  /// ```dart
  /// await zendesk.initialize(androidAppId: 'your-android-app-id');
  /// ```
  ///
  /// See also:
  /// - [signIn]: Authenticates a user with a JWT token.
  /// - [openChat]: Opens the Zendesk chat interface.
  func initialize(androidAppId: String?, iosAppId: String?, completion: @escaping (Result<Void, Error>) -> Void)
  /// Opens the Zendesk chat interface.
  ///
  /// Throws a [PlatformException] if the chat interface cannot be opened
  /// (e.g., SDK not initialized). Otherwise, launches the chat UI for users to
  /// interact with support agents.
  ///
  /// Equivalent to starting a chat session in the Zendesk SDK.
  ///
  /// Example:
  /// ```dart
  /// zendesk.openChat();
  /// ```
  ///
  /// See also:
  /// - [initialize]: Prepares the SDK for use.
  /// - [signIn]: Authenticates a user before opening the chat.
  func openChat() throws
  /// Authenticates a user with a JSON Web Token (JWT).
  ///
  /// - [jwt]: The JWT token for user authentication.
  ///
  /// Throws a [PlatformException] if authentication fails (e.g., invalid JWT).
  /// Otherwise, returns a [ZendeskUser] representing the authenticated user.
  ///
  /// Equivalent to validating the JWT and creating a user session in the ZendeskUser representing the authenticated user.
  ///
  /// Example:
  /// ```dart
  /// final user = await zendesk.signIn('your-jwt-token');
  /// print('Authenticated user: ${user.name}');
  /// ```
  ///
  /// See also:
  /// - [initialize]: Prepares the SDK for use.
  /// - [openChat]: Opens the chat interface after authentication.
  func signIn(jwt: String, completion: @escaping (Result<ZendeskUser, Error>) -> Void)
  /// Signs out the current user.
  ///
  /// Throws a [PlatformException] if signing out fails (e.g., SDK not initialized).
  func signOut(completion: @escaping (Result<Void, Error>) -> Void)
  /// Retrieves the number of unread messages in the user's chat history.
  ///
  /// Returns an number representing the count of unread messages.
  ///
  /// Throws a [PlatformException] if the message count cannot be retrieved
  /// (e.g., SDK not initialized).
  ///
  /// Equivalent to querying the Zendesk SDK for unread messages.
  ///
  /// Example:
  /// ```dart
  /// final unreadCount = await zendesk.getUnreadMessageCount();
  /// print('Unread messages: $unreadCount');
  /// ```
  ///
  /// See also:
  /// - [openChat]: Opens the chat interface.
  /// - [signIn]: Authenticates the user before retrieving messages.
  func getUnreadMessageCount(completion: @escaping (Result<Int64, Error>) -> Void)
  /// Starts listening for events from the Zendesk SDK.
  ///
  /// [ZendeskListener] is used to handle events, implement this class
  /// to receive the events.
  func startListener() throws
  /// Stops listening for events from the Zendesk SDK.
  ///
  /// See [startListener].
  func stopListener() throws
  /// Enables or disables logging for the Zendesk SDK.
  ///
  /// - [enabled]: If `true`, enables logging. If `false`, disables logging.
  ///
  /// See also:
  /// - [loggingEnabled]: Checks whether logging is currently enabled.
  func enableLogging(enabled: Bool) throws
  /// Whether logging is currently enabled for the Zendesk SDK.
  ///
  /// Returns [true] if logging is enabled, otherwise [false].
  ///
  /// See also:
  /// - [enableLogging]: Enables or disables logging for the Zendesk SDK.
  func loggingEnabled() throws -> Bool
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class ZendeskApiSetup {
  static var codec: FlutterStandardMessageCodec { ZendeskApiPigeonCodec.shared }
  /// Sets up an instance of `ZendeskApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: ZendeskApi?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    /// Initializes the Zendesk SDK.
    ///
    /// Throws a [PlatformException] if initialization fails (e.g., invalid app ID).
    /// Otherwise, prepares the SDK for use with the provided app IDs.
    ///
    /// Equivalent to setting up the SDK with the required configuration for Android or iOS.
    ///
    /// Example:
    /// ```dart
    /// await zendesk.initialize(androidAppId: 'your-android-app-id');
    /// ```
    ///
    /// See also:
    /// - [signIn]: Authenticates a user with a JWT token.
    /// - [openChat]: Opens the Zendesk chat interface.
    let initializeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.initialize\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      initializeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let androidAppIdArg: String? = nilOrValue(args[0])
        let iosAppIdArg: String? = nilOrValue(args[1])
        api.initialize(androidAppId: androidAppIdArg, iosAppId: iosAppIdArg) { result in
          switch result {
          case .success:
            reply(wrapResult(nil))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      initializeChannel.setMessageHandler(nil)
    }
    /// Opens the Zendesk chat interface.
    ///
    /// Throws a [PlatformException] if the chat interface cannot be opened
    /// (e.g., SDK not initialized). Otherwise, launches the chat UI for users to
    /// interact with support agents.
    ///
    /// Equivalent to starting a chat session in the Zendesk SDK.
    ///
    /// Example:
    /// ```dart
    /// zendesk.openChat();
    /// ```
    ///
    /// See also:
    /// - [initialize]: Prepares the SDK for use.
    /// - [signIn]: Authenticates a user before opening the chat.
    let openChatChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.openChat\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      openChatChannel.setMessageHandler { _, reply in
        do {
          try api.openChat()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      openChatChannel.setMessageHandler(nil)
    }
    /// Authenticates a user with a JSON Web Token (JWT).
    ///
    /// - [jwt]: The JWT token for user authentication.
    ///
    /// Throws a [PlatformException] if authentication fails (e.g., invalid JWT).
    /// Otherwise, returns a [ZendeskUser] representing the authenticated user.
    ///
    /// Equivalent to validating the JWT and creating a user session in the ZendeskUser representing the authenticated user.
    ///
    /// Example:
    /// ```dart
    /// final user = await zendesk.signIn('your-jwt-token');
    /// print('Authenticated user: ${user.name}');
    /// ```
    ///
    /// See also:
    /// - [initialize]: Prepares the SDK for use.
    /// - [openChat]: Opens the chat interface after authentication.
    let signInChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.signIn\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      signInChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let jwtArg = args[0] as! String
        api.signIn(jwt: jwtArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      signInChannel.setMessageHandler(nil)
    }
    /// Signs out the current user.
    ///
    /// Throws a [PlatformException] if signing out fails (e.g., SDK not initialized).
    let signOutChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.signOut\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      signOutChannel.setMessageHandler { _, reply in
        api.signOut { result in
          switch result {
          case .success:
            reply(wrapResult(nil))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      signOutChannel.setMessageHandler(nil)
    }
    /// Retrieves the number of unread messages in the user's chat history.
    ///
    /// Returns an number representing the count of unread messages.
    ///
    /// Throws a [PlatformException] if the message count cannot be retrieved
    /// (e.g., SDK not initialized).
    ///
    /// Equivalent to querying the Zendesk SDK for unread messages.
    ///
    /// Example:
    /// ```dart
    /// final unreadCount = await zendesk.getUnreadMessageCount();
    /// print('Unread messages: $unreadCount');
    /// ```
    ///
    /// See also:
    /// - [openChat]: Opens the chat interface.
    /// - [signIn]: Authenticates the user before retrieving messages.
    let getUnreadMessageCountChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.getUnreadMessageCount\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getUnreadMessageCountChannel.setMessageHandler { _, reply in
        api.getUnreadMessageCount { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      getUnreadMessageCountChannel.setMessageHandler(nil)
    }
    /// Starts listening for events from the Zendesk SDK.
    ///
    /// [ZendeskListener] is used to handle events, implement this class
    /// to receive the events.
    let startListenerChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.startListener\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startListenerChannel.setMessageHandler { _, reply in
        do {
          try api.startListener()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startListenerChannel.setMessageHandler(nil)
    }
    /// Stops listening for events from the Zendesk SDK.
    ///
    /// See [startListener].
    let stopListenerChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.stopListener\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      stopListenerChannel.setMessageHandler { _, reply in
        do {
          try api.stopListener()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      stopListenerChannel.setMessageHandler(nil)
    }
    /// Enables or disables logging for the Zendesk SDK.
    ///
    /// - [enabled]: If `true`, enables logging. If `false`, disables logging.
    ///
    /// See also:
    /// - [loggingEnabled]: Checks whether logging is currently enabled.
    let enableLoggingChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.enableLogging\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      enableLoggingChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.enableLogging(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      enableLoggingChannel.setMessageHandler(nil)
    }
    /// Whether logging is currently enabled for the Zendesk SDK.
    ///
    /// Returns [true] if logging is enabled, otherwise [false].
    ///
    /// See also:
    /// - [enableLogging]: Enables or disables logging for the Zendesk SDK.
    let loggingEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.zendesk_plus.ZendeskApi.loggingEnabled\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      loggingEnabledChannel.setMessageHandler { _, reply in
        do {
          let result = try api.loggingEnabled()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      loggingEnabledChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol ZendeskListenerProtocol {
  func onEvent(event eventArg: ZendeskEvent, completion: @escaping (Result<Void, PigeonError>) -> Void)
}
class ZendeskListener: ZendeskListenerProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  private let messageChannelSuffix: String
  init(binaryMessenger: FlutterBinaryMessenger, messageChannelSuffix: String = "") {
    self.binaryMessenger = binaryMessenger
    self.messageChannelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
  }
  var codec: ZendeskApiPigeonCodec {
    return ZendeskApiPigeonCodec.shared
  }
  func onEvent(event eventArg: ZendeskEvent, completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.zendesk_plus.ZendeskListener.onEvent\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([eventArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
