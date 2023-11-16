import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_list.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';

class AppConstantsUtils {
  AppConstantsUtils._();

  static String ONBOARDING_DIGITAL_SERVICE_LINK_UAT = "https://blink.iprox.net/en/digital-banking-services";
  static String CREDIT_CARD_TERMS_CONDITION_LINK_UAT = "https://blink.iprox.net/en/app-terms-and-conditions";

  static String ONBOARDING_DIGITAL_SERVICE_LINK_LIVE = "https://theblink.com/en/digital-banking-services";
  static String CREDIT_CARD_TERMS_CONDITION_LINK_LIVE = "https://theblink.com/en/app-terms-and-conditions";

  static String ONBOARDING_DIGITAL_SERVICE_LINK_LIVE_AR = "https://theblink.com/ar/digital-banking-services";
  static String CREDIT_CARD_TERMS_CONDITION_LINK_LIVE_AR = "https://theblink.com/ar/app-terms-and-conditions";

  static String APP_STORE_URL = "https://apps.apple.com/us/app/the-blink/id1607969058";

  static String PLAY_STORE_URL = "https://play.google.com/store/apps/details?id=com.blink.cbt";

  static String DECRYPTION_KEY = "Htyr3IvDoAhXLg0o";

  static bool isInfobipRegistered = false;

  static bool isApplePayFeatureEnabled = false;

  static String RJRouteLink = 'rj/paymentRequest-redirect';

  static String SELECTED_BILLER_CODE = "";
  static String BILLER_NAME = "";
  static String SELECTED_BILLER_CATEGORY_CODE = "";
  static String SELECTED_BILLER_CATEGORY_TYPE = "";
  static bool SELECTED_BILLING_NUMBER_REQUIRED = true;
  static String SELECTED_SERVICE_CODE = "";
  static String BILLER_CATEGORY = "eCommerce";
  static String BILLER_CATEGORY_ARABIC = "";
  static String BILLER_CATEGORY_API_VALUE = "eCommerce";
  static String BILLER_CATEGORY_ICON_CODE = "101";
  static String SELECTED_AMOUNT = "";
  static String PREPAID_CATEGORY_CODE = "";
  static String PREPAID_CATEGORY_DESCRIPTION = "";
  static String PREPAID_CATEGORY_TYPE = "";
  static String BILLER_TYPE = "";
  static bool IS_NEW_PAYMENT = false;
  static bool IS_NEW_BILL_ADD_API_CALL = false;
  static String SELECTED_BILLING_NUMBER = "";
  static String SELECTED_SERVICE_TYPE = "";
  static String SELECTED_SERVICE_DESCRIPTION_EN = "";
  static String NICK_NAME = "";
  static String ACCOUNT_NUMBER = "";
  static String PREPAID_KEY = "Prepaid";
  static String POSTPAID_KEY = "Postpaid";
  static bool PRE_PAID_FLOW = false;
  static bool POST_PAID_FLOW = false;
  static bool IS_PRE_PAID_CATEGORY_LIST_EMPTY = true;

  /// bill payments
  ///billCategoriesList
  static List<GetBillCategoriesList>? billPostpaidCategoriesCacheList = [];

  static List<GetBillCategoriesList>? billPrepaidCategoriesCacheList = [];

  ///billerDetailsList
  static Map<String, List<BillerDetailsList>?> billerDetailsCacheList =
      Map<String, List<BillerDetailsList>?>();

  static String billerDetailsCacheListKey = "";

  /// reset lists
  static void resetCacheLists() {
    billPostpaidCategoriesCacheList = [];
    billPrepaidCategoriesCacheList = [];
    billerDetailsCacheList = Map<String, List<BillerDetailsList>?>();
    userPromoCode = '';
  }

  static String jodCurrency = 'JOD';
  static String usdCurrency = 'USD';
  static String userPromoCode = "";

  static bool isBiometricDialogShown = false;
}
