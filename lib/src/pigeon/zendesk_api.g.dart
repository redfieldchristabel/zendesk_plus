// Autogenerated from Pigeon (v25.3.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

List<Object?> wrapResponse({Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}
bool _deepEquals(Object? a, Object? b) {
  if (a is List && b is List) {
    return a.length == b.length &&
        a.indexed
        .every(((int, dynamic) item) => _deepEquals(item.$2, b[item.$1]));
  }
  if (a is Map && b is Map) {
    return a.length == b.length && a.entries.every((MapEntry<Object?, Object?> entry) =>
        (b as Map<Object?, Object?>).containsKey(entry.key) &&
        _deepEquals(entry.value, b[entry.key]));
  }
  return a == b;
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
  ZendeskUser({
    required this.id,
    required this.externalId,
  });

  /// The unique identifier for the user in Zendesk.
  ///
  /// This ID is assigned by Zendesk and is used to uniquely identify the user
  /// within the Zendesk system.
  String id;

  /// The external identifier for the user.
  ///
  /// This ID is used to map the user to an external system (e.g., a CRM or another database).
  /// It is typically provided by the application integrating with Zendesk.
  String externalId;

  List<Object?> _toList() {
    return <Object?>[
      id,
      externalId,
    ];
  }

  Object encode() {
    return _toList();  }

  static ZendeskUser decode(Object result) {
    result as List<Object?>;
    return ZendeskUser(
      id: result[0]! as String,
      externalId: result[1]! as String,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! ZendeskUser || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList())
;
}

class RgbaColor {
  RgbaColor({
    required this.r,
    required this.g,
    required this.b,
    required this.a,
  });

  double r;

  double g;

  double b;

  double a;

  List<Object?> _toList() {
    return <Object?>[
      r,
      g,
      b,
      a,
    ];
  }

  Object encode() {
    return _toList();  }

  static RgbaColor decode(Object result) {
    result as List<Object?>;
    return RgbaColor(
      r: result[0]! as double,
      g: result[1]! as double,
      b: result[2]! as double,
      a: result[3]! as double,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! RgbaColor || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList())
;
}

class UserColors {
  UserColors({
    this.onPrimary,
    this.onMessage,
    this.onAction,
  });

  RgbaColor? onPrimary;

  RgbaColor? onMessage;

  RgbaColor? onAction;

  List<Object?> _toList() {
    return <Object?>[
      onPrimary,
      onMessage,
      onAction,
    ];
  }

  Object encode() {
    return _toList();  }

  static UserColors decode(Object result) {
    result as List<Object?>;
    return UserColors(
      onPrimary: result[0] as RgbaColor?,
      onMessage: result[1] as RgbaColor?,
      onAction: result[2] as RgbaColor?,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! UserColors || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList())
;
}


class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    }    else if (value is ZendeskEvent) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    }    else if (value is ZendeskUser) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    }    else if (value is RgbaColor) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    }    else if (value is UserColors) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : ZendeskEvent.values[value];
      case 130: 
        return ZendeskUser.decode(readValue(buffer)!);
      case 131: 
        return RgbaColor.decode(readValue(buffer)!);
      case 132: 
        return UserColors.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
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
class ZendeskHostApi {
  /// Constructor for [ZendeskHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ZendeskHostApi({BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

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
  Future<void> initialize({String? androidChannelId, String? iosChannelId}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.initialize$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(<Object?>[androidChannelId, iosChannelId]);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<bool> initialized() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.initialized$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
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
  Future<void> openChat() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.openChat$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
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
  Future<ZendeskUser> signIn(String jwt) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.signIn$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(<Object?>[jwt]);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as ZendeskUser?)!;
    }
  }

  /// Signs out the current user.
  ///
  /// Throws a [PlatformException] if signing out fails (e.g., SDK not initialized).
  Future<void> signOut() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.signOut$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Checks whether a user is currently signed in.
  Future<bool> signedIn() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.signedIn$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
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
  /// Opens the chat interface.
  /// - [signIn]: Authenticates the user before retrieving messages.
  Future<int> getUnreadMessageCount() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.getUnreadMessageCount$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as int?)!;
    }
  }

  /// Starts listening for events from the Zendesk SDK.
  ///
  /// [ZendeskListener] is used to handle events, implement this class
  /// to receive the events.
  Future<void> startListener() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.startListener$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Stops listening for events from the Zendesk SDK.
  ///
  /// See [startListener].
  Future<void> stopListener() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.stopListener$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> setLightColorRgba(UserColors colors) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.setLightColorRgba$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(<Object?>[colors]);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> setDarkColorRgba(UserColors colors) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.setDarkColorRgba$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(<Object?>[colors]);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Enables or disables logging for the Zendesk SDK.
  ///
  /// - [enabled]: If `true`, enables logging. If `false`, disables logging.
  ///
  /// See also:
  /// - [loggingEnabled]: Checks whether logging is currently enabled.
  Future<void> enableLogging([bool enabled = true]) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.enableLogging$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(<Object?>[enabled]);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Whether logging is currently enabled for the Zendesk SDK.
  ///
  /// Returns [true] if logging is enabled, otherwise [false].
  ///
  /// See also:
  /// - [enableLogging]: Enables or disables logging for the Zendesk SDK.
  Future<bool> loggingEnabled() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskHostApi.loggingEnabled$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }
}

abstract class ZendeskListener {
  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  void onEvent(ZendeskEvent event);

  static void setUp(ZendeskListener? api, {BinaryMessenger? binaryMessenger, String messageChannelSuffix = '',}) {
    messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.zendesk_plus.ZendeskListener.onEvent$messageChannelSuffix', pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.zendesk_plus.ZendeskListener.onEvent was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final ZendeskEvent? arg_event = (args[0] as ZendeskEvent?);
          assert(arg_event != null,
              'Argument for dev.flutter.pigeon.zendesk_plus.ZendeskListener.onEvent was null, expected non-null ZendeskEvent.');
          try {
            api.onEvent(arg_event!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
