import 'dart:ui';

import 'package:zendesk_plus/src/pigeon/zendesk_api.g.dart' as pigeon;

export 'package:zendesk_plus/src/pigeon/zendesk_api.g.dart'
    show ZendeskListener, ZendeskEvent;

class ZendeskApi extends pigeon.ZendeskHostApi {
  Future<void> setLightColor(UserColors colors) =>
      setLightColorRgba(colors.toAndroidColors());

  Future<void> setDarkColor(UserColors colors) =>
      setDarkColorRgba(colors.toAndroidColors());
}

class UserColors {
  final Color? onPrimary;
  final Color? onAction;
  final Color? onMessage;

  UserColors({this.onPrimary, this.onAction, this.onMessage});

  pigeon.UserColors toAndroidColors() => pigeon.UserColors(
      onPrimary: onPrimary?.toRgbaColor(),
      onAction: onAction?.toRgbaColor(),
      onMessage: onMessage?.toRgbaColor());
}

extension on Color {
  toRgbaColor() => pigeon.RgbaColor(r: r, g: g, b: b, a: a);
}
