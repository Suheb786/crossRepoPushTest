import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:domain/usecase/register/review_app_usecase.dart';

class ReviewApplicationPageViewModel extends BasePageViewModel {
  final ReviewApplicationUseCase _reviewAppUseCase;

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.safeAdd(value);
  }

  ///review request subject holder
  PublishSubject<ReviewApplicationUseCaseParams> _reviewAppRequest =
      PublishSubject();

  ///review response holder
  PublishSubject<Resource<bool>> _reviewAppResponse = PublishSubject();

  ///review stream
  Stream<Resource<bool>> get reviewAppStream => _reviewAppResponse.stream;

  ReviewApplicationPageViewModel(this._reviewAppUseCase) {
    _reviewAppRequest.listen((value) {
      RequestManager(value,
              createCall: () => _reviewAppUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _reviewAppResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateReviewDetails() {
    if (_declarationSelected.stream.value) {
      _reviewAppRequest.add(ReviewApplicationUseCaseParams());
    } else {
      showErrorState();
    }
  }
}
