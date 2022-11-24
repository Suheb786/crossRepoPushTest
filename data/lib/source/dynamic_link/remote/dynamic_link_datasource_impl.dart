import 'package:data/helper/dynamic_link.dart';
import 'package:data/source/dynamic_link/dynamic_link_datasource.dart';

class DynamicLinkDataSourceImpl extends DynamicLinkDataSource {
  final DynamicLinksService _dynamicLinkService;

  DynamicLinkDataSourceImpl(this._dynamicLinkService);

  @override
  Future<String> createDynamicLink(
      {required String accountTitle,
      required String accountNo,
      required String requestAmt,
      required String dateTime}) {
    return _dynamicLinkService.createDynamicLink(
        accountTitle: accountTitle, accountNo: accountNo, requestAmt: requestAmt, dateTime: dateTime);
  }

  @override
  Future<Uri> initDynamicLinks() {
    return _dynamicLinkService.initDynamicLinks();
  }
}
