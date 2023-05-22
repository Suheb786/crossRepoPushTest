import 'package:card_swiper/card_swiper.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/usecase/manage_contacts/get_beneficiary_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaymentHomeViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  NavigationType navigationType = NavigationType.DASHBOARD;

  PageController appSwiperController = PageController(viewportFraction: 0.8);

  GetBeneficiaryUseCase _getBeneficiaryUseCase;

  PageController controller = PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  Stream<PageController> get pageControllerStream => _pageControllerSubject.stream;

  PublishSubject<GetBeneficiaryUseCaseParams> _getBeneficiaryRequest = PublishSubject();

  BehaviorSubject<Resource<GetBeneficiaryListResponse>> _getBeneficiaryResponse = BehaviorSubject();

  List<Beneficiary> smBeneficiaries = [];

  List<Beneficiary> rtpBeneficiaries = [];

  Stream<Resource<GetBeneficiaryListResponse>> get beneficiaryResponse => _getBeneficiaryResponse.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    controller = PageController(initialPage: index, viewportFraction: 0.8, keepPage: true);
    _pageControllerSubject.safeAdd(controller);
  }

  PaymentHomeViewModel(this._getBeneficiaryUseCase) {
    _getBeneficiaryRequest.listen((value) {
      RequestManager(value, createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        print("in add request money constructor");
        updateLoader();
        _getBeneficiaryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          smBeneficiaries = [];
          rtpBeneficiaries = [];
          event.data!.beneficiaryList!.forEach((element) {
            if (element.beneType == "SM") {
              smBeneficiaries.add(element);
            }
          });
          print("got smBeneficiaries: ${smBeneficiaries.length}");
          event.data!.beneficiaryList!.forEach((element) {
            if (element.beneType == "RTP") {
              rtpBeneficiaries.add(element);
            }
          });

          Future.delayed(Duration(milliseconds: 50), () {
            if (appSwiperController.hasClients)
              appSwiperController.jumpToPage(getInitialNavigation(navigationType, value.context!));
          });
        }
      });
    });
  }

  void getBeneficiaries(BuildContext context) {
    _getBeneficiaryRequest.safeAdd(GetBeneficiaryUseCaseParams(context: context));
  }

  int getInitialNavigation(NavigationType navigationType, BuildContext context) {
    switch (navigationType) {
      case NavigationType.DASHBOARD:
        return 0;
      case NavigationType.ADD_MONEY:
        return 1;
      case NavigationType.PAYMENTS:
      case NavigationType.PAYMENTS:
        if (ProviderScope.containerOf(appLevelKey.currentContext!)
                .read(appHomeViewModelProvider)
                .dashboardDataContent
                .dashboardFeatures
                ?.blinkRetailAppBillPayment ??
            true) {
          if ((ProviderScope.containerOf(appLevelKey.currentContext!)
                      .read(appHomeViewModelProvider)
                      .dashboardDataContent
                      .dashboardFeatures
                      ?.appBillPaymentPostpaid ??
                  true) ||
              (ProviderScope.containerOf(appLevelKey.currentContext!)
                      .read(appHomeViewModelProvider)
                      .dashboardDataContent
                      .dashboardFeatures
                      ?.appBillPaymentPrepaid ??
                  true)) {
            return 2;
          }
        }
        return 0;
    }
  }

  List<PaymentHomeWidgetFeature> paymentWidgetTypeFeature = [];

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}

class PaymentHomeWidgetFeature {
  final PaymentWidgetType paymentWidgetType;
  final bool isEnabled;

  PaymentHomeWidgetFeature({required this.paymentWidgetType, required this.isEnabled});
}

enum PaymentWidgetType { SEND_MONEY, REQUEST_MONEY, POST_PAID_BILL, PRE_PAID_BILL }
