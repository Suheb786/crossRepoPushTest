import 'package:flutter/foundation.dart';

class NetworkProperties {
  static const String BASE_URL = kReleaseMode
      ? "http://40.114.120.180:2189/api"
      : "http://40.114.120.180:2189/api";
}
