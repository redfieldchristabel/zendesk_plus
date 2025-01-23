// import 'package:flutter_test/flutter_test.dart';
// import 'package:zendesk_plus/zendesk_plus.dart';
// import 'package:zendesk_plus/zendesk_plus_platform_interface.dart';
// import 'package:zendesk_plus/zendesk_plus_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockZendeskPlusPlatform
//     with MockPlatformInterfaceMixin
//     implements ZendeskPlusPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final ZendeskPlusPlatform initialPlatform = ZendeskPlusPlatform.instance;
//
//   test('$MethodChannelZendeskPlus is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelZendeskPlus>());
//   });
//
//   test('getPlatformVersion', () async {
//     ZendeskPlus zendeskPlusPlugin = ZendeskPlus();
//     MockZendeskPlusPlatform fakePlatform = MockZendeskPlusPlatform();
//     ZendeskPlusPlatform.instance = fakePlatform;
//
//     expect(await zendeskPlusPlugin.getPlatformVersion(), '42');
//   });
// }
