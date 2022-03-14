import 'package:domain/model/card/get_credit_card_relationship/credit_card_relationship_respponse.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_relationship_list_usecase.dart';
import 'package:domain/usecase/card_delivery/relationship_with_card_holder_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RelationshipWithCardholderPageViewModel extends BasePageViewModel {
  final RelationshipWithCardholderUseCase _relationshipWithCardHolderUseCase;
  final GetCreditCardRelationshipListUseCase
      _getCreditCardRelationshipListUseCase;

  TextEditingController relationshipController = TextEditingController();

  final GlobalKey<AppTextFieldState> relationshipKey =
      GlobalKey(debugLabel: "relationship");

  List<String> relationship = [];

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

  /// get relationship list holder request subject holder
  PublishSubject<GetCreditCardRelationshipListUseCaseParams>
      _getCreditCardRelationshipListRequest = PublishSubject();

  /// get relationship list response subject holder
  PublishSubject<Resource<CreditCardRelationshipResponse>>
      _getCreditCardRelationshipListResponse = PublishSubject();

  Stream<Resource<CreditCardRelationshipResponse>>
      get getCreditCardRelationshipListResponseStream =>
          _getCreditCardRelationshipListResponse.stream;

  RelationshipWithCardholderPageViewModel(
      this._relationshipWithCardHolderUseCase,
      this._getCreditCardRelationshipListUseCase) {
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

    _getCreditCardRelationshipListRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getCreditCardRelationshipListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getCreditCardRelationshipListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          //relationship = event.data!.cardRelationship!.relationShip ?? [];
          event.data!.cardRelationship!.relationShip!.forEach((element) {
            relationship.add(element.labelEn ?? '');
          });
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

  void getCreditCardRelationship({required String cardId}) {
    _getCreditCardRelationshipListRequest
        .safeAdd(GetCreditCardRelationshipListUseCaseParams(cardId: cardId));
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _relationshipWithCardHolderRequest.close();
    _relationshipWithCardHolderResponse.close();
    super.dispose();
  }
}
