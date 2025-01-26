import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:zendesk_plus/zendesk_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements ZendeskListener {
  bool initialized = false;
  int unreadMessage = 0;
  final zendesk = ZendeskApi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    ZendeskListener.setUp(this);
    await zendesk.initialize(androidAppId: "From Zendesk Admin");

    await zendesk.signIn(getJwt());

    await zendesk.startListener();

    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            zendesk.openChat();
          },
        ),
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child:
              Text('Running on: $initialized ,  message count $unreadMessage'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposeZendesk();
    super.dispose();
  }

  Future<void> _disposeZendesk() async {
    await zendesk.stopListener();
    ZendeskListener.setUp(null);
  }

  @override
  Future<void> onEvent(ZendeskEvent event) async {
    print("flutter ebvent trigger $event");

    if (event == ZendeskEvent.unreadMessageCountChanged) {
      final x = await zendesk.getUnreadMessageCount();
      setState(() {
        unreadMessage = x;
      });
    } else if (event == ZendeskEvent.jwtExpiredException) {
      await zendesk.signIn(getJwt());
    }
  }
}

String getJwt() {
  // Your secret key
  final secret = 'Get from zendesk Admin';
  final keyId = 'Get from zendesk Admin';

  // Create the JWT
  final jwt = JWT(
    {
      'scope': 'user',
      'external_id': '14',
    },
    header: {
      'kid': keyId,
    },
  );

  // Sign the JWT
  return jwt.sign(SecretKey(secret));
}
