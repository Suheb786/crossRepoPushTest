import 'dart:async';

import 'package:domain/usecase/card_delivery/confirm_card_delivery_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DebitCardDeliveredViewModel extends BasePageViewModel {
  final TimeLineListArguments debitCard;
  ConfirmCardDeliveryUseCase _confirmCardDeliveryUseCase;

  ///confirm debit card delivery request
  PublishSubject<ConfirmCardDeliveryUseCaseParams> _confirmDebitCardDeliveryRequest = PublishSubject();

  ///confirm debit card delivery response
  PublishSubject<Resource<bool>> _confirmDebitCardDeliveryResponse = PublishSubject();

  ///confirm debit card delivery response stream
  Stream<Resource<bool>> get confirmDebitCardDeliveryStream => _confirmDebitCardDeliveryResponse.stream;

  DebitCardDeliveredViewModel(this._confirmCardDeliveryUseCase, this.debitCard) {
    _confirmDebitCardDeliveryRequest.listen((value) {
      RequestManager(value, createCall: () => _confirmCardDeliveryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _confirmDebitCardDeliveryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void confirmDebitCardDelivery() {
    _confirmDebitCardDeliveryRequest.safeAdd(ConfirmCardDeliveryUseCaseParams());
  }
}
