import 'package:domain/usecase/user/id_verification_info_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class IdVerificationInfoViewModel extends BasePageViewModel {
  final IdVerificationInfoUseCase _idVerificationInfoUseCase;

  /// retrieve condition check subject holder
  BehaviorSubject<bool> _isRetrievedConditionSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isRetrievedConditionStream =>
      _isRetrievedConditionSubject.stream;

  /// id verification info request subject holder
  PublishSubject<IdVerificationInfoUseCaseParams> _idVerificationInfoRequest =
      PublishSubject();

  Stream<IdVerificationInfoUseCaseParams> get idVerificationRequestStream =>
      _idVerificationInfoRequest.stream;

  /// id verification info response subject holder
  PublishSubject<Resource<bool>> _idVerificationInfoResponse = PublishSubject();

  Stream<Resource<bool>> get idVerificationResponseStream =>
      _idVerificationInfoResponse.stream;

  void updateIsRetrievedConditionStream(bool value) {
    _isRetrievedConditionSubject.safeAdd(value);
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
          showErrorState();
        }
      });
    });
  }

  void idVerificationInfo() {
    _idVerificationInfoRequest.safeAdd(IdVerificationInfoUseCaseParams(
        isRetrieveConditionChecked: _isRetrievedConditionSubject.value));
  }

  @override
  void dispose() {
    _isRetrievedConditionSubject.close();
    _idVerificationInfoRequest.close();
    _idVerificationInfoResponse.close();
    super.dispose();
  }
}
