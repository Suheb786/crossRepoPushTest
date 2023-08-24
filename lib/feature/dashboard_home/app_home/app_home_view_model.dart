import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:card_swiper/card_swiper.dart';
import 'package:data/helper/dynamic_link.dart';
import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/enum/credit_card_call_status_enum.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/constants/enum/primary_secondary_card_enum.dart';
import 'package:domain/constants/enum/primary_secondary_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:domain/model/dashboard/get_placeholder/placeholder_data.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/apple_pay/get_antelop_cards_list_usecase.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:domain/usecase/dashboard/get_placeholder_usecase.dart';
import 'package:domain/usecase/dynamic_link/init_dynamic_link_usecase.dart';
import 'package:domain/usecase/payment/verify_qr_usecase.dart';
import 'package:domain/usecase/user/get_current_user_usecase.dart';
import 'package:domain/usecase/user/save_user_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_page.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/ui/molecules/card/apply_credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/apply_debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_issuance_failure_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_not_delivered_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/debit_card_error_widget.dart';
import 'package:neo_bank/ui/molecules/card/debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/dormant_account_debit_card_disbaled_widget.dart';
import 'package:neo_bank/ui/molecules/card/get_credit_card_now_widget.dart';
import 'package:neo_bank/ui/molecules/card/resume_credit_card_application_view.dart';
import 'package:neo_bank/ui/molecules/card/rj_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/verify_credit_card_videocall_widget.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../account_transaction/account_transaction_page.dart';
import '../card_transaction/card_transaction_page.dart';

class AppHomeViewModel extends BasePageViewModel {
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final VerifyQRUseCase _verifyQRUseCase;
  Timer? timer;
  final GetPlaceholderUseCase _getPlaceholderUseCase;

  final GetAntelopCardsListUseCase _getAntelopCardsListUseCase;

  final InitDynamicLinkUseCase _initDynamicLinkUseCase;

  ///Init Dynamic links
  PublishSubject<InitDynamicLinkUseCaseParams> _initDynamicLinkRequestRequest = PublishSubject();

  final SwiperController pageController = SwiperController();

  PageController appSwiperController = PageController(viewportFraction: 0.8);

  BehaviorSubject<int> _currentStep = BehaviorSubject();

  Stream<int> get currentStep => _currentStep.stream;

  ///Timeline Arguments
  PublishSubject<bool> _showTimeLineSubject = PublishSubject();

  Stream<bool> get showTimeLineStream => _showTimeLineSubject.stream;

  BehaviorSubject<bool> _showRequestMoneyPopUpSubject = BehaviorSubject.seeded(false);

  bool isShowBalenceUpdatedToast = false;

  CardType cardType = CardType.DEBIT;

  ChangeCardPinArguments changeCardPinArguments = ChangeCardPinArguments();

  CreditCard currentCreditCard = CreditCard();

  GetDashboardDataContent dashboardDataContent = GetDashboardDataContent();

  /// ------------------------------Request money pop-up------------------///
  PublishSubject<bool> _requestMoneyPopUpResponse = PublishSubject();

  PublishSubject<bool> _requestMoneyRequest = PublishSubject();

  Stream<bool> get getRequestMoneyPopUpDataStream => _requestMoneyPopUpResponse.stream;

  /// ------------------------------Request money pop-up------------------///

  ///------------------------------dashboard card data response ------------------///
  BehaviorSubject<GetDashboardDataContent> _dashboardCardResponse =
      BehaviorSubject.seeded(GetDashboardDataContent());

  Stream<GetDashboardDataContent> get getDashboardCardDataStream => _dashboardCardResponse.stream;

  PublishSubject<GetDashboardDataUseCaseParams> _getDashboardDataRequest = PublishSubject();

  PublishSubject<Resource<GetDashboardDataResponse>> _getDashboardDataResponse = PublishSubject();

  Stream<Resource<GetDashboardDataResponse>> get getDashboardDataStream => _getDashboardDataResponse.stream;

  ///------------------------------dashboard card data response ------------------///

  Size deviceSize = Size(0, 0);

  ///pages response
  BehaviorSubject<List> _pagesResponseSubject = BehaviorSubject();

  ///pages response stream
  Stream<List> get pageStream => _pagesResponseSubject.stream;

  List pages = [];

  List<TimeLineSwipeUpArgs> cardTypeList = [];

  TimeLineArguments timeLineArguments = TimeLineArguments(timelineListArguments: []);

  List<TimeLineListArguments> timeLineListArguments = [];
  List<TimeLineListArguments> blinkTimeLineListArguments = [];

  ///subscription pop up stream
  PublishSubject<bool> _showSubSubscriptionPopUpStream = PublishSubject();

