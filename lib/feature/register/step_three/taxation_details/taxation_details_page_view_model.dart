import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/register/taxation_details_usecase.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class TaxationDetailsPageViewModel extends BasePageViewModel {
  final TaxationDetailsUseCase _taxationDetailsUseCase;

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  bool anyOtherCountryResident = false;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.safeAdd(value);
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
        _taxationDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateTaxationDetails() {
    if (_declarationSelected.stream.value) {
      _taxationDetailsRequest.safeAdd(TaxationDetailsUseCaseParams());
    } else {
      showErrorState();
    }
  }

  @override
  void dispose() {
    _taxationDetailsRequest.close();
    _taxationDetailsResponse.close();
    _declarationSelected.close();
    super.dispose();
  }
}
