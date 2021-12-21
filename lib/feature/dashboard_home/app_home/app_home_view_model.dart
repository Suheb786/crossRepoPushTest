import 'package:card_swiper/card_swiper.dart';
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

  GetDashboardDataContent dashboardDataContent = GetDashboardDataContent();

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
        _getDashboardDataResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          dashboardDataContent = event.data!.dashboardDataContent!;
        }
      });
    });

    getDashboardData();
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

  @override
  void dispose() {
    _currentStep.close();
    _pageControllerSubject.close();
    super.dispose();
  }
}
