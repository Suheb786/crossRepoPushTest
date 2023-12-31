import 'package:card_swiper/card_swiper.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
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

  RequestMoneyActivityUseCase _requestMoneyActivityUseCase;

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  Stream<PageController> get pageControllerStream => _pageControllerSubject.stream;

  PublishSubject<GetBeneficiaryUseCaseParams> _getBeneficiaryRequest = PublishSubject();

  BehaviorSubject<Resource<GetBeneficiaryListResponse>> _getBeneficiaryResponse =
      BehaviorSubject.seeded(Resource.success(data: GetBeneficiaryListResponse()));

  List<Beneficiary> smBeneficiaries = [];

  List<Beneficiary> rtpBeneficiaries = [];

  Stream<Resource<GetBeneficiaryListResponse>> get beneficiaryResponse => _getBeneficiaryResponse.stream;

  PublishSubject<RequestMoneyActivityParams> _requestMoneyActivityRequest = PublishSubject();

  BehaviorSubject<Resource<List<RequestMoneyActivityList>>> _paymentActivityListResponse = BehaviorSubject();

  Stream<Resource<List<RequestMoneyActivityList>>> get paymentActivityListStream =>
      _paymentActivityListResponse.stream;

  List<RequestMoneyActivityList> paymentActivityData = [];

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  bool animationInitialized = false;
  late AnimationController translateUpController;
  late Animation<double> translateUpAnimation;

  BehaviorSubject<AnimatedPage> pageSwitchSubject = BehaviorSubject.seeded(AnimatedPage.NULL);

  Stream<AnimatedPage> get pageSwitchStream => pageSwitchSubject.stream;

  late AnimationController translateSidewaysController;

  late Beneficiary selectedBenificiary;

  // (SendAmountToContactPage(settings.arguments as Beneficiary)

  PaymentHomeViewModel(this._getBeneficiaryUseCase, this._requestMoneyActivityUseCase) {
    _getBeneficiaryRequest.listen((value) {
      RequestManager(value, createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getBeneficiaryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          if (value.beneType == "SM") {
            getBeneficiaries(appLevelKey.currentContext!, 'RTP');
          }
          if (value.beneType == "RTP") {
            getRequestMoneyActivity(true, 30, "ALL");
          }
          if ((event.data?.beneficiaryList ?? []).isNotEmpty) {
            if (value.beneType == 'SM') {
              smBeneficiaries.clear();
              event.data?.beneficiaryList?.forEach((element) {
                if (element.beneType == "SM") {
                  smBeneficiaries.add(element);
                }
              });
            }
          }

          if ((event.data?.beneficiaryList ?? []).isNotEmpty) {
            if (value.beneType == 'RTP') {
              rtpBeneficiaries.clear();
              event.data?.beneficiaryList?.forEach((element) {
                if (element.beneType == "RTP") {
                  rtpBeneficiaries.add(element);
                }
              });
            }
          }

          Future.delayed(Duration(milliseconds: 50), () {
            if (appSwiperController.hasClients) appSwiperController.jumpToPage(getInitialNavigation(navigationType, value.context!));

          });
        }
      });
    });

    _requestMoneyActivityRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _requestMoneyActivityUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();

            if (event.status == Status.ERROR) {
              if (event.appError!.type == ErrorType.ERROR_WHILE_REQUESTING_MONEY_ACTIVITY) {
                _paymentActivityListResponse.safeAdd(Resource.success(data: paymentActivityData));
              } else {
                showToastWithError(event.appError!);
              }
            } else if (event.status == Status.SUCCESS) {
              getPaymentActivityList(event.data?.paymentActivityContent ?? []);
            }
          },
        );
      },
    );
  }

  void getRequestMoneyActivity(
    bool getToken,
    int FilterDays,
    String TransactionType,
  ) {
    _requestMoneyActivityRequest.safeAdd(RequestMoneyActivityParams(
        getToken: getToken, FilterDays: FilterDays, TransactionType: TransactionType));
  }

  void getPaymentActivityList(List<PaymentActivityContent> content) {
    paymentActivityData.clear();
    if (content.isNotEmpty) {
      content.forEach((element) {
        element.data!.forEach((e) {
          paymentActivityData.add(e);
        });
      });
    }
    _paymentActivityListResponse.safeAdd(Resource.success(data: paymentActivityData));
  }

  void getBeneficiaries(BuildContext context, String beneType) {
    _getBeneficiaryRequest.safeAdd(GetBeneficiaryUseCaseParams(context: context, beneType: beneType));
  }

  int getInitialNavigation(NavigationType navigationType, BuildContext context) {
    switch (navigationType) {
      case NavigationType.DASHBOARD:
        return 0;
      case NavigationType.SEND_MONEY:
        return 1;
      case NavigationType.REQUEST_MONEY:
      case NavigationType.REQUEST_MONEY:
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

  void animatePage(AnimatedPage animatedPage) {
    if (pageSwitchSubject.value == AnimatedPage.NULL && animatedPage != AnimatedPage.NULL) {
      animateToNewPage();
      pageSwitchSubject.safeAdd(animatedPage);
    } else {
      animateBackToMainPage();
      pageSwitchSubject.safeAdd(AnimatedPage.NULL);
    }
  }

  void animateToNewPage() {
    translateUpController.forward();
    translateSidewaysController.forward();
  }

  void animateBackToMainPage() {
    translateUpController.reverse();
    translateSidewaysController.reverse();
  }

  setSelectedBenificiary(Beneficiary selectedBenificiary) {
    this.selectedBenificiary = selectedBenificiary;
  }

  void animateToRequestMoneyViaQR() {}
}

class PaymentHomeWidgetFeature {
  final PaymentWidgetType paymentWidgetType;
  final bool isEnabled;

  PaymentHomeWidgetFeature({required this.paymentWidgetType, required this.isEnabled});
}

enum PaymentWidgetType { SEND_MONEY, REQUEST_MONEY, POST_PAID_BILL, PRE_PAID_BILL, CLIQ_TRANSACTIONS }

enum AnimatedPage {
  SEND_MONEY,
  REQUEST_MONEY,
  SEND_TO_SPECIFIC_PERSON,
  REQUEST_FROM_SPECIFIC_PERSON,
  PAY_NEW_BILL,
  REQUEST_MONEY_VIA_QR,
  PAYMENT_ACTIVITY,
  NULL
}
