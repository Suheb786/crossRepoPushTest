import 'package:data/db/exception/app_local_exception.dart';
import 'package:data/helper/app_flyer_helper.dart';
import 'package:data/source/app_flyer_source/app_flyer_datasource.dart';

class AppFlyerDataSourceImpl extends AppFlyerDataSource {
  final AppFlyerHelper _appFlyerHelper;

  AppFlyerDataSourceImpl(this._appFlyerHelper);

  @override
  Future<bool> initAppFlyerSdk() async {
    bool? result = await _appFlyerHelper.initSdk();
    if (!result) {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.FAILED_TO_INIT_SDK,
      );
    }

    return result;
  }

  @override
  Future<bool> logAppFlyerEvent({required String eventName, required Map eventValue}) async {
    bool? result = await _appFlyerHelper.logEvent(eventName, eventValue);

    if (!result) {
      throw AppLocalException(
        appLocalExceptionType: AppLocalExceptionType.FAILED_TO_LOG_EVENT,
      );
    }

    return result;
  }
}
