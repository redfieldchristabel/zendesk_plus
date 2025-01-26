import 'dart:ui';

import 'package:zendesk_plus/src/pigeon/zendesk_api.g.dart';

export 'package:zendesk_plus/src/pigeon/zendesk_api.g.dart'
    show ZendeskListener, ZendeskEvent;

class ZendeskApi extends ZendeskHostApi {
  Future<void> setLightColor(Color color) =>
      setLightColorRgba(color.r, color.g, color.b, color.a);
}
