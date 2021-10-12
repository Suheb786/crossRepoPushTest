import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/register/taxation_details_usecase.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class TaxationDetailsPageViewModel extends BasePageViewModel {
  final TaxationDetailsUseCase _taxationDetailsUseCase;
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  void updateDeclarationSelection(bool value) {
    _declarationSelected.add(value);
  }

  ///error detector subject
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  ///error detector stream
  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  void showErrorState() {
    _errorDetectorSubject.add(true);
    Future.delayed(Duration(milliseconds: 500), () {
      _errorDetectorSubject.add(false);
    });
  }

  ///taxation details request subject holder
  PublishSubject<TaxationDetailsUseCaseParams> _taxationDetailsRequest =
      PublishSubject();

  ///taxation details response holder
  PublishSubject<Resource<bool>> _taxationDetailsResponse = PublishSubject();

  ///taxation details stream
  Stream<Resource<bool>> get taxationDetailsStream =>
      _taxationDetailsResponse.stream;

  TaxationDetailsPageViewModel(this._taxationDetailsUseCase) {
    _taxationDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _taxationDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _taxationDetailsResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateTaxationDetails() {
    if (_declarationSelected.stream.value) {
      _taxationDetailsRequest.add(TaxationDetailsUseCaseParams());
    }
    showErrorState();
  }
}
