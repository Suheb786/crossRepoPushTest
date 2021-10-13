import 'package:domain/usecase/user/id_verification_info_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class IdVerificationInfoViewModel extends BasePageViewModel {
  final IdVerificationInfoUseCase _idVerificationInfoUseCase;
  bool? _isRetrieveConditionChecked = false;

  bool? get isRetrieveConditionChecked => _isRetrieveConditionChecked;

  bool? _showError = false;

  bool? get showError => _showError;

  /// id verification info request subject holder
  // ignore: close_sinks
  PublishSubject<IdVerificationInfoUseCaseParams> _idVerificationInfoRequest =
      PublishSubject();

  Stream<IdVerificationInfoUseCaseParams> get idVerificationRequestStream =>
      _idVerificationInfoRequest.stream;

  /// id verification info response subject holder
  // ignore: close_sinks
  PublishSubject<Resource<bool>> _idVerificationInfoResponse = PublishSubject();

  Stream<Resource<bool>> get idVerificationResponseStream =>
      _idVerificationInfoResponse.stream;

  /// error detector subject holder
  // ignore: close_sinks
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  void setIsRetrieveConditionChecked(bool value) {
    _isRetrieveConditionChecked = value;
  }

  void setShowError(bool value) {
    _showError = value;
  }

  IdVerificationInfoViewModel(this._idVerificationInfoUseCase) {
    _idVerificationInfoRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _idVerificationInfoUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _idVerificationInfoResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          _showErrorState();
        }
      });
    });
  }

  void idVerificationInfo() {
    _idVerificationInfoRequest.safeAdd(IdVerificationInfoUseCaseParams(isRetrieveConditionChecked: isRetrieveConditionChecked));
  }

  void _showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 800), () {
      _errorDetectorSubject.safeAdd(false);
    });
  }
}
