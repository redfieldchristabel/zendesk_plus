import 'package:pigeon/pigeon.dart';

//run in the root folder: flutter pub run pigeon --input pigeons/text_api.dart

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon/zendesk_api.g.dart',
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
  void initialize({String? androidAppId, String? iosAppId});

  void openChat();
}

@FlutterApi()
abstract class ZendeskFlutterApi {
  // Define your methods here
}
