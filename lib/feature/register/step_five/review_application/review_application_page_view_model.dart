import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/review_app_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ReviewApplicationPageViewModel extends BasePageViewModel {
  final ReviewApplicationUseCase _reviewAppUseCase;

  ScrollController scrollController = ScrollController();

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.add(value);
  }

  ///review request subject holder
  PublishSubject<ReviewApplicationUseCaseParams> _reviewAppRequest =
      PublishSubject();

  ///review response holder
  PublishSubject<Resource<List<String>>> _reviewAppResponse = PublishSubject();

  ///review stream
  Stream<Resource<List<String>>> get reviewAppStream =>
      _reviewAppResponse.stream;

  ReviewApplicationPageViewModel(this._reviewAppUseCase) {
    _reviewAppRequest.listen((value) {
      RequestManager(value,
              createCall: () => _reviewAppUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _reviewAppResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<List<String>> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_DECLARATION_SELECTION:
        break;
    }
  }

  void validateReviewDetails() {
    _reviewAppRequest.safeAdd(ReviewApplicationUseCaseParams(
        declarationSelected: _declarationSelected.value));
  }
}
