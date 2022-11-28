import 'package:data/db/exception/app_local_exception.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
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
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    //  final Uri longUrl = await parameters.buildUrl();

    return shortUrl.toString();
  }

  Future<Uri> initDynamicLinks() async {
    Uri? deepLink;
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      Uri? link = dynamicLink?.link;

      debugPrint('-----Get On Link----${link}');

      if (link != null) {
        deepLink = link;
        _initDynamicLinkRequestResponse.add(link);
        debugPrint("----------Account Title${link.queryParameters['accountTitle']}");
      }
    }, onError: (OnLinkErrorException e) async {
      debugPrint("----------On Link Error Exception");
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.NO_DATA_FOUND,
      );
    });

    debugPrint('-----Anything----');

    await Future.delayed(const Duration(seconds: 1));

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    debugPrint('-----Get Initial Url----${data}');
    Uri? deepPendingLink = data?.link;

    if (deepPendingLink != null) {
      deepLink = deepPendingLink;
      _initDynamicLinkRequestResponse.add(deepPendingLink);
      debugPrint("==========>Get Initial Path${deepPendingLink.path}");
      debugPrint("==========>Get Initial${deepPendingLink.queryParameters['accountNo']}");
    }
    return deepLink ?? Uri();
  }
}
