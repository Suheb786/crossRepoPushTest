import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/usecase/user/check_version_update_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class OnBoardingViewModel extends BasePageViewModel {
  final CheckVersionUpdateUseCase _checkVersionUpdateUseCase;
  PageController onBoardingPageController = PageController();

  PublishSubject<CheckVersionUpdateUseCaseParams> _checkVersionUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _checkVersionUpdateResponse = PublishSubject();

  Stream<Resource<bool>> get checkVersionUpdateStream => _checkVersionUpdateResponse.stream;

  OnBoardingViewModel(this._checkVersionUpdateUseCase) {
    _checkVersionUpdateRequest.listen((value) {
      RequestManager(value, createCall: () => _checkVersionUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkVersionUpdateResponse.safeAdd(event);
      });
    });
    //checkVersionUpdate();
    SecureStorageHelper.instance.clearToken();
  }

  void checkVersionUpdate({String? clear}) {
    _checkVersionUpdateRequest.safeAdd(CheckVersionUpdateUseCaseParams(clear: clear!));
  }

  @override
  void dispose() {
    _checkVersionUpdateRequest.close();
    _checkVersionUpdateResponse.close();
    super.dispose();
  }
}