  Stream<bool> get showSubSubscriptionPopUpStream => _showSubSubscriptionPopUpStream.stream;

  /// get placeholder request

  PublishSubject<GetPlaceholderUseCaseParams> _getPlaceHolderRequest = PublishSubject();

  BehaviorSubject<Resource<GetPlaceholderResponse>> _getPlaceHolderResponse = BehaviorSubject();

  Stream<Resource<GetPlaceholderResponse>> get getPlaceHolderStream => _getPlaceHolderResponse.stream;

  PlaceholderData timelinePlaceholderData = PlaceholderData();

  /// get request money placeholder request
  PublishSubject<GetPlaceholderUseCaseParams> _getRequestMoneyPlaceHolderRequest = PublishSubject();

  BehaviorSubject<Resource<GetPlaceholderResponse>> _getRequestMoneyPlaceHolderResponse = BehaviorSubject();

  Stream<Resource<GetPlaceholderResponse>> get getRequestMoneyPlaceHolderStream =>
      _getRequestMoneyPlaceHolderResponse.stream;

  PlaceholderData requestMoneyPlaceholderData = PlaceholderData();

  ///Completed debit and credit cards
  List<DebitCard> debitCards = [];
  List<CreditCard> creditCards = [];

  ///--------Get current user ---------///

  final PublishSubject<GetCurrentUserUseCaseParams> _currentUserRequestSubject = PublishSubject();

  final PublishSubject<Resource<User>> _currentUserResponseSubject = PublishSubject();

  Stream<Resource<User>> get currentUser => _currentUserResponseSubject.stream;

  void getCurrentUser() {
    _currentUserRequestSubject.add(GetCurrentUserUseCaseParams());
  }

  ///--------Get current user ---------///

  ///--------Save current user ---------///

  final PublishSubject<SaveUserDataUseCaseParams> _saveCurrentUserRequestSubject = PublishSubject();

  final PublishSubject<Resource<User>> _saveCurrentUserResponseSubject = PublishSubject();

  Stream<Resource<User>> get saveCurrentUser => _saveCurrentUserResponseSubject.stream;

  void saveCurrentUserData({required User user}) {
    _saveCurrentUserRequestSubject.add(SaveUserDataUseCaseParams(user: user));
  }

  ///--------Save current user ---------///

  ///---------------Verify QR----------------------///
  PublishSubject<VerifyQRUseCaseParams> _verifyQRRequest = PublishSubject();

  PublishSubject<Resource<VerifyQrResponse>> _verifyQRResponse = PublishSubject();

  Stream<Resource<VerifyQrResponse>> get verifyQRStream => _verifyQRResponse.stream;

  void verifyQR({required String requestId}) {
    _verifyQRRequest.safeAdd(VerifyQRUseCaseParams(requestId: requestId, source: 'L'));
  }

  ///---------------Verify QR----------------------///

  bool showPopUp = false;

  ///--------------- Animations ----------------------///

  late AnimationController translateSidewaysController;
  late AnimationController scaleAnimationController;
  late AnimationController translateTimelineDownController;
  late AnimationController translateSettingsUpController;
  late AnimationController translateAccountSettingsUpController;
  late Animation<double> settingsAnimation;
  late Animation<double> accountSettingsAnimation;

  late AnimationController zoomController;
  late Animation<double> zoomAnimation;

  late ScrollController timelineScrollController;

  ///--------------- Animated Pages streams ----------------------///

  BehaviorSubject<DashboardAnimatedPage> pageSwitchSubject =
      BehaviorSubject.seeded(DashboardAnimatedPage.NULL);

  Stream<DashboardAnimatedPage> get pageSwitchStream => pageSwitchSubject.stream;

  bool isMyAccount(int index) {
    return cardTypeList[index].cardType == CardType.ACCOUNT;
  }

  bool isCreditCard(int index) {
    return cardTypeList[index].cardType == CardType.CREDIT;
  }

  bool isDebitCard(int index) {
    return cardTypeList[index].cardType == CardType.DEBIT;
  }

  ///--------------- Some Other params that i will name later on  ----------------------///
  DebitCard? selectedDebitCard;
  CreditCard? selectedCreditCard;
  bool firstTime = true;
  bool animationInitialized = false;

  ///--------------- Credit card settings params  ----------------------///

  bool creditCardIsFreezed = false;
  bool creditCardIsUnFreezed = false;
  bool creditCardIsCancelled = false;

  ///--------------- Debit card settings params  ----------------------///

  bool debitCardIsFreezed = false;
  bool debitCardIsUnFreezed = false;
  bool debitCardIsCancelled = false;
  bool debitCardLostStolenReported = false;
  bool debitCardIsReportDamagedCard = false;
  bool debitCardRemoveOrReapply = false;

