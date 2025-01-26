// Autogenerated from Pigeon (v22.7.3), do not edit directly.
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

  Object encode() {
    return <Object?>[
      id,
      externalId,
    ];
  }

  static ZendeskUser decode(Object result) {
    result as List<Object?>;
    return ZendeskUser(
      id: result[0]! as String,
      externalId: result[1]! as String,
    );
  }
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
class ZendeskApi {
  /// Constructor for [ZendeskApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ZendeskApi({BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
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
  Future<void> initialize({String? androidAppId, String? iosAppId}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.initialize$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[androidAppId, iosAppId]) as List<Object?>?;
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
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.openChat$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
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
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.signIn$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[jwt]) as List<Object?>?;
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
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.signOut$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
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
  Future<int> getUnreadMessageCount() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.getUnreadMessageCount$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
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
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.startListener$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
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
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.stopListener$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
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
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.enableLogging$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[enabled]) as List<Object?>?;
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
    final String pigeonVar_channelName = 'dev.flutter.pigeon.zendesk_plus.ZendeskApi.loggingEnabled$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
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
