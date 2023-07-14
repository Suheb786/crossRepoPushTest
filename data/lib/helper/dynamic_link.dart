import 'package:data/helper/key_helper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rxdart/rxdart.dart';

class DynamicLinksService {
  PublishSubject<Uri> _initDynamicLinkRequestResponse = PublishSubject();

  Stream<Uri> get initDynamicLinkRequestStream => _initDynamicLinkRequestResponse.stream;

  static DynamicLinksService _instance = DynamicLinksService._();

  DynamicLinksService._();

  factory DynamicLinksService() {
    return _instance;
  }

  Future<String> createDynamicLink({
    required String accountTitle,
    required String accountNo,
    required String requestAmt,
    required String dateTime,
    required String requestId,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String uriPrefix = KeyHelper.DevDynamicLinkPrefix;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('${uriPrefix}/payments?requestId=${requestId}'),
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
        minimumVersion: 21,
      ),
      iosParameters: IOSParameters(
        bundleId: packageInfo.packageName,
        minimumVersion: packageInfo.version,
        appStoreId: '1607969058',
      ),
    );

    final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri shortUrl = shortDynamicLink.shortUrl;
    //  final Uri longUrl = await parameters.buildUrl();

    return shortUrl.toString();
  }

  Future<Uri> initDynamicLinks() async {
    Uri? deepLink;
    // FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
    //   Uri? link = dynamicLink?.link;
    //
    //   debugPrint('-----Get On Link----${link}');
    //
    //   if (link != null) {
    //     deepLink = link;
    //     _initDynamicLinkRequestResponse.add(link);
    //     debugPrint("----------Account Title${link.queryParameters['accountTitle']}");
    //   }
    // }, onError: (OnLinkErrorException e) async {
    //   debugPrint("----------On Link Error Exception");
    //   throw AppLocalException(
    //     appLocalExceptionType: AppLocalExceptionType.NO_DATA_FOUND,
    //   );
    // });

    debugPrint('-----Anything----');

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    debugPrint('-----Get Initial Url----${data}');
    Uri? deepPendingLink = data?.link;

    if (deepPendingLink != null) {
      deepLink = deepPendingLink;
      _initDynamicLinkRequestResponse.add(deepPendingLink);
      debugPrint("==========>Get Initial Path${deepPendingLink.path}");
      debugPrint("==========>Get Initial${deepPendingLink.queryParameters['accountNo']}");
    } else {
      _initDynamicLinkRequestResponse.add(Uri());
    }
    return deepLink ?? Uri();
  }
}