  bool isSmallDevices = false;

  AppHomeViewModel(
      this._getDashboardDataUseCase,
      this._getPlaceholderUseCase,
      this._initDynamicLinkUseCase,
      this._getCurrentUserUseCase,
      this._saveUserDataUseCase,
      this._verifyQRUseCase,
      this._getAntelopCardsListUseCase) {
    isShowBalenceUpdatedToast = false;
    deviceSize = MediaQuery.of(appLevelKey.currentContext!).size;
    isSmallDevices = deviceSize.height < ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
        deviceSize.height < ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
    _getDashboardDataRequest.listen((value) {
      RequestManager(value, createCall: () => _getDashboardDataUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getDashboardDataResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          getTimelinePlaceholder();
          if (isShowBalenceUpdatedToast) {
            showSuccessToast("Your account balance is successfully updated.");
            isShowBalenceUpdatedToast = false;
          }
          dashboardDataContent = event.data!.dashboardDataContent!;
          _dashboardCardResponse.safeAdd(event.data!.dashboardDataContent);
          getDashboardPages(event.data!.dashboardDataContent!);
        }
      });
    });

    _getPlaceHolderRequest.listen((value) {
      RequestManager(value, createCall: () => _getPlaceholderUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getPlaceHolderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          triggerRequestMoneyPopup();

          ///fetching antelop cards
          initDynamicLink();
          timeLineArguments.placeholderData = timelinePlaceholderData;
        } else if (event.status == Status.SUCCESS) {
          ///fetching antelop cards
          triggerRequestMoneyPopup();
          initDynamicLink();
          timelinePlaceholderData = event.data!.data!;
          timeLineArguments.placeholderData = event.data!.data;
        }
      });
    });

    _getRequestMoneyPlaceHolderRequest.listen((value) {
      RequestManager(value, createCall: () => _getPlaceholderUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getRequestMoneyPlaceHolderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
        } else if (event.status == Status.SUCCESS) {
          showRequestMoneyPopUp(false);
          if (event.data!.data!.status ?? false) {
            requestMoneyPlaceholderData = event.data!.data!;
            _requestMoneyRequest.safeAdd(true);
          }
        }
      });
    });

    _antelopGetCardsRequest.listen(
      (params) {
        RequestManager(params, createCall: () => _getAntelopCardsListUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          _antelopGetCardResponse.safeAdd(event);
        });
      },
    );

    ///talabat placeholder
    // _sentMoneyRequest.listen((value) {
    //   _sentMoneyPopUpResponse.safeAdd(value);
    // });

    _requestMoneyRequest.listen((value) {
      _requestMoneyPopUpResponse.safeAdd(value);
    });

    _initDynamicLinkRequestRequest.listen((value) {
      RequestManager(value, createCall: () => _initDynamicLinkUseCase.execute(params: value))
          .asFlow()
          .listen((event) {});
    });

    _currentUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _getCurrentUserUseCase.execute(params: value);
      }).asFlow().listen((event) async {
        _currentUserResponseSubject.add(event);
      });
    });

    _saveCurrentUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _saveUserDataUseCase.execute(params: value);
      }).asFlow().listen((event) async {
        updateLoader();
        _saveCurrentUserResponseSubject.add(event);
      });
    });

    _verifyQRRequest.listen((value) {
      RequestManager(value, createCall: () => _verifyQRUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyQRResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getDashboardData();
  }

  showPopUps() {
    if (!showPopUp) {
      showPopUp = true;
      getCurrentUser();

      ///show apple pay pop up button
      if (!AppConstantsUtils.isApplePayPopUpShown) {
        showApplePayPopUp(true);
        AppConstantsUtils.isApplePayPopUpShown = true;
      }
    }
  }

  void getDashboardPages(GetDashboardDataContent dashboardDataContent) {
    pages.clear();
    timeLineListArguments.clear();
    blinkTimeLineListArguments.clear();
    debitCards.clear();
    creditCards.clear();
    cardTypeList.clear();

    pages.add(MyAccountPage(account: dashboardDataContent.account!));
    cardTypeList.add(TimeLineSwipeUpArgs(
        cardType: CardType.ACCOUNT,
        swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES,
        timeLineEnum: TimeLineEnum.TIMELINE_YES));

    ///setting timeline arguments value start
    timeLineArguments.availableBalance = dashboardDataContent.account!.availableBalance ?? '0.000';
    timeLineArguments.blinkWasBorn = dashboardDataContent.blinkWasBorn.toString();
    timeLineArguments.youJoinedBlink = dashboardDataContent.youJoinedBlink.toString();

    ///end

    if (dashboardDataContent.somethingWrong ?? false) {
      pages.add(CreditCardIssuanceFailureWidget(
        isSmallDevices: isSmallDevices,
        type: IssuanceType.failure,
      ));

      ///adding cardType
      cardTypeList.add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
    } else {
      if (dashboardDataContent.creditCard!.length > 0) {
        dashboardDataContent.creditCard!.forEach((creditCard) {
          if (creditCard.isCompleted ?? false) {
            if (creditCard.isCreditDelivered ?? false) {
              pages.add(CreditCardWidget(
                accountBalance: dashboardDataContent.account!.availableBalance,
                creditCard: creditCard,
                isChangePinEnabled: dashboardDataContent.dashboardFeatures?.isPinChangeEnabled ?? true,
                key: ValueKey('credit${creditCard.cardCode}${creditCard.cvv}'),
                onPayBackClick: () {
                  selectedCreditCard = creditCard;
                  goToPayBackView(true);
                },
                onSettingsTap: () {
                  selectedCreditCard = creditCard;
                  selectedDebitCard = null;
                  showSettingPage(true);
                },
              ));

              ///time line list  arguments set
              timeLineListArguments.add(TimeLineListArguments(
                  cardCardActivated: creditCard.creditCardActivatedDate ?? '',
                  cardDeliveredDatetime: creditCard.creditDeliveredDatetime ?? '',
                  cardId: creditCard.cardId ?? '',
                  cardNumber: creditCard.cardNumber ?? '',
                  accountTitle: creditCard.name ?? '',
                  cardType: CardType.CREDIT,
                  isCardDelivered: creditCard.isCreditDelivered,
                  secureCode: creditCard.cardCode,
                  isIssuedFromCMS: creditCard.issuedFromCms));

              ///adding cardType
              cardTypeList.add(TimeLineSwipeUpArgs(
                  cardType: CardType.CREDIT,
                  swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES,
                  timeLineEnum: TimeLineEnum.TIMELINE_YES));
              creditCards.add(creditCard);
            } else {
              pages.add(CreditCardNotDeliveredWidget(
                isSmallDevice: isSmallDevices,
                creditCard: creditCard,
                isChangePinEnabled: dashboardDataContent.dashboardFeatures?.isPinChangeEnabled ?? true,
                key: ValueKey('credit${creditCard.cardCode}${creditCard.cvv}'),
                onSettingsTap: () {
                  selectedCreditCard = creditCard;
                  selectedDebitCard = null;
                  showSettingPage(true);
                },
              ));

              ///time line list  arguments set
              timeLineListArguments.add(TimeLineListArguments(
                  cardCardActivated: creditCard.creditCardActivatedDate ?? '',
                  cardDeliveredDatetime: creditCard.creditDeliveredDatetime ?? '',
                  cardId: creditCard.cardId ?? '',
                  cardNumber: creditCard.cardNumber ?? '',
                  accountTitle: creditCard.name ?? '',
                  cardType: CardType.CREDIT,
                  isCardDelivered: creditCard.isCreditDelivered,
                  secureCode: creditCard.cardCode,
                  isIssuedFromCMS: creditCard.issuedFromCms));

              ///adding cardType
              cardTypeList
                  .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
            }
          } else {
            if (!(dashboardDataContent.dashboardFeatures?.isCreditCardFeatureEnabled ?? false)) {
              pages.add(CreditCardIssuanceFailureWidget(
                isSmallDevices: isSmallDevices,
                type: IssuanceType.service_unavailable,
              ));

              ///adding cardType
              cardTypeList
                  .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
            } else {
              if (creditCard.primarySecondaryCard == PrimarySecondaryCardEnum.SECONDARY) {
              } else {
                switch (creditCard.callStatus) {
                  case CreditCardCallStatusEnum.APPROVED:
                    pages.add(GetCreditCardNowWidget(
                      isSmallDevices: isSmallDevices,
                      key: ValueKey('credit#GetCreditCardNowWidget#'),
                    ));
                    cardTypeList.add(
                        TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                    break;

                  case CreditCardCallStatusEnum.DROP:
                  case CreditCardCallStatusEnum.CALL_NOT_RECEIVED:
                    pages.add(VerifyCreditCardVideoCallWidget(
                      isSmallDevices: isSmallDevices,
                      creditCard: creditCard,
                    ));

                    ///adding cardType
                    cardTypeList.add(
                        TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                    break;

                  case CreditCardCallStatusEnum.REJECTED:
                    break;

                  default:
                    pages.add(ResumeCreditCardApplicationView(
                      isSmallDevices: isSmallDevices,
                    ));

                    ///adding cardType
                    cardTypeList.add(
                        TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                }
              }
            }
          }
        });
      } else {
        if (!(dashboardDataContent.dashboardFeatures?.isCreditCardFeatureEnabled ?? false)) {
          pages.add(CreditCardIssuanceFailureWidget(
            isSmallDevices: isSmallDevices,
            type: IssuanceType.service_unavailable,
          ));

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
        } else {
          pages.add(ApplyCreditCardWidget(
            isSmallDevices: isSmallDevices,
          ));

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
        }
      }
    }

    if (dashboardDataContent.debitCardSomethingWrong ?? false) {
      pages.add(DebitCardErrorWidget(
        isSmallDevices: isSmallDevices,
      ));

      ///adding cardType
      cardTypeList.add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
    } else {
      if (dashboardDataContent.debitCard!.length > 0) {
        checkIfDebitCardThere(dashboardDataContent.debitCard);
        dashboardDataContent.debitCard!.forEach((debitCard) {
          if (debitCard.cardStatus == FreezeCardStatusEnum.L) {
            if (!(debitCard.isPINSet ?? true)) {
              if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
                ///Dormant account widget
                pages.add(DormantAccountDebitCardDisabledWidget());

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              } else {
                pages.add(ApplyDebitCardWidget(
                  debitRoutes: DebitRoutes.DASHBOARD,
                  isSmallDevice: isSmallDevices,
                  isPinSet: debitCard.isPINSet!,
                  cardHolderName: debitCard.accountTitle ?? '',
                  cardNo: debitCard.cardNumber ?? '',
                  primarySecondaryEnum: debitCard.primarySecondaryCard ?? PrimarySecondaryEnum.PRIMARY,
                ));

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            } else {
              if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
                ///Dormant account widget
                pages.add(DormantAccountDebitCardDisabledWidget());

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              } else {
                pages.add(ApplyDebitCardWidget(
                  debitRoutes: DebitRoutes.DASHBOARD,
                  isSmallDevice: isSmallDevices,
                  isPinSet: true,
                  cardHolderName: debitCard.accountTitle ?? '',
                  cardNo: debitCard.cardNumber ?? '',
                  primarySecondaryEnum: debitCard.primarySecondaryCard ?? PrimarySecondaryEnum.PRIMARY,
                ));

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            }
          } else {
            if (!(debitCard.isPINSet ?? true)) {
              if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
                ///Dormant account widget
                pages.add(DormantAccountDebitCardDisabledWidget());

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              } else {
                pages.add(ApplyDebitCardWidget(
                  debitRoutes: DebitRoutes.DASHBOARD,
                  isSmallDevice: isSmallDevices,
                  isPinSet: debitCard.isPINSet!,
                  cardHolderName: debitCard.accountTitle ?? '',
                  cardNo: debitCard.cardNumber ?? '',
                  primarySecondaryEnum: debitCard.primarySecondaryCard ?? PrimarySecondaryEnum.PRIMARY,
                ));

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            } else {
              pages.add(DebitCardWidget(
                accountStatusEnum: dashboardDataContent.account?.accountStatusEnum ?? AccountStatusEnum.NONE,
                isPrimaryDebitCard: isPrimaryDebitCard,
                isSmallDevice: isSmallDevices,
                key: ValueKey('debit${debitCard.code}${debitCard.cvv}'),
                debitCard: debitCard,
                isDebitCardRequestPhysicalCardEnabled:
                    dashboardDataContent.dashboardFeatures?.isDebitCardRequestPhysicalCardEnabled ?? false,
                onSettingsClick: () {
                  /// showing settings page....
                  selectedDebitCard = debitCard;
                  selectedCreditCard = null;
                  showSettingPage(true);
                },
              ));

              ///time line list arguments set
              timeLineListArguments.add(TimeLineListArguments(
                  cardCardActivated: debitCard.debitCardActivated.toString(),
                  cardDeliveredDatetime: debitCard.debitDeliveredDatetime.toString(),
                  cardId: '',
                  cardNumber: debitCard.cardNumber ?? '',
                  accountTitle: debitCard.accountTitle ?? '',
                  cardType: CardType.DEBIT,
                  isCardDelivered: debitCard.isDebitDelivered,
                  secureCode: debitCard.cardCode));

              ///adding cardType
              cardTypeList.add(TimeLineSwipeUpArgs(
                  cardType: CardType.DEBIT,
                  swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO,
                  timeLineEnum: TimeLineEnum.TIMELINE_YES));

              debitCards.add(debitCard);
            }
          }
        });
      } else {
        if (dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
          ///Dormant account widget
          pages.add(DormantAccountDebitCardDisabledWidget());

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
        } else {
          pages.add(ApplyDebitCardWidget(
            debitRoutes: DebitRoutes.DASHBOARD,
            isSmallDevice: isSmallDevices,
            isPinSet: true,
            primarySecondaryEnum: PrimarySecondaryEnum.PRIMARY,
          ));

          ///adding cardType
          cardTypeList
              .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
        }
      }
    }

    /// adding rj card pages
    if ((dashboardDataContent.dashboardFeatures?.isRJFeatureEnabled ?? true)) {
      pages.add(RjCardWidget());

      cardTypeList.add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
    }
    addPages(pages);
    blinkTimeLineListArguments.addAll(timeLineListArguments);
    timeLineArguments.timelineListArguments = blinkTimeLineListArguments;
    sortTimeLineArgumentsList();

    /// get Antelop Cards
    if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
      getAntelopCards();
    }
  }

  void addPages(List pagesList) {
    _pagesResponseSubject.safeAdd(pagesList);
  }

  void nextPage() {
    appSwiperController.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void moveToPage(int index) {
    appSwiperController.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.linear);
  }

  List<Widget> buildPageIndicator(int currentPage, int totalPage) {
    List<Widget> list = [];
    for (int i = 0; i < pages.length; i++) {
      list.add(i == currentPage ? indicator(true, i, currentPage) : indicator(false, i, currentPage));
    }
    return list;
  }

  bool isPrimaryDebitCard = true;

  checkIfDebitCardThere(List<DebitCard>? debitCards) {
    if (debitCards!.isNotEmpty) {
      DebitCard debitCard = debitCards.firstWhere(
          (debit) => debit.primarySecondaryCard == PrimarySecondaryEnum.PRIMARY,
          orElse: () => DebitCard());
      if (debitCard.cardNumber != null) {
        isPrimaryDebitCard = true;
      } else {
        isPrimaryDebitCard = false;
      }
    }
  }

  Widget indicator(bool isActive, int i, int currentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: getIndicatorSize(isActive, i, currentPage),
      width: getIndicatorSize(isActive, i, currentPage),
      decoration: BoxDecoration(
        color: getColor(isActive, i),
        shape: BoxShape.circle,
      ),
    );
  }

  void sortTimeLineArgumentsList() {
    if (blinkTimeLineListArguments.isNotEmpty) {
      ///sorting in descending order
      blinkTimeLineListArguments.sort((a, b) {
        return DateTime.parse(b.cardCardActivated ?? DateTime.now().toString())
            .compareTo(DateTime.parse(a.cardCardActivated ?? DateTime.now().toString()));
      });
    }
  }

  Color getColor(bool isActive, int i) {
    if (isActive) {
      return Colors.black;
    } else {
      return Color(0xFFA9A9A9);
    }
  }

  double getIndicatorSize(bool isActive, int i, int currentPage) {
    if (isActive) {
      return 7.0;
    } else if ((i == 0 || i == pages.length - 1) && !isActive) {
      return 5.0;
    }
    return 5.0;
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    _currentStep.safeAdd(index);
  }

  void updateAppSwipeControllerStream(int index) {
    appSwiperController = PageController(
      viewportFraction: 0.90,
      initialPage: index,
    );
    _currentStep.safeAdd(index);
  }

  void updateShowTimeLineStream(bool value) {
    _showTimeLineSubject.add(value);
  }

  void getDashboardData() {
    _getDashboardDataRequest.safeAdd(GetDashboardDataUseCaseParams());
  }

  void balenceUpdate() {
    isShowBalenceUpdatedToast = true;
    _getDashboardDataRequest.safeAdd(GetDashboardDataUseCaseParams());
  }

  ///request money timeline placeholder
  void triggerRequestMoneyPopup() {
    if (_showRequestMoneyPopUpSubject.value) {
      _getRequestMoneyPlaceHolderRequest.safeAdd(GetPlaceholderUseCaseParams(placeholderId: 4));
    }
  }

  void triggerSubscriptionPopUp() {
    _showSubSubscriptionPopUpStream.safeAdd(true);
  }

  ///timeline placeholder
  void getTimelinePlaceholder() {
    _getPlaceHolderRequest.safeAdd(GetPlaceholderUseCaseParams(placeholderId: 5));
  }

  void showRequestMoneyPopUp(bool value) {
    _showRequestMoneyPopUpSubject.safeAdd(value);
  }

  bool isLinkOpened = false;

  initDynamicLink() async {
    Uri uri = await DynamicLinksService().initDynamicLinks();
    verifyQRData(uri: uri);
  }

  onResumeDynamicLink() {
    isLinkOpened = false;
    DynamicLinksService().onLink().distinct().listen((event) async {
      if (!isLinkOpened) {
        verifyQRData(uri: event.link);
      }
    });
  }

  void verifyQRData({required Uri uri}) {
    if (uri.path.isNotEmpty && uri.queryParameters.isNotEmpty) {
      isLinkOpened = true;
      var requestId = uri.queryParameters['requestId']?.replaceAll(' ', '+');
      verifyQR(requestId: requestId ?? '');
    } else {
      showPopUps();
    }
  }

  ///--------------------Antelop Cards List-----------------///
  PublishSubject<GetAntelopCardsListUseCaseParams> _antelopGetCardsRequest = PublishSubject();

  PublishSubject<Resource<bool>> _antelopGetCardResponse = PublishSubject();

  // isolates
  late ReceivePort receivePort;
  Isolate? isolate;

  void getAntelopCards() async {
    debugPrint("Enter in get antelop card from dashboard method");
    if (isolate != null) {
      debugPrint("Isolate not null");
      receivePort.close();
      isolate?.kill();
      isolate = null;
    }
    try {
      receivePort = ReceivePort();
      isolate = await Isolate.spawn(_getTokenCallBack, receivePort.sendPort);
      receivePort.listen(_handleMessage, onDone: () {});
    } on Exception catch (e) {
      debugPrint("isolate catch section " + e.toString());
    }
  }

  static void _getTokenCallBack(SendPort sendPort) async {
    sendPort.send('Send Dashboard data');
  }

  void _handleMessage(message) {
    _antelopGetCardsRequest.safeAdd(GetAntelopCardsListUseCaseParams());
  }

  ///--------------------Antelop Cards List-----------------///

  ///--------------------Apple Pay PopUp -------------------///

  PublishSubject<bool> _showApplePayPopUpRequest = PublishSubject();

  Stream<bool> get applePayPopUpStream => _showApplePayPopUpRequest.stream;

  void showApplePayPopUp(bool value) {
    _showApplePayPopUpRequest.safeAdd(value);
  }

  ///--------------------Apple Pay PopUp -------------------///

  ///--------------------Account dormant status -------------------///

  PublishSubject<bool> _showAccountDormantStatusPopUpRequest = PublishSubject();

  Stream<bool> get accountDormantStatusPopUpStream => _showAccountDormantStatusPopUpRequest.stream;

  void showAccountDormantPopUp(bool value) {
    _showAccountDormantStatusPopUpRequest.safeAdd(value);
  }

  ///--------------------Account dormant status -------------------///

  ///--------------------Add Another card To Apple Pay PopUp -------------------///

  PublishSubject<bool> _showAddAnotherCardToApplePayPopUpRequest = PublishSubject();

  Stream<bool> get showAddAnotherCardToApplePayPopUpStream =>
      _showAddAnotherCardToApplePayPopUpRequest.stream;

  void showAnotherAppToApplePayPupUp(bool value) {
    Future.delayed(Duration(milliseconds: 500), () {
      _showAddAnotherCardToApplePayPopUpRequest.safeAdd(value);
    });
  }

  ///--------------------Add Another card To Apple Pay PopUp -------------------///
  @override
  void dispose() {
    _currentStep.close();
    _showTimeLineSubject.close();
    _getPlaceHolderRequest.close();
    _getPlaceHolderResponse.close();
    _showRequestMoneyPopUpSubject.close();
    _verifyQRRequest.close();
    _verifyQRResponse.close();
    pageSwitchSubject?.close();

    translateSidewaysController.dispose();
    translateSettingsUpController.dispose();
    translateAccountSettingsUpController.dispose();
    scaleAnimationController.dispose();
    translateTimelineDownController.dispose();
    appSwiperController.dispose();

    if (timer != null) {
      timer?.cancel();
    }

    super.dispose();
  }

  ///--------------- Animation methods... ----------------------///

  /// SETTINGS PAGE ANIMATIONS AND TRANSITIONS....
  showSettingPage(bool value, {bool updateDashboard = false, int currentStep = 0}) {
    if (value) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {},
      );
      animateForwardSettingsPage();
    } else {
      selectedDebitCard = selectedCreditCard = null;
      animateReverseSettingsPage();
    }

    pageSwitchSubject.add(value ? DashboardAnimatedPage.SETTINGS : DashboardAnimatedPage.NULL);
    _currentStep.add(_currentStep.value);
    if (updateDashboard) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (isDebitCard(currentStep)) {
          onDebitCardSettingsClosed();
        } else if (isCreditCard(currentStep)) {
          onCreditCardSettingsClosed();
        }
      });
    }
  }

  showHideAccountSettings(bool value) {
    if (value) {
      translateSidewaysController.forward();
      translateAccountSettingsUpController.forward();
    } else {
      translateSidewaysController.reverse();
      translateAccountSettingsUpController.reverse();
    }
    pageSwitchSubject.add(value ? DashboardAnimatedPage.ACT_SETTING : DashboardAnimatedPage.NULL);
  }

  animateForwardSettingsPage() {
    translateSidewaysController.forward();
    translateSettingsUpController.forward();
  }

  animateReverseSettingsPage() {
    translateSidewaysController.reverse();
    translateSettingsUpController.reverse();
  }

  /// PAYBACK PAGE ANIMATIONS AND TRANSITIONS....
  goToPayBackView(bool value) {
    if (value) {
      animateForwardSettingsPage();
    } else {
      animateReverseSettingsPage();
    }

    pageSwitchSubject.add(value ? DashboardAnimatedPage.PAYBACK : DashboardAnimatedPage.NULL);
  }

  animateForwardTimelinePage() {
    translateTimelineDownController.forward();
    translateSidewaysController.forward();
  }

  animateReverseTimelinePage() {
    translateTimelineDownController.reverse();
    translateSidewaysController.reverse();
  }

  /// TIMELINE PAGE ANIMATIONS AND TRANSITIONS....

  showTimeline(bool value) {
    if (value) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          timelineGlitchAnimation();
        },
      );
      animateForwardTimelinePage();
    } else {
      animateReverseTimelinePage();
    }
    pageSwitchSubject.add(value ? DashboardAnimatedPage.TIMELINE : DashboardAnimatedPage.NULL);
  }

  timelineGlitchAnimation() {
    if (timelineScrollController.positions.isNotEmpty && timelineScrollController.hasClients)
      timelineScrollController
          .animateTo(30, duration: const Duration(milliseconds: 400), curve: Curves.easeIn)
          .then((value) {
        if (timelineScrollController.positions.isNotEmpty && timelineScrollController.hasClients)
          timelineScrollController.animateTo(-30,
              duration: const Duration(milliseconds: 500), curve: Curves.easeInBack);
      });
  }

  goToTransactionPage(BuildContext context, int currentStep) {
    animateForwardTransactionPage();
    Navigator.of(context).push(CustomRoute.swipeUpRoute(CardTransactionPage(
      GetCreditCardTransactionArguments(
          cardId: timeLineListArguments[currentStep - 1].cardId,
          secureCode: timeLineListArguments[currentStep - 1].secureCode ?? '',
          isIssuedFromCMS: timeLineListArguments[currentStep - 1].isIssuedFromCMS ?? false),
    )));
  }

  goToAccountTransactionPage(BuildContext context) {
    animateForwardTransactionPage();
    Navigator.of(context).push(CustomRoute.swipeUpRoute(AccountTransactionPage()));
  }

  animateForwardTransactionPage() {
    pageSwitchSubject.add(DashboardAnimatedPage.TRANSACTIONS);

    translateSettingsUpController.forward();
    scaleAnimationController.forward();
  }

  animateReverseTransactionPage() {
    pageSwitchSubject.add(DashboardAnimatedPage.NULL);
    translateSettingsUpController.reverse();
    scaleAnimationController.reverse();
  }

  ///Credit card logic
  bool showButtonsInCreditCard = true;

  showButtonsCreditCard() {
    showButtonsInCreditCard = !showButtonsInCreditCard;
    notifyListeners();
  }

  void onDebitCardSettingsClosed() {
    if (debitCardIsFreezed ||
        debitCardIsUnFreezed ||
        debitCardIsCancelled ||
        debitCardIsReportDamagedCard ||
        debitCardLostStolenReported) {
      getDashboardData();
    }
  }

  void onCreditCardSettingsClosed() {
    if (creditCardIsFreezed || creditCardIsUnFreezed || creditCardIsCancelled) {
      getDashboardData();
    }
  }
}

class TimeLineSwipeUpArgs {
  final CardType cardType;

  final SwipeUpEnum swipeUpEnum;

  final TimeLineEnum timeLineEnum;

  TimeLineSwipeUpArgs(
      {this.cardType = CardType.ACCOUNT,
      this.swipeUpEnum = SwipeUpEnum.SWIPE_UP_NO,
      this.timeLineEnum = TimeLineEnum.TIMELINE_NO});
}

enum SwipeUpEnum {
  SWIPE_UP_YES, // transactions
  SWIPE_UP_NO, // don't show transactions
}

enum TimeLineEnum {
  TIMELINE_YES, // time line
  TIMELINE_NO, // don't show time line
}

enum DashboardAnimatedPage { TIMELINE, PAYBACK, SETTINGS, TRANSACTIONS, ACT_SETTING, SUB_ACT_SETTING, NULL }

enum DashboardCardType { account, credit, debit, subAccount, rj }
