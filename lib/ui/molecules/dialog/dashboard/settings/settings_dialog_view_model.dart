import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/account_setting/get_profile_info/get_profile_info_usecase.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SettingsDialogViewModel extends BasePageViewModel {
  final LogoutUseCase _logoutUseCase;
  final GetProfileInfoUseCase _getProfileInfoUseCase;

  final SwiperController pageController = SwiperController();

  final CarouselController controller = CarouselController();

  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  /// get profile info  request
  PublishSubject<GetProfileInfoUseCaseParams> _getProfileInfoRequest =
      PublishSubject();

  /// get profile info response
  PublishSubject<Resource<ProfileInfoResponse>> _getProfileInfoResponse =
      PublishSubject();

  /// get profile info response stream
  Stream<Resource<ProfileInfoResponse>> get getProfileInfoStream =>
      _getProfileInfoResponse.stream;

  /// logout request holder
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();

  /// logout response holder
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  /// logout response stream
  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  BehaviorSubject<String> _textResponse = BehaviorSubject();

  Stream<String> get textStream => _textResponse.stream;

  SettingsDialogViewModel(this._logoutUseCase, this._getProfileInfoUseCase) {
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

    _getProfileInfoRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _getProfileInfoUseCase.execute(params: value),
      ).asFlow().listen((event) {
        //updateLoader();
        _getProfileInfoResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          print("got fullname: ${event.data!.content!.fullName}");
          _textResponse.safeAdd(event.data!.content!.fullName!);
        }
      });
    });
    getProfileDetails();
    getCurrentUserStream();
  }

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  ///get profile details
  void getProfileDetails() {
    _getProfileInfoRequest.safeAdd(GetProfileInfoUseCaseParams());
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
