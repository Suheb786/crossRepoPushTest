import 'package:domain/usecase/dashboard/get_card_usecase.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class GetCreditCardViewModel extends BasePageViewModel {
  GetCardUseCase _useCase;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Size deviceSize = Size(0, 0);

  BehaviorSubject<bool> _isGetCardNowClickedSubject = BehaviorSubject.seeded(false);

  Stream<bool> get isGetCardNowClickedStream => _isGetCardNowClickedSubject.stream;

  BehaviorSubject<bool> _flipCardSubject = BehaviorSubject.seeded(false);

  Stream<bool> get flipCardStream => _flipCardSubject.stream;

  GetCreditCardViewModel(this._useCase);

  void updateIsGetCardNowClicked(bool value) {
    _isGetCardNowClickedSubject.safeAdd(value);
  }

  void updateFlipCardStream(bool value) {
    _flipCardSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _isGetCardNowClickedSubject.close();
    super.dispose();
  }
}
