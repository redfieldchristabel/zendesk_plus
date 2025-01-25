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

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    ZendeskListener.setUp(this);
    await ZendeskHostApi().initialize(androidAppId: "From Zendesk Admin");

    final a = await ZendeskHostApi().signIn(getJwt());

    final x = await ZendeskHostApi().getUnreadMessageCount();
    print("aaa ${a.externalId}");
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
            ZendeskHostApi().openChat();
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
    ZendeskListener.setUp(null);
    super.dispose();
  }

  @override
  Future<void> onEvent(ZendeskEvent event) async {
    print("flutter ebvent trigger $event");

    if (event == ZendeskEvent.unreadMessageCountChanged) {
      final x = await ZendeskHostApi().getUnreadMessageCount();
      setState(() {
        unreadMessage = x;
      });
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
