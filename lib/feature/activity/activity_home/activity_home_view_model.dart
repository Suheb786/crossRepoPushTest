import 'package:card_swiper/card_swiper.dart';
import 'package:domain/model/activity/activity_response.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/notification_usecase.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ActivityHomeViewModel extends BasePageViewModel {
  PaymentActivityTransactionUseCase _paymentActivityTransactionUseCase;

  NotificationUseCase _notificationUseCase;

  final SwiperController pageController = SwiperController();
  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  Stream<PageController> get pageControllerStream =>
      _pageControllerSubject.stream;

  ///payment activity transcation
  BehaviorSubject<PaymentActivityTransactionUseCaseParams>
      _paymentActivityTransactionRequest = BehaviorSubject();

  BehaviorSubject<Resource<PaymentActivityResponse>>
      _paymentActivityTransactionResponse = BehaviorSubject();

  Stream<Resource<PaymentActivityResponse>>
      get paymentActivityTransactionResponse =>
          _paymentActivityTransactionResponse.stream;

  ///activity response
  BehaviorSubject<NotificationUseCaseParams> _notificationRequest =
      BehaviorSubject();

  BehaviorSubject<Resource<ActivityResponse>> _activityResponse =
      BehaviorSubject();

  Stream<Resource<ActivityResponse>> get activityResponse =>
      _activityResponse.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    controller = PageController(
        initialPage: index, viewportFraction: 0.8, keepPage: true);
    _pageControllerSubject.safeAdd(controller);
  }

  ActivityHomeViewModel(
      this._paymentActivityTransactionUseCase, this._notificationUseCase) {
    _paymentActivityTransactionRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _paymentActivityTransactionUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _paymentActivityTransactionResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _notificationRequest.listen((value) {
      RequestManager(value,
              createCall: () => _notificationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _activityResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          getPaymentActivity();
        }
      });
    });

    getActivity();
  }

  void getPaymentActivity() {
    _paymentActivityTransactionRequest
        .safeAdd(PaymentActivityTransactionUseCaseParams());
  }

  void getActivity() {
    _notificationRequest
        .safeAdd(NotificationUseCaseParams(noOfDays: 90, isDebit: "true"));
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
