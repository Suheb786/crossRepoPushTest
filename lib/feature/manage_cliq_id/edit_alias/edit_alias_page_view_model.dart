import 'package:domain/usecase/cliq/edit_cliq_id_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EditAliasPageViewModel extends BasePageViewModel {
  final EditCliqIdUseCase _editCliqIdUseCase;

  ///controllers and keys
  final TextEditingController aliasController = TextEditingController();
  final GlobalKey<AppTextFieldState> aliasKey = GlobalKey(debugLabel: "alias");

  //*----------------edit Cliq Id--------------///

  PublishSubject<EditCliqIdUseCaseParams> _editCliqIdRequest = PublishSubject();
  PublishSubject<Resource<bool>> _editCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get editCliqIdStream => _editCliqIdResponse.stream;

  void editCliqId(bool getToken, String aliasId, bool isAlias,
      String aliasValue, String otpCode) {
    _editCliqIdRequest.safeAdd(EditCliqIdUseCaseParams(
        isAlias: isAlias,
        aliasValue: aliasValue,
        aliasId: aliasId,
        getToken: getToken,
        OtpCode: otpCode));
  }

  EditAliasPageViewModel(this._editCliqIdUseCase) {
    _editCliqIdRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _editCliqIdUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _editCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    // editCliqId();
  }

  ///----------------edit Cliq Id--------------///

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validate() {
    if (aliasController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  BehaviorSubject<bool> _isSelectedSubject = BehaviorSubject();

  Stream<bool> get isSelectedStream => _isSelectedSubject.stream;

  void termAndConditionSelected(bool value) {
    _isSelectedSubject.safeAdd(value);
  }
}
