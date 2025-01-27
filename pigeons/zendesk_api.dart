import 'package:pigeon/pigeon.dart';

//run in the root folder: flutter pub run pigeon --input pigeons/text_api.dart

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
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/pigeon/zendesk_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/src/main/kotlin/my/com/fromyourlover/pigeon/ZendeskApi.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'my.com.fromyourlover.pigeon',
  ),
  swiftOut: 'ios/Runner/pigeon/ZendeskApi.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'zendesk_plus',
))
@HostApi()
abstract class ZendeskHostApi {
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
  @async
  void initialize({String? androidChannelId, String? iosChannelId});

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
  void openChat();

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
  @async
  ZendeskUser signIn(String jwt);

  /// Signs out the current user.
  ///
  /// Throws a [PlatformException] if signing out fails (e.g., SDK not initialized).
  @async
  void signOut();

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
  /// Opens the chat interface.
  /// - [signIn]: Authenticates the user before retrieving messages.
  @async
  int getUnreadMessageCount();

  /// Starts listening for events from the Zendesk SDK.
  ///
  /// [ZendeskListener] is used to handle events, implement this class
  /// to receive the events.
  void startListener();

  /// Stops listening for events from the Zendesk SDK.
  ///
  /// See [startListener].
  void stopListener();

  void setLightColorRgba(UserColors colors);

  void setDarkColorRgba(UserColors colors);

  /// Enables or disables logging for the Zendesk SDK.
  ///
  /// - [enabled]: If `true`, enables logging. If `false`, disables logging.
  ///
  /// See also:
  /// - [loggingEnabled]: Checks whether logging is currently enabled.
  void enableLogging([bool enabled = true]);

  /// Whether logging is currently enabled for the Zendesk SDK.
  ///
  /// Returns [true] if logging is enabled, otherwise [false].
  ///
  /// See also:
  /// - [enableLogging]: Enables or disables logging for the Zendesk SDK.
  bool loggingEnabled();
}

@FlutterApi()
abstract class ZendeskListener {
  void onEvent(ZendeskEvent event) {}
}

enum ZendeskEvent {
  jwtExpiredException,
  authenticationFailed,
  connectionStatusChanged,
  conversationAdded,
  fieldValidationFailed,
  sendMessageFailed,
  unreadMessageCountChanged,
}

/// Represents a user in the Zendesk system.
///
/// This class stores the unique identifier (`id`) and an external identifier (`externalId`)
/// for a user. It is typically returned after authenticating a user with the Zendesk SDK.
///
/// See also:
/// - [ZendeskHostApi.signIn]: Authenticates a user and returns a [ZendeskUser].
class ZendeskUser {
  /// The unique identifier for the user in Zendesk.
  ///
  /// This ID is assigned by Zendesk and is used to uniquely identify the user
  /// within the Zendesk system.
  final String id;

  /// The external identifier for the user.
  ///
  /// This ID is used to map the user to an external system (e.g., a CRM or another database).
  /// It is typically provided by the application integrating with Zendesk.
  final String externalId;

  /// Creates a new instance of [ZendeskUser].
  ///
  /// - [id]: The unique identifier for the user in Zendesk.
  /// - [externalId]: The external identifier for the user.
  ///
  /// Example:
  /// ```dart
  /// final user = ZendeskUser(id: '12345', externalId: '67890');
  /// ```
  ZendeskUser({required this.id, required this.externalId});
}

class RgbaColor {
  final double r;
  final double g;
  final double b;
  final double a;

  RgbaColor(this.r, this.g, this.b, this.a);
}

class UserColors {
  final RgbaColor? onPrimary;
  final RgbaColor? onMessage;
  final RgbaColor? onAction;

  UserColors({this.onPrimary, this.onMessage, this.onAction});
}
