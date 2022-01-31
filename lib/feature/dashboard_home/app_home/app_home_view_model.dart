import 'package:card_swiper/card_swiper.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AppHomeViewModel extends BasePageViewModel {
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final SwiperController pageController = SwiperController();
  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 1);
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  PublishSubject<bool> _showTimeLineSubject = PublishSubject();

  Stream<bool> get showTimeLineStream => _showTimeLineSubject.stream;

  Stream<PageController> get pageControllerStream =>
      _pageControllerSubject.stream;

  bool showBody = true;

  CardType cardType = CardType.DEBIT;

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

  AppHomeViewModel(this._getDashboardDataUseCase) {
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
          dashboardDataContent = event.data!.dashboardDataContent!;
          _dashboardCardResponse.safeAdd(event.data!.dashboardDataContent);
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

  List<Widget> buildPageIndicator(int currentPage) {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
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

  void updateShowTimeLineStream(bool value) {
    _showTimeLineSubject.add(value);
  }

  void getDashboardData() {
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
