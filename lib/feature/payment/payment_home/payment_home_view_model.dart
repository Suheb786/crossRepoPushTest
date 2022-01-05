import 'package:card_swiper/card_swiper.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/usecase/manage_contacts/get_beneficiary_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaymentHomeViewModel extends BasePageViewModel {
  final SwiperController pageController = SwiperController();

  GetBeneficiaryUseCase _getBeneficiaryUseCase;

  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  PublishSubject<int> _currentStep = PublishSubject();

  Stream<int> get currentStep => _currentStep.stream;

  PublishSubject<PageController> _pageControllerSubject = PublishSubject();

  Stream<PageController> get pageControllerStream =>
      _pageControllerSubject.stream;

  PublishSubject<GetBeneficiaryUseCaseParams> _getBeneficiaryRequest =
      PublishSubject();

  BehaviorSubject<Resource<GetBeneficiaryListResponse>>
      _getBeneficiaryResponse = BehaviorSubject();

  Stream<Resource<GetBeneficiaryListResponse>> get beneficiaryResponse =>
      _getBeneficiaryResponse.stream;

  void updatePage(int index) {
    _currentStep.safeAdd(index);
  }

  void updatePageControllerStream(int index) {
    controller = PageController(
        initialPage: index, viewportFraction: 0.8, keepPage: true);
    _pageControllerSubject.safeAdd(controller);
  }

  PaymentHomeViewModel(this._getBeneficiaryUseCase) {
    _getBeneficiaryRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        print("in add request money constructor");
        updateLoader();
        _getBeneficiaryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
    getBeneficiaries();
  }

  void getBeneficiaries() {
    _getBeneficiaryRequest.safeAdd(GetBeneficiaryUseCaseParams());
  }

  @override
  void dispose() {
    _currentStep.close();
    super.dispose();
  }
}
