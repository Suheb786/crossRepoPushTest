import 'package:card_swiper/card_swiper.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/activity/activity_response.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/notification_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ActivityHomeViewModel extends BasePageViewModel {
  ///--------------- Animated Pages streams ----------------------///

  BehaviorSubject<ActivityAnimatedPage> pageSwitchSubject = BehaviorSubject.seeded(ActivityAnimatedPage.NULL);

  Stream<ActivityAnimatedPage> get pageSwitchStream => pageSwitchSubject.stream;

  late AnimationController translateSidewaysController;
  late AnimationController translateSettingsUpController;

  bool animationInitialized = false;

  ActivityHomeViewModel(this._notificationUseCase, this._requestMoneyActivityUseCase) {
    _requestMoneyActivityRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _requestMoneyActivityUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _requestMoneyActivityResponse.safeAdd(event);

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
//! ------------------------ This Api is deprecated from backend ------------------>>>>>>>>>>>>>>>>
    // _paymentActivityTransactionRequest.listen(
    //   (value) {
    //     RequestManager(value,
    //             createCall: () =>
    //                 _paymentActivityTransactionUseCase.execute(params: value))
    //         .asFlow()
    //         .listen(
    //       (event) {
    //         updateLoader();
    //         _paymentActivityTransactionResponse.safeAdd(event);
    //         if (event.status == Status.ERROR) {
    //           showToastWithError(event.appError!);
    //         } else if (event.status == Status.SUCCESS) {
    //           getPaymentActivityList(event.data!.paymentActivityContent!);
    //         }
    //       },
    //     );
    //   },
    // );

    ///--------------------------------------------------------------------///
    _notificationRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _notificationUseCase.execute(params: value)).asFlow().listen(
          (event) {
            updateLoader();
            _activityResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            } else if (event.status == Status.SUCCESS) {
              getRequestMoneyActivity(true, 30, "ALL");
            }
          },
        );
      },
    );

    //getActivity();
    getRequestMoneyActivity(true, 30, "ALL");
  }

  PageController appSwiperController = PageController(viewportFraction: 0.8);

  List<RequestMoneyActivityList> paymentActivityData = [];

  BehaviorSubject<Resource<ActivityResponse>> _activityResponse = BehaviorSubject();

  PublishSubject<int> _currentStep = PublishSubject();

  ///activity response
  BehaviorSubject<NotificationUseCaseParams> _notificationRequest = BehaviorSubject();

  NotificationUseCase _notificationUseCase;

  BehaviorSubject<Resource<PaymentActivityResponse>> _paymentActivityTransactionResponse = BehaviorSubject();

  //*--------------------[request-money-activity]---------------------->>>>>>>

  PublishSubject<RequestMoneyActivityParams> _requestMoneyActivityRequest = PublishSubject();

  PublishSubject<Resource<PaymentActivityResponse>> _requestMoneyActivityResponse = PublishSubject();

  RequestMoneyActivityUseCase _requestMoneyActivityUseCase;

  @override
  void dispose() {
    _currentStep.close();
    translateSidewaysController.dispose();
    translateSettingsUpController.dispose();
    super.dispose();
  }

  Stream<int> get currentStep => _currentStep.stream;

  Stream<Resource<PaymentActivityResponse>> get paymentActivityTransactionResponse =>
      _paymentActivityTransactionResponse.stream;

  Stream<Resource<PaymentActivityResponse>> get requestMoneyActivity => _requestMoneyActivityResponse.stream;

  void getRequestMoneyActivity(
    bool getToken,
    int FilterDays,
    String TransactionType,
  ) {
    _requestMoneyActivityRequest.safeAdd(RequestMoneyActivityParams(
        getToken: getToken, FilterDays: FilterDays, TransactionType: TransactionType));
  }

  Stream<Resource<ActivityResponse>> get activityResponse => _activityResponse.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void getActivity() {
    _notificationRequest.safeAdd(NotificationUseCaseParams(noOfDays: 90, isDebit: "true"));
  }

  showHideAllTransactionsPage(bool value) {
    if (value) {
      animateToTransactionPage();
    } else {
      animateBackToTransactionPage();
    }
    pageSwitchSubject.add(value ? ActivityAnimatedPage.PAYMENT_ACTIVITY : ActivityAnimatedPage.NULL);
  }

  animateToTransactionPage() {
    translateSidewaysController.forward();
    translateSettingsUpController.forward();
  }

  animateBackToTransactionPage() {
    translateSidewaysController.reverse();
    translateSettingsUpController.reverse();
  }

  ///----------activity filtered list for cards-----------///

  BehaviorSubject<Resource<List<RequestMoneyActivityList>>> _paymentActivityListResponse = BehaviorSubject();

  Stream<Resource<List<RequestMoneyActivityList>>> get paymentActivityListStream =>
      _paymentActivityListResponse.stream;

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

  ///----------activity filtered list for cards-----------///
}

enum ActivityAnimatedPage { PAYMENT_ACTIVITY, NULL }
