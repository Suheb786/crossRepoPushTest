import 'package:domain/model/user/scanned_document_information.dart';
import 'package:domain/usecase/card_delivery/apply_supplementary_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/personalize_debit_card_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PersonalizeDebitCardPageViewModel extends BasePageViewModel {
  final PersonalizeDebitCardUseCase _personalizeDebitCardUseCase;
  final ApplySupplementaryDebitCardUseCase _applySupplementaryDebitCardUseCase;

  TextEditingController nicknameController = TextEditingController();

  final GlobalKey<AppTextFieldState> nicknameKey =
      GlobalKey(debugLabel: "nickname");

  /// personalize debit card request subject holder
  PublishSubject<PersonalizeDebitCardUseCaseParams>
      _personalizeDebitCardRequest = PublishSubject();

  /// personalize debit card response subject holder
  PublishSubject<Resource<bool>> _personalizeDebitCardResponse =
      PublishSubject();

  Stream<Resource<bool>> get personalizeDebitCardResponseStream =>
      _personalizeDebitCardResponse.stream;

  /// apply supplementary debit card request subject holder
  PublishSubject<ApplySupplementaryDebitCardUseCaseParams>
      _applySupplementaryDebitCardRequest = PublishSubject();

  /// apply supplementary debit card response subject holder
  PublishSubject<Resource<bool>> _applySupplementaryDebitCardResponse =
      PublishSubject();

  ///apply supplementary debit card response stream
  Stream<Resource<bool>> get applySupplementaryDebitCardResponseStream =>
      _applySupplementaryDebitCardResponse.stream;

  PersonalizeDebitCardPageViewModel(this._personalizeDebitCardUseCase,
      this._applySupplementaryDebitCardUseCase) {
    _personalizeDebitCardRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _personalizeDebitCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _personalizeDebitCardResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _applySupplementaryDebitCardRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _applySupplementaryDebitCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _applySupplementaryDebitCardResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void personalizeDebitCard() {
    _personalizeDebitCardRequest.safeAdd(
        PersonalizeDebitCardUseCaseParams(nickname: nicknameController.text));
  }

  void applySupplementaryDebitCard(String relationship,
      ScannedDocumentInformation scannedDocumentInformation) {
    _applySupplementaryDebitCardRequest.safeAdd(
        ApplySupplementaryDebitCardUseCaseParams(
            nickName: nicknameController.text,
            relationship: relationship,
            scannedDocumentInformation: scannedDocumentInformation));
  }

  @override
  void dispose() {
    _personalizeDebitCardRequest.close();
    _personalizeDebitCardResponse.close();
    super.dispose();
  }
}
