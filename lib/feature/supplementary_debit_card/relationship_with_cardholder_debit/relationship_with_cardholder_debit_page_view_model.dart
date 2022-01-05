import 'package:domain/usecase/card_delivery/relationship_with_card_holder_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RelationshipWithCardholderDebitPageViewModel extends BasePageViewModel {
  final RelationshipWithCardholderUseCase _relationshipWithCardHolderUseCase;

  TextEditingController relationshipController = TextEditingController();

  final GlobalKey<AppTextFieldState> relationshipKey =
      GlobalKey(debugLabel: "relationship");

  List<String> relationship = ["Parent", "Child", "Spouse", "Sibling"];

  /// relationship with card holder request subject holder
  PublishSubject<RelationshipWithCardholderUseCaseParams>
      _relationshipWithCardHolderRequest = PublishSubject();

  /// relationship with card holder response subject holder
  PublishSubject<Resource<bool>> _relationshipWithCardHolderResponse =
      PublishSubject();

  Stream<Resource<bool>> get relationshipWithCardHolderResponseStream =>
      _relationshipWithCardHolderResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  RelationshipWithCardholderDebitPageViewModel(
      this._relationshipWithCardHolderUseCase) {
    _relationshipWithCardHolderRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _relationshipWithCardHolderUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _relationshipWithCardHolderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void relationshipWithCardHolder() {
    _relationshipWithCardHolderRequest.safeAdd(
        RelationshipWithCardholderUseCaseParams(
            relationship: relationshipController.text));
  }

  void validate() {
    bool isValid = false;
    if (relationshipController.text.isNotEmpty) {
      isValid = true;
    }
    _showButtonSubject.safeAdd(isValid);
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _relationshipWithCardHolderRequest.close();
    _relationshipWithCardHolderResponse.close();
    super.dispose();
  }
}
