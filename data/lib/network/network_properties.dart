import 'package:flutter/foundation.dart';

class NetworkProperties {
  static const String BASE_URL = kReleaseMode
      ? "http://10.151.1.5:2821/api"
      : "http://10.151.1.5:2821/api";
}
