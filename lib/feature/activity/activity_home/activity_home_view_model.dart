import 'package:card_swiper/card_swiper.dart';
import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/activity/activity_content.dart';
import 'package:domain/model/activity/activity_response.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:domain/model/payment/payment_activity_data.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/notification_usecase.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';

class ActivityHomeViewModel extends BasePageViewModel {
  ActivityHomeViewModel(this._paymentActivityTransactionUseCase,
      this._notificationUseCase, this._requestMoneyActivityUseCase) {
    _requestMoneyActivityRequest.listen(
      (value) {
        RequestManager(value,
                createCall: () =>
                    _requestMoneyActivityUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _requestMoneyActivityResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              _requestMoneyActivityResponse.safeAdd(Resource.success(
                  data: RequestMoneyActivity(
                      dummyList))); //Todo : - dummy List remove on error
              // showToastWithError(event.appError!);
            }
          },
        );
      },
    );
//! ------------------------ This Api is deprecated from backend ------------------>>>>>>>>>>>>>>>>
    _paymentActivityTransactionRequest.listen(
      (value) {
        RequestManager(value,
                createCall: () =>
                    _paymentActivityTransactionUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _paymentActivityTransactionResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            } else if (event.status == Status.SUCCESS) {
              getPaymentActivityList(event.data!.paymentActivityContent!);
            }
          },
        );
      },
    );

    ///--------------------------------------------------------------------///
    _notificationRequest.listen(
      (value) {
        RequestManager(value,
                createCall: () => _notificationUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _activityResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            } else if (event.status == Status.SUCCESS) {
              getRequestMoneyActivity(true);
            }
          },
        );
      },
    );

    getActivity();
  }

  PageController appSwiperController = PageController(viewportFraction: 0.8);
  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);

  final SwiperController pageController = SwiperController();
  List<PaymentActivityData> paymentActivityData = [];

  BehaviorSubject<Resource<ActivityResponse>> _activityResponse =
      BehaviorSubject();

  PublishSubject<int> _currentStep = PublishSubject();

  ///activity response
  BehaviorSubject<NotificationUseCaseParams> _notificationRequest =
      BehaviorSubject();

  NotificationUseCase _notificationUseCase;
  PublishSubject<PageController> _pageControllerSubject = PublishSubject();
  BehaviorSubject<Resource<List<PaymentActivityData>>>
      _paymentActivityListResponse = BehaviorSubject();

  ///payment activity transcation
  BehaviorSubject<PaymentActivityTransactionUseCaseParams>
      _paymentActivityTransactionRequest = BehaviorSubject();

  BehaviorSubject<Resource<PaymentActivityResponse>>
      _paymentActivityTransactionResponse = BehaviorSubject();

  PaymentActivityTransactionUseCase _paymentActivityTransactionUseCase;
  //*--------------------[request-money-activity]---------------------->>>>>>>

  BehaviorSubject<RequestMoneyActivityParams> _requestMoneyActivityRequest =
      BehaviorSubject();

  BehaviorSubject<Resource<RequestMoneyActivity>>
      _requestMoneyActivityResponse = BehaviorSubject();

  RequestMoneyActivityUseCase _requestMoneyActivityUseCase;

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }

  Stream<int> get currentStep => _currentStep.stream;

  Stream<PageController> get pageControllerStream =>
      _pageControllerSubject.stream;

  Stream<Resource<PaymentActivityResponse>>
      get paymentActivityTransactionResponse =>
          _paymentActivityTransactionResponse.stream;

  Stream<Resource<RequestMoneyActivity>> get requestMoneyActivity =>
      _requestMoneyActivityResponse.stream;

  void getRequestMoneyActivity(bool getToken) {
    _requestMoneyActivityRequest.safeAdd(RequestMoneyActivityParams(getToken));
  }

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

  Stream<Resource<List<PaymentActivityData>>> get paymentActivityListStream =>
      _paymentActivityListResponse.stream;

  void getPaymentActivity() {
    _paymentActivityTransactionRequest
        .safeAdd(PaymentActivityTransactionUseCaseParams(filterDays: 180));
  }

  void getActivity() {
    _notificationRequest
        .safeAdd(NotificationUseCaseParams(noOfDays: 90, isDebit: "true"));
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
    _paymentActivityListResponse
        .safeAdd(Resource.success(data: paymentActivityData));
  }

//* getting response error for requestMoneyActivity

  List<RequestMoneyActivityList> dummyList = [
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Suheb",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "98435905349805845894538904539804532890",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_PENDING,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Faiz",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "09-0890-8-09",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_ACCEPTED,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Mohammad Suheb",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_EXPIRED,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Mohammad Suheb",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_REJECTED,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
    RequestMoneyActivityList(
      msgID: "",
      trxType: "",
      trxDir: RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING,
      amount: 20.0,
      curr: "",
      svcLvl: "",
      ctgyPurp: "",
      dbtrAgt: "",
      dbtrAcct: "",
      dbtrName: "Mohammad Suheb",
      dbtrAddr: "",
      dbtrIsIndvl: "",
      dbtrRecordID: "",
      dbtrAlias: "",
      dbtrMCC: "",
      cdtrAgt: "",
      cdtrAcct: "",
      cdtrName: "Ahmed Lutfi",
      cdtrAddr: "",
      cdtrIsIndvl: "",
      cdtrRecordID: "",
      cdtrAlias: "",
      cdtrMCC: "",
      instrInfo: "",
      rmtInf: "",
      rgltryRptg: "",
      addInfo1: "",
      addInfo2: "",
      addInfo3: "",
      addInfo4: "",
      trxStatus: RequestMoneyActivityStatusEnum.CATEGORY_REJECTED,
      trxReason: "",
      processFlag: "",
      rtpDate: DateTime.now().toString(),
      statusDate: "",
      payRefNo: "",
      errorCode: 234,
    ),
  ];
}
