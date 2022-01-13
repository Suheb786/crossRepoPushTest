import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SettingsDialogViewModel extends BasePageViewModel {
  final LogoutUseCase _logoutUseCase;

  final SwiperController pageController = SwiperController();

  final CarouselController controller = CarouselController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  /// logout request holder
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();

  /// logout response holder
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  /// logout response stream
  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  SettingsDialogViewModel(this._logoutUseCase) {
    _logoutRequest.listen((value) {
      RequestManager(value,
              createCall: () => _logoutUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _logoutResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void logout() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  @override
  void dispose() {
    _logoutRequest.close();
    _logoutResponse.close();
    super.dispose();
  }
}
