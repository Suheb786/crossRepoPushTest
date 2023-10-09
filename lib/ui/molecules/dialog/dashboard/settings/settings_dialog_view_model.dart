import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/account_setting/get_profile_info/get_profile_info_usecase.dart';
import 'package:domain/usecase/dashboard/refer_dynamic_link_usecase.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SettingsDialogViewModel extends BasePageViewModel {
  final LogoutUseCase _logoutUseCase;
  final GetProfileInfoUseCase _getProfileInfoUseCase;

  ///--------------- current page index response ----------------------///
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  ///--------------- current page index response ----------------------///

  List<PagesWidget> showPages = [];

  ///--------------- profile response ----------------------///
  PublishSubject<GetProfileInfoUseCaseParams> _getProfileInfoRequest = PublishSubject();

  PublishSubject<Resource<ProfileInfoResponse>> _getProfileInfoResponse = PublishSubject();

  Stream<Resource<ProfileInfoResponse>> get getProfileInfoStream => _getProfileInfoResponse.stream;

  void getProfileDetails() {
    _getProfileInfoRequest.safeAdd(GetProfileInfoUseCaseParams());
  }

  ///--------------- profile response ----------------------///

  ///---------------logout response ------------------------///
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();

  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  void logout() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  ///---------------logout response ------------------------///

  ///---------------initial name  -------------------///
  BehaviorSubject<String> _textResponse = BehaviorSubject();

  Stream<String> get textStream => _textResponse.stream;

  ///---------------initial name  -------------------///

  ///-------------------Menu tapped-------------------------///
  final BehaviorSubject<int> _menuTappedIndexSubject = BehaviorSubject.seeded(-1);

  Stream<int> get menuTappedIndexStream => _menuTappedIndexSubject.stream;

  void menuTapped(int value) {
    _menuTappedIndexSubject.safeAdd(value);
  }

  ///this is for tapping effect condition...
  int tappedIndex = -1;

  ///-------------------Menu tapped-------------------------///

  ///------------------initial onclick-----------------------///
  final BehaviorSubject<bool> _onClickSubject = BehaviorSubject.seeded(false);

  Stream<bool> get onClickStream => _onClickSubject.stream;

  void updateOnClickValue(bool) {
    _onClickSubject.safeAdd(bool);
  }

  ///------------------initial onclick-----------------------///

  SettingsDialogViewModel(this._logoutUseCase, this._getProfileInfoUseCase, this._referDynamicLinkUseCase) {
    _logoutRequest.listen((value) {
      RequestManager(value, createCall: () => _logoutUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _logoutResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getProfileInfoRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _getProfileInfoUseCase.execute(params: value),
      ).asFlow().listen((event) {
        //updateLoader();
        _getProfileInfoResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
          updateOnClickValue(false);
        } else if (event.status == Status.SUCCESS) {
          updateOnClickValue(true);
          _textResponse.safeAdd(event.data!.content!.fullName!);
        }
      });
    });

    _referDynamicLinkRequest.listen((value) {
      RequestManager(value, createCall: () => _referDynamicLinkUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //  updateLoader();
        _referDynamicLinkResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getProfileDetails();
  }

  void updateShowPages({required BuildContext context, required List<PagesWidget> pages}) {
    int index = 0;
    showPages.clear();
    pages.forEach((currentPage) {
      var element =
          PagesWidget(key: currentPage.key, child: currentPage.child, index: index, onTap: currentPage.onTap);
      if (element.key == 'CLIQ') {
        if ((ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .dashboardDataContent
                .dashboardFeatures
                ?.blinkRetailAppCliqAliasManagement ??
            false)) {
          index = index + 1;
          showPages.add(element);
        }
      } else if (element.key == 'MANAGE_CONTACTS') {
        if ((ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .dashboardDataContent
                .dashboardFeatures
                ?.manageContactEnabled ??
            false)) {
          index = index + 1;
          showPages.add(element);
        }
      } else if (element.key == 'E-VOUCHERS') {
        if ((ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .dashboardDataContent
                .dashboardFeatures
                ?.eVouchers ??
            false)) {
          index = index + 1;
          showPages.add(element);
        }
      } else if (element.key == 'REFER_A_FRIEND') {
        if ((ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .dashboardDataContent
                .dashboardFeatures
                ?.referrals ??
            false)) {
          index = index + 1;
          showPages.add(element);
        }
      } else if (element.key == 'OFFERS') {
        if ((ProviderScope.containerOf(context)
                    .read(appHomeViewModelProvider)
                    .dashboardDataContent
                    .dashboardFeatures
                    ?.offers ??
                false) &&
            (ProviderScope.containerOf(context).read(appHomeViewModelProvider).listOfOffer.isNotEmpty)) {
          index = index + 1;
          showPages.add(element);
        }
      } else {
        index = index + 1;
        showPages.add(element);
      }
    });
  }

  String getKeyByIndex(int index) {
    String key = '';
    showPages.forEach((element) {
      if (element.index == index) {
        key = element.key;
      }
    });
    return key;
  }

  ///Refer And Earn
  final ReferDynamicLinkUseCase _referDynamicLinkUseCase;
  PublishSubject<ReferDynamicLinkUseCaseParams> _referDynamicLinkRequest = PublishSubject();

  PublishSubject<Resource<String>> _referDynamicLinkResponse = PublishSubject();

  Stream<Resource<String>> get referDynamicLinkStream => _referDynamicLinkResponse.stream;

  getReferCode({required String userPromoCode}) {
    _referDynamicLinkRequest.safeAdd(ReferDynamicLinkUseCaseParams(userPromoCode: userPromoCode));
  }

  @override
  void dispose() {
    _logoutRequest.close();
    _logoutResponse.close();
    _currentStep.close();
    _getProfileInfoRequest.close();
    _getProfileInfoResponse.close();
    _logoutRequest.close();
    _logoutResponse.close();
    _textResponse.close();
    _menuTappedIndexSubject.close();
    _onClickSubject.close();
    super.dispose();
  }
}
