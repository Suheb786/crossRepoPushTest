import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/usecase/manage_cliq/edit_alias_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import 'edit_alias_page.dart';

class EditAliasPageViewModel extends BasePageViewModel {
  final EditAliasValidationUseCase _editAliasValidationUseCase;
  final EditCliqOtpUseCase _editCliqOtpUseCase;
  final EditAliasPageArguments arguments;

  EditAliasPageViewModel(this._editAliasValidationUseCase, this._editCliqOtpUseCase, this.arguments) {
    aliasController.text = arguments.aliasName;

    /// validation request
    _editAliasValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _editAliasValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _editAliasValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          getError(event);
        }
      });
    });

    ///api calling for otp
    _editCliqOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _editCliqOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _editCliqOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void termAndConditionSelected(bool value) {
    _isSelectedRequest.safeAdd(value);
    _showButtonSubject.safeAdd(value);
  }

  void validate() {
    _editAliasValidationRequest.safeAdd(EditAliasValidationUseCaseParams(
        isSelected: _isSelectedRequest.value, editAlias: aliasController.text));
  }

  void makeOtpRequest({
    required String aliasId,
    required String aliasValue,
    required bool isAlias,
  }) {
    _editCliqOtpRequest.safeAdd(EditCliqOtpUseCaseParams(
      aliasId: aliasId,
      aliasValue: aliasValue,
      isAlias: isAlias,
    ));
  }

  void showBtn() {
    if (aliasController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  /// error indicator in ui

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_ALIAS:
        aliasKey.currentState!.isValid = false;
        break;

      case ErrorType.INVALID_ALIAS_LENGTH:
        aliasKey.currentState!.isValid = false;
        break;

      default:
        break;
    }
  }

  @override
  void dispose() {
    _editAliasValidationRequest.close();
    _editAliasValidationResponse.close();
    _editCliqOtpRequest.close();
    _editCliqOtpResponse.close();
    _isSelectedRequest.close();
    _showButtonSubject.close();

    super.dispose();
  }

  ///--------------------------------------------------variable------------------------------------------------

  ///-------validation request and response

  PublishSubject<EditAliasValidationUseCaseParams> _editAliasValidationRequest = PublishSubject();

  PublishSubject<Resource<bool>> _editAliasValidationResponse = PublishSubject();

  Stream<Resource<bool>> get editAliasValidationResponseStream => _editAliasValidationResponse.stream;

  ///---------for otp subject-----------------------------------

  PublishSubject<EditCliqOtpUseCaseParams> _editCliqOtpRequest = PublishSubject();

  PublishSubject<Resource<EditCliqOtp>> _editCliqOtpResponse = PublishSubject();

  Stream<Resource<EditCliqOtp>> get editCliqIdOtpStream => _editCliqOtpResponse.stream;

  ///  terms and condition request stream
  BehaviorSubject<bool> _isSelectedRequest = BehaviorSubject.seeded(false);

  Stream<bool> get isSelectedStream => _isSelectedRequest.stream;

  /// hide and show btn request and stream

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///controllers and keys
  final TextEditingController aliasController = TextEditingController();
  final GlobalKey<AppTextFieldState> aliasKey = GlobalKey(debugLabel: "alias");
}
