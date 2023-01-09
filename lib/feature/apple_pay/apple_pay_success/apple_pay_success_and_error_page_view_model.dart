import 'dart:isolate';

import 'package:domain/usecase/apple_pay/get_antelop_cards_list_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

import 'apple_pay_success_and_error_page.dart';

class ApplePaySuccessAndErrorPageViewModel extends BasePageViewModel {
  final ApplePaySuccessAndErrorPageArguments arguments;

  final GetAntelopCardsListUseCase _getAntelopCardsListUseCase;

  ApplePaySuccessAndErrorPageViewModel(this.arguments, this._getAntelopCardsListUseCase) {
    _antelopGetCardsRequest.listen(
      (params) {
        RequestManager(params, createCall: () => _getAntelopCardsListUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          _antelopGetCardResponse.safeAdd(event);
        });
      },
    );
  }

  ///--------------------Antelop Cards List-----------------///
  PublishSubject<GetAntelopCardsListUseCaseParams> _antelopGetCardsRequest = PublishSubject();

  PublishSubject<Resource<bool>> _antelopGetCardResponse = PublishSubject();

  // isolates
  late ReceivePort receivePort;
  Isolate? isolate;

  void getAntelopCards() async {
    if (isolate != null) {
      debugPrint("Isolate not null");
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
}
