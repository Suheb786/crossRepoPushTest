import 'package:card_swiper/card_swiper.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_page.dart';
import 'package:neo_bank/ui/molecules/card/apply_credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/apply_debit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_issuance_failure_widget.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_widget.dart';
import 'package:neo_bank/ui/molecules/card/debit_card_widget.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AppHomeViewModel extends BasePageViewModel {
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final SwiperController pageController = SwiperController();
  PageController appSwiperController = PageController(viewportFraction: 0.8);

  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  PublishSubject<bool> _showTimeLineSubject = PublishSubject();

  Stream<bool> get showTimeLineStream => _showTimeLineSubject.stream;

  Stream<PageController> get pageControllerStream =>
      _pageControllerSubject.stream;

  bool showBody = true;
  bool isShowBalenceUpdatedToast = false;

  CardType cardType = CardType.DEBIT;

  ChangeCardPinArguments changeCardPinArguments = ChangeCardPinArguments();

  GetDashboardDataContent dashboardDataContent = GetDashboardDataContent();

  /// Sent money popup request
  PublishSubject<bool> _sentMoneyPopUpResponse = PublishSubject();

  /// Sent money popup response
  PublishSubject<bool> _sentMoneyRequest = PublishSubject();

  /// Sent money popup stream
  Stream<bool> get getSentMoneyPopUpDataStream =>
      _sentMoneyPopUpResponse.stream;

  /// Sent money popup request
  PublishSubject<bool> _requestMoneyPopUpResponse = PublishSubject();

  /// Sent money popup response
  PublishSubject<bool> _requestMoneyRequest = PublishSubject();

  /// Sent money popup stream
  Stream<bool> get getRequestMoneyPopUpDataStream =>
      _requestMoneyPopUpResponse.stream;

  ///dashboard card data response
  BehaviorSubject<GetDashboardDataContent> _dashboardCardResponse =
      BehaviorSubject.seeded(GetDashboardDataContent());

  ///dashboard card data response stream
  Stream<GetDashboardDataContent> get getDashboardCardDataStream =>
      _dashboardCardResponse.stream;

  ///get dashboard data request
  PublishSubject<GetDashboardDataUseCaseParams> _getDashboardDataRequest =
      PublishSubject();

  ///get dashboard data response
  PublishSubject<Resource<GetDashboardDataResponse>> _getDashboardDataResponse =
      PublishSubject();

  ///get dashboard data response stream
  Stream<Resource<GetDashboardDataResponse>> get getDashboardDataStream =>
      _getDashboardDataResponse.stream;

  Size deviceSize = Size(0, 0);

  ///pages response
  BehaviorSubject<List> _pagesResponseSubject = BehaviorSubject();

  ///pages response stream
  Stream<List> get pageStream => _pagesResponseSubject.stream;

  List pages = [];

  TimeLineArguments timeLineArguments =
      TimeLineArguments(timelineListArguments: []);

  List<TimeLineListArguments> timeLineListArguments = [];

  AppHomeViewModel(this._getDashboardDataUseCase) {
    isShowBalenceUpdatedToast = false;
    _getDashboardDataRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getDashboardDataUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getDashboardDataResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
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

    _sentMoneyRequest.listen((value) {
      _sentMoneyPopUpResponse.safeAdd(value);
    });

    _requestMoneyRequest.listen((value) {
      _requestMoneyPopUpResponse.safeAdd(value);
    });

    getDashboardData();
  }

  void getDashboardPages(GetDashboardDataContent dashboardDataContent) {
    pages.clear();
    timeLineListArguments.clear();
    bool isSmallDevices =
        deviceSize.height < ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
            deviceSize.height < ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
    if (dashboardDataContent != null) {
      pages.add(MyAccountPage(account: dashboardDataContent.account!));

      ///setting timeline arguments value start
      timeLineArguments.availableBalance =
          dashboardDataContent.account!.availableBalance ?? '0.000';
      timeLineArguments.blinkWasBorn =
          dashboardDataContent.blinkWasBorn.toString();
      timeLineArguments.youJoinedBlink =
          dashboardDataContent.youJoinedBlink.toString();

      ///end

      if (dashboardDataContent.somethingWrong ?? false) {
        pages.add(CreditCardIssuanceFailureWidget(
          isSmallDevices: isSmallDevices,
        ));
      } else {
        if (dashboardDataContent.creditCard!.length > 0) {
          dashboardDataContent.creditCard!.forEach((creditCard) {
            if (creditCard.isCompleted ?? false) {
              pages.add(CreditCardWidget(
                accountBalance: dashboardDataContent.account!.availableBalance,
                isSmallDevice: isSmallDevices,
                creditCard: creditCard,
                key: ValueKey('credit${creditCard.cardCode}${creditCard.cvv}'),
              ));

              ///time line list arguments set
              timeLineListArguments.add(TimeLineListArguments(
                  cardCardActivated: creditCard.creditCardActivatedDate ?? '',
                  cardDeliveredDatetime:
                      creditCard.creditDeliveredDatetime ?? '',
                  cardId: creditCard.cardId ?? '',
                  cardNumber: creditCard.cardNumber ?? '',
                  accountTitle: creditCard.name ?? '',
                  cardType: CardType.CREDIT,
                  isCardDelivered: creditCard.isCreditDelivered));
            } else {
              pages.add(ApplyCreditCardWidget(
                isSmallDevices: isSmallDevices,
              ));
            }
          });
        } else {
          pages.add(ApplyCreditCardWidget(
            isSmallDevices: isSmallDevices,
          ));
        }
      }

      if (dashboardDataContent.debitCard!.length > 0) {
        dashboardDataContent.debitCard!.forEach((debitCard) {
          pages.add(DebitCardWidget(
              isSmallDevice: isSmallDevices,
              key: ValueKey('debit${debitCard.code}${debitCard.cvv}'),
              debitCard: debitCard));

          ///time line list arguments set
          timeLineListArguments.add(TimeLineListArguments(
              cardCardActivated: debitCard.debitCardActivated.toString(),
              cardDeliveredDatetime:
                  debitCard.debitDeliveredDatetime.toString(),
              cardId: '',
              cardNumber: debitCard.cardNumber ?? '',
              accountTitle: debitCard.accountTitle ?? '',
              cardType: CardType.DEBIT,
              isCardDelivered: debitCard.isDebitDelivered));
        });
      } else {
        pages.add(ApplyDebitCardWidget(
          isSmallDevice: isSmallDevices,
        ));
      }
    }
    addPages(pages);
    timeLineArguments.timelineListArguments = timeLineListArguments;
  }

  void addPages(List pagesList) {
    _pagesResponseSubject.safeAdd(pagesList);
  }

  void nextPage() {
    appSwiperController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void previousPage() {
    appSwiperController.previousPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  void moveToPage(int index) {
    appSwiperController.animateToPage(index,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  List<Widget> buildPageIndicator(int currentPage, int totalPage) {
    List<Widget> list = [];
    for (int i = 0; i < pages.length; i++) {
      list.add(i == currentPage
          ? indicator(true, i, currentPage)
          : indicator(false, i, currentPage));
    }
    return list;
  }

  Widget indicator(bool isActive, int i, int currentPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      height: getSize(isActive, i, currentPage),
      width: getSize(isActive, i, currentPage),
      decoration: BoxDecoration(
        color: getColor(isActive, i),
        shape: BoxShape.circle,
      ),
    );
  }

  Color getColor(bool isActive, int i) {
    if (isActive) {
      return Colors.black;
    } else {
      return Color(0xFFA9A9A9);
    }
  }

  double getSize(bool isActive, int i, int currentPage) {
    if (isActive) {
      return 13.0;
    } else if (i == 0 && !isActive && currentPage > 1) {
      return 5.0;
    } else if (i == 0 && !isActive && currentPage == 1) {
      return 5.0;
    } else if (i == 3 && !isActive && currentPage == 2) {
      return 5.0;
    } else if (i == 3 && !isActive && currentPage < 2) {
      return 5.0;
    } else if (i == 1 && !isActive && currentPage == 3) {
      return 10.0;
    } else if (i == 2 && !isActive && currentPage == 0) {
      return 10.0;
    } else if (i == 1 && !isActive && currentPage == 2) {
      return 10.0;
    } else if (i == 2 && !isActive && currentPage == 1) {
      return 10.0;
    }
    return 10.0;
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    controller = PageController(
        initialPage: index, viewportFraction: 0.8, keepPage: true);
    _pageControllerSubject.safeAdd(controller);
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

  void triggerSentMoneyPopup() {
    _sentMoneyRequest.safeAdd(true);
  }

  void triggerRequestMoneyPopup() {
    _requestMoneyRequest.safeAdd(true);
  }

  @override
  void dispose() {
    _currentStep.close();
    _showTimeLineSubject.close();
    _pageControllerSubject.close();
    super.dispose();
  }
}
