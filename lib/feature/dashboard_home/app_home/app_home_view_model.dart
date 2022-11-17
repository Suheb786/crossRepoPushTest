import 'package:card_swiper/card_swiper.dart';
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
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:domain/usecase/dashboard/get_placeholder_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_page.dart';
import 'package:neo_bank/ui/molecules/card/apply_credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/apply_debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_issuance_failure_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_not_delivered_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/debit_card_error_widget.dart';
import 'package:neo_bank/ui/molecules/card/debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/get_credit_card_now_widget.dart';
import 'package:neo_bank/ui/molecules/card/post_paid_bill_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/pre_paid_bill_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/resume_credit_card_application_view.dart';
import 'package:neo_bank/ui/molecules/card/verify_credit_card_videocall_widget.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AppHomeViewModel extends BasePageViewModel {
  final GetDashboardDataUseCase _getDashboardDataUseCase;

  final GetPlaceholderUseCase _getPlaceholderUseCase;

  final SwiperController pageController = SwiperController();
  ScrollController scrollController = ScrollController();
  PageController appSwiperController = PageController(viewportFraction: 0.8);

  PageController controller = PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  PublishSubject<bool> _showTimeLineSubject = PublishSubject();

  Stream<bool> get showTimeLineStream => _showTimeLineSubject.stream;

  Stream<PageController> get pageControllerStream => _pageControllerSubject.stream;

  BehaviorSubject<bool> _showRequestMoneyPopUpSubject = BehaviorSubject.seeded(false);

  bool showBody = true;
  bool isShowBalenceUpdatedToast = false;

  CardType cardType = CardType.DEBIT;

  ChangeCardPinArguments changeCardPinArguments = ChangeCardPinArguments();

  CreditCard currentCreditCard = CreditCard();

  GetDashboardDataContent dashboardDataContent = GetDashboardDataContent();

  /// Sent money popup request
  PublishSubject<bool> _sentMoneyPopUpResponse = PublishSubject();

  /// Sent money popup response
  PublishSubject<bool> _sentMoneyRequest = PublishSubject();

  /// Sent money popup stream
  Stream<bool> get getSentMoneyPopUpDataStream => _sentMoneyPopUpResponse.stream;

  /// Sent money popup request
  PublishSubject<bool> _requestMoneyPopUpResponse = PublishSubject();

  /// Sent money popup response
  PublishSubject<bool> _requestMoneyRequest = PublishSubject();

  /// Sent money popup stream
  Stream<bool> get getRequestMoneyPopUpDataStream => _requestMoneyPopUpResponse.stream;

  ///dashboard card data response
  BehaviorSubject<GetDashboardDataContent> _dashboardCardResponse =
      BehaviorSubject.seeded(GetDashboardDataContent());

  ///dashboard card data response stream
  Stream<GetDashboardDataContent> get getDashboardCardDataStream => _dashboardCardResponse.stream;

  ///get dashboard data request
  PublishSubject<GetDashboardDataUseCaseParams> _getDashboardDataRequest = PublishSubject();

  ///get dashboard data response
  PublishSubject<Resource<GetDashboardDataResponse>> _getDashboardDataResponse = PublishSubject();

  ///get dashboard data response stream
  Stream<Resource<GetDashboardDataResponse>> get getDashboardDataStream => _getDashboardDataResponse.stream;

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

  AppHomeViewModel(this._getDashboardDataUseCase, this._getPlaceholderUseCase) {
    isShowBalenceUpdatedToast = false;
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
          // showErrorState();
          // showToastWithError(event.appError!);
          timeLineArguments.placeholderData = timelinePlaceholderData;
        } else if (event.status == Status.SUCCESS) {
          triggerRequestMoneyPopup();
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

    ///talabat placeholder
    // _sentMoneyRequest.listen((value) {
    //   _sentMoneyPopUpResponse.safeAdd(value);
    // });

    _requestMoneyRequest.listen((value) {
      _requestMoneyPopUpResponse.safeAdd(value);
    });

    getDashboardData();
  }

  void getDashboardPages(GetDashboardDataContent dashboardDataContent) {
    pages.clear();
    timeLineListArguments.clear();
    blinkTimeLineListArguments.clear();
    cardTypeList.clear();
    bool isSmallDevices = deviceSize.height < ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
        deviceSize.height < ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
    if (dashboardDataContent != null) {
      pages.add(MyAccountPage(account: dashboardDataContent.account!));
      cardTypeList
          .add(TimeLineSwipeUpArgs(cardType: CardType.ACCOUNT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES));

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
        cardTypeList
            .add(TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
      } else {
        if (dashboardDataContent.creditCard!.length > 0) {
          dashboardDataContent.creditCard!.forEach((creditCard) {
            if (creditCard.isCompleted ?? false) {
              if (creditCard.isCreditDelivered ?? false) {
                pages.add(CreditCardWidget(
                  accountBalance: dashboardDataContent.account!.availableBalance,
                  isSmallDevice: isSmallDevices,
                  creditCard: creditCard,
                  isChangePinEnabled: dashboardDataContent.dashboardFeatures?.isPinChangeEnabled ?? true,
                  key: ValueKey('credit${creditCard.cardCode}${creditCard.cvv}'),
                ));

                ///time line list  arguments set
                timeLineListArguments.add(TimeLineListArguments(
                    cardCardActivated: creditCard.creditCardActivatedDate ?? '',
                    cardDeliveredDatetime: creditCard.creditDeliveredDatetime ?? '',
                    cardId: creditCard.cardId ?? '',
                    cardNumber: creditCard.cardNumber ?? '',
                    accountTitle: creditCard.name ?? '',
                    cardType: CardType.CREDIT,
                    isCardDelivered: creditCard.isCreditDelivered));

                ///adding cardType
                cardTypeList.add(
                    TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_YES));
              } else {
                pages.add(CreditCardNotDeliveredWidget(
                  isSmallDevice: isSmallDevices,
                  creditCard: creditCard,
                  isChangePinEnabled: dashboardDataContent.dashboardFeatures?.isPinChangeEnabled ?? true,
                  key: ValueKey('credit${creditCard.cardCode}${creditCard.cvv}'),
                ));

                ///TODO:verify timeline arguments
                ///time line list  arguments set
                timeLineListArguments.add(TimeLineListArguments(
                    cardCardActivated: creditCard.creditCardActivatedDate ?? '',
                    cardDeliveredDatetime: creditCard.creditDeliveredDatetime ?? '',
                    cardId: creditCard.cardId ?? '',
                    cardNumber: creditCard.cardNumber ?? '',
                    accountTitle: creditCard.name ?? '',
                    cardType: CardType.CREDIT,
                    isCardDelivered: creditCard.isCreditDelivered));

                ///adding cardType
                cardTypeList.add(
                    TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            } else {
              if (!(dashboardDataContent.dashboardFeatures?.isCreditCardFeatureEnabled ?? true)) {
                pages.add(CreditCardIssuanceFailureWidget(
                  isSmallDevices: isSmallDevices,
                  type: IssuanceType.service_unavailable,
                ));

                ///adding cardType
                cardTypeList.add(
                    TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              } else {
                if (creditCard.primarySecondaryCard == PrimarySecondaryCardEnum.SECONDARY) {
                } else {
                  switch (creditCard.callStatus) {
                    case CreditCardCallStatusEnum.APPROVED:
                      pages.add(GetCreditCardNowWidget(
                        isSmallDevices: isSmallDevices,
                        key: ValueKey('credit#GetCreditCardNowWidget#'),
                      ));
                      cardTypeList.add(TimeLineSwipeUpArgs(
                          cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                      break;

                    case CreditCardCallStatusEnum.DROP:
                    case CreditCardCallStatusEnum.CALL_NOT_RECEIVED:
                      pages.add(VerifyCreditCardVideoCallWidget(
                        isSmallDevices: isSmallDevices,
                        creditCard: creditCard,
                      ));

                      ///adding cardType
                      cardTypeList.add(TimeLineSwipeUpArgs(
                          cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                      break;

                    case CreditCardCallStatusEnum.REJECTED:
                      break;

                    default:
                      pages.add(ResumeCreditCardApplicationView(
                        isSmallDevices: isSmallDevices,
                      ));

                      ///adding cardType
                      cardTypeList.add(TimeLineSwipeUpArgs(
                          cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                  }
                  // if (creditCard.isCallPending ?? false) {
                  //   pages.add(CreditCardApplicationUnderReviewWidget(
                  //     isSmallDevices: isSmallDevices,
                  //   ));
                  //   cardTypeList.add(
                  //       TimeLineSwipeUpArgs(cardType: CardType.CREDIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
                  // } else {
                  //
                  // }
                }
              }
            }
          });
        } else {
          if (!(dashboardDataContent.dashboardFeatures?.isCreditCardFeatureEnabled ?? true)) {
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
            } else {
              if (!(debitCard.isPINSet ?? true)) {
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
              } else {
                pages.add(DebitCardWidget(
                    isPrimaryDebitCard: isPrimaryDebitCard,
                    isSmallDevice: isSmallDevices,
                    key: ValueKey('debit${debitCard.code}${debitCard.cvv}'),
                    debitCard: debitCard,
                    isDebitCardRequestPhysicalCardEnabled:
                        dashboardDataContent.dashboardFeatures?.isDebitCardRequestPhysicalCardEnabled ??
                            false));

                ///time line list arguments set
                timeLineListArguments.add(TimeLineListArguments(
                    cardCardActivated: debitCard.debitCardActivated.toString(),
                    cardDeliveredDatetime: debitCard.debitDeliveredDatetime.toString(),
                    cardId: '',
                    cardNumber: debitCard.cardNumber ?? '',
                    accountTitle: debitCard.accountTitle ?? '',
                    cardType: CardType.DEBIT,
                    isCardDelivered: debitCard.isDebitDelivered));

                ///adding cardType
                cardTypeList
                    .add(TimeLineSwipeUpArgs(cardType: CardType.DEBIT, swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO));
              }
            }
          });
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

      // ///TODO PostPaid Card
      // pages.add(PostPaidBillCardWidget());
      //
      // ///TODO PrePaidPaid Card
      // pages.add(PrePaidBillCardWidget());
    }
    addPages(pages);
    blinkTimeLineListArguments.addAll(timeLineListArguments);
    timeLineArguments.timelineListArguments = blinkTimeLineListArguments;
    sortTimeLineArgumentsList();
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
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
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
        return DateTime.parse(b.cardCardActivated!).compareTo(DateTime.parse(a.cardCardActivated!));
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
      return 13.0;
    } else if ((i == 0 || i == pages.length - 1) && !isActive) {
      return 7.0;
    }
    return 10.0;
  }

  // double getSize(bool isActive, int i, int currentPage) {
  //   if (isActive) {
  //     return 13.0;
  //   } else if (i == 0 && !isActive && currentPage > 1) {
  //     return 5.0;
  //   } else if (i == 0 && !isActive && currentPage == 1) {
  //     return 5.0;
  //   } else if (i == 3 && !isActive && currentPage == 2) {
  //     return 5.0;
  //   } else if (i == 3 && !isActive && currentPage < 2) {
  //     return 5.0;
  //   } else if (i == 1 && !isActive && currentPage == 3) {
  //     return 10.0;
  //   } else if (i == 2 && !isActive && currentPage == 0) {
  //     return 10.0;
  //   } else if (i == 1 && !isActive && currentPage == 2) {
  //     return 10.0;
  //   } else if (i == 2 && !isActive && currentPage == 1) {
  //     return 10.0;
  //   }
  //   return 10.0;
  // }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    controller = PageController(initialPage: index, viewportFraction: 0.8, keepPage: true);
    _pageControllerSubject.safeAdd(controller);
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

  // void triggerSentMoneyPopup() {
  //   _sentMoneyRequest.safeAdd(true);
  // }

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

  @override
  void dispose() {
    _currentStep.close();
    _showTimeLineSubject.close();
    _pageControllerSubject.close();
    _getPlaceHolderRequest.close();
    _getPlaceHolderResponse.close();
    _showRequestMoneyPopUpSubject.close();
    super.dispose();
  }
}

class TimeLineSwipeUpArgs {
  final CardType cardType;

  final SwipeUpEnum swipeUpEnum;

  TimeLineSwipeUpArgs({this.cardType: CardType.ACCOUNT, this.swipeUpEnum: SwipeUpEnum.SWIPE_UP_NO});
}

enum SwipeUpEnum { SWIPE_UP_YES, SWIPE_UP_NO }
