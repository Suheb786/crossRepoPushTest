class NetworkProperties {

  /// TIME OUT...
  static const Duration MAIN_TIMEOUT = Duration(seconds : 120);
  static const Duration WARNING_TIMEOUT = Duration(seconds : 60);


  /// UAT(RELEASE) CONFIGURATION FOR CHANNEL & ROUTER API
  // static const String BASE_CHANNEL_URL =
  //     "https://MobWeb-uat.theblink.com:2821/api";
  // static const String BASE_ROUTER_URL =
  //     "https://Rout-uat.theblink.com:2821/api";

  /// DEV CONFIGURATION FOR CHANNEL & ROUTER API
  static const String BASE_CHANNEL_URL = "http://10.6.13.2:2186/api";
  static const String BASE_ROUTER_URL = "https://10.6.13.1:2186/api";
  static const String BASE_BENEFICIARY_URL = "http://10.6.13.2:2186/contactcenter/api";
  static const String BASE_EV0UCHER_URL = "http://10.6.13.2:2186/Voucher/api";

  ///VAPT / PREPROD CONFIGURATION
// static const String BASE_CHANNEL_URL = "https://mobwebuat1.theblink.com:3443/api";
// static const String BASE_ROUTER_URL = "https://routuat1.theblink.com:1443/api";
// static const String BASE_BENEFICIARY_URL = "https://mobwebuat1.theblink.com:3443/contactcenter/api";
// static const String BASE_EV0UCHER_URL = "https://mobwebuat1.theblink.com:3443/Voucher/api";
}
