class NetworkProperties {
  /// TIME OUT...
  static Duration MAIN_TIMEOUT = Duration(minutes: 3);
  static Duration WARNING_TIMEOUT = Duration(minutes: 1);

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
  static const String BASE_RJ_URL = "http://10.6.13.2:2186/RJAPI/api";
  static const String BASE_OFFER_CAMPAIGN_URL = "http://10.6.13.2:2186/Offers/api";
  static const String BASE_ONBOARDING_URL = "http://10.6.13.2:2186/Onboarding/api/Onboarding";

  /// DEV CONFIGURATION FOR CHANNEL & ROUTER API (GCM)
// static const String BASE_CHANNEL_URL = "http://10.6.13.2:8190/api";
// static const String BASE_ROUTER_URL = "https://10.6.13.1:2186/api";
// static const String BASE_BENEFICIARY_URL = "http://10.6.13.2:8190/contactcenter/api";
// static const String BASE_EV0UCHER_URL = "http://10.6.13.2:8190/Voucher/api";
// static const String BASE_RJ_URL = "http://10.6.13.2:8190/RJAPI/api";
// static const String BASE_OFFER_CAMPAIGN_URL = "http://10.6.13.2:8190/Offers/api";

  ///VAPT / PREPROD CONFIGURATION (UAT 1 )
  // static const String BASE_CHANNEL_URL = "https://mobwebuat1.theblink.com:3443/api";
  // static const String BASE_ROUTER_URL = "https://routuat1.theblink.com:1443/api";
  // static const String BASE_BENEFICIARY_URL = "https://mobwebuat1.theblink.com:3443/contactcenter/api";
  // static const String BASE_EV0UCHER_URL = "https://mobwebuat1.theblink.com:3443/Voucher/api";
  // static const String BASE_OFFER_CAMPAIGN_URL = "https://mobwebuat1.theblink.com:3443/Offers/api";
  // static const String BASE_RJ_URL = "https://mobwebuat1.theblink.com:3443/RJAPI/api";
  // static const String BASE_ONBOARDING_URL = "https://mobwebuat1.theblink.com:3443/Onboarding/api/Onboarding";

  ///VAPT / PREPROD CONFIGURATION (UAT 2 )
// static const String BASE_CHANNEL_URL = "https://mobwebuat2.theblink.com:4443/api";
// static const String BASE_ROUTER_URL = "https://routuat2.theblink.com:2443/api";
// static const String BASE_BENEFICIARY_URL = "https://mobwebuat2.theblink.com:4443/contactcenter/api";
// static const String BASE_EV0UCHER_URL = "https://mobwebuat2.theblink.com:4443/Voucher/api";
// static const String BASE_OFFER_CAMPAIGN_URL = "https://mobwebuat2.theblink.com:4443/Offers/api";
//static const String BASE_RJ_URL = "https://mobwebuat2.theblink.com:4443/RJAPI/api";
//static const String BASE_ONBOARDING_URL = "https://mobwebuat2.theblink.com:4443/Onboarding/api/Onboarding";

  ///PROD CONFIGURATION
// static const String BASE_ROUTER_URL = "https://rout.theblink.com:5443/api";
// static const String BASE_CHANNEL_URL = "https://mobweb.theblink.com:5443/api";
// static const String BASE_BENEFICIARY_URL = "https://mobweb.theblink.com:5443/contactcenter/api";
// static const String BASE_EV0UCHER_URL = "https://mobweb.theblink.com:5443/Voucher/api";
// static const String BASE_OFFER_CAMPAIGN_URL = "https://mobweb.theblink.com:5443/Offers/api";
// static const String BASE_RJ_URL = "https://mobweb.theblink.com:5443/Offers/api";
//static const String BASE_ONBOARDING_URL = "https://mobweb.theblink.com:5443/Onboarding/api/Onboarding";
}
