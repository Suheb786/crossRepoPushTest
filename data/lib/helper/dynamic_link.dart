import 'package:data/db/exception/app_local_exception.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info/package_info.dart';

class DynamicLinksService {
  Future<String> createDynamicLink({
    required String accountTitle,
    required String accountNo,
    required String requestAmt,
    required String dateTime,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.packageName);
    String uriPrefix = "https://blinkcbt.page.link";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse(
          '${uriPrefix}?accountTitle=${accountTitle}&accountNo=${accountNo}&requestAmt=${requestAmt}&dateTime=${dateTime}'),
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
        minimumVersion: 21,
      ),
      iosParameters: IosParameters(
        bundleId: packageInfo.packageName,
        minimumVersion: packageInfo.version,
        appStoreId: '1607969058',
      ),
    );
    /* final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;*/
    final Uri longUrl = await parameters.buildUrl();

    return longUrl.toString();
  }

  Future<Uri> initDynamicLinks() async {
    Uri? deepLink;
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      Uri? link = dynamicLink?.link;

      if (link != null) {
        deepLink = link;
        print(link.queryParameters['accountTitle']);
      }
    }, onError: (OnLinkErrorException e) async {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.NO_DATA_FOUND,
      );
    });

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    Uri? deepPendingLink = data?.link;

    if (deepPendingLink != null) {
      deepLink = deepPendingLink;
      print(deepPendingLink.queryParameters['accountNo']);
    }
    return deepLink ?? Uri();
  }
}
