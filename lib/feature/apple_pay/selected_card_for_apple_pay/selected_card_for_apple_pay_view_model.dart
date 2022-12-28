import 'dart:isolate';

import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:domain/usecase/apple_pay/get_antelop_cards_list_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class SelectedCardForApplePayPageViewModel extends BasePageViewModel {
  final SelectedCardsForApplePayPageArguments arguments;
  final GetAntelopCardsListUseCase _getAntelopCardsListUseCase;

  SelectedCardForApplePayPageViewModel(this.arguments, this._getAntelopCardsListUseCase) {
    _antelopGetCardsRequest.listen(
      (params) {
        RequestManager(params, createCall: () => _getAntelopCardsListUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          _antelopGetCardResponse.safeAdd(event);
        });
      },
    );

    getAntelopCards();
  }

  ScrollController scrollController = ScrollController();

  BehaviorSubject<CardTypeData> cardsListSubject = BehaviorSubject.seeded(CardTypeData());

  Stream<CardTypeData> get cardListStream => cardsListSubject.stream;

  void addCardList(CardTypeData cardTypeData) {
    cardsListSubject.safeAdd(cardTypeData);
  }

  ///--------------------Antelop Cards List-----------------///
  PublishSubject<GetAntelopCardsListUseCaseParams> _antelopGetCardsRequest = PublishSubject();

  PublishSubject<Resource<bool>> _antelopGetCardResponse = PublishSubject();

  // isolates
  late ReceivePort receivePort;
  Isolate? isolate;

  void getAntelopCards() async {
    if (isolate != null) {
      return;
    }
    try {
      receivePort = ReceivePort();
      isolate = await Isolate.spawn(_getTokenCallBack, receivePort.sendPort);
      receivePort.listen(_handleMessage, onDone: () {});
    } on Exception catch (e) {
      debugPrint("isolate catch section " + e.toString());
    }
  }

  static void _getTokenCallBack(SendPort sendPort) async {
    sendPort.send('Send');
  }

  void _handleMessage(message) {
    _antelopGetCardsRequest.safeAdd(GetAntelopCardsListUseCaseParams());
  }

  ///--------------------Antelop Cards List-----------------///

  @override
  void dispose() {
    super.dispose();
  }
}

class CardTypeData {
  final List<CreditCard>? creditCards;
  final List<DebitCard>? debitCards;

  CardTypeData({this.creditCards, this.debitCards});
}
