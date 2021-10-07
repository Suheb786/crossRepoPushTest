import 'package:flutter/foundation.dart';

class NetworkProperties {
  static const String BASE_URL =
      kReleaseMode ? "http://a.b.com/api" : "http://a.b.com/api";
}
