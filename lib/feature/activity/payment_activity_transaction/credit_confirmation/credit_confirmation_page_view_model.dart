import 'dart:io';

import 'package:domain/model/cliq/credit_confirmation/credit_confirmation.dart';
import 'package:domain/usecase/manage_cliq/credit_confirmation_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';

class CreditConfirmationPaymentActivityViewModel extends BasePageViewModel {
  final CreditConfirmationArgument creditConfirmationArgument;
  final CreditConfirmationUseCase _creditConfirmationUseCase;

  CreditConfirmationPaymentActivityViewModel(
      this.creditConfirmationArgument, this._creditConfirmationUseCase) {
    _creditConfirmationRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _creditConfirmationUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _creditConfirmationResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            }
          },
        );
      },
    );
  }

  ///*--------------------[Credit Confirmation]---------------------->>>>>>>

  PublishSubject<CreditConfirmationUseCaseParam> _creditConfirmationRequest = PublishSubject();

  PublishSubject<Resource<CreditConfirmation>> _creditConfirmationResponse = PublishSubject();

  Stream<Resource<CreditConfirmation>> get creditConfirmation => _creditConfirmationResponse.stream;

  makeCreditConfirmationRequest({required String msgId}) {
    _creditConfirmationRequest.safeAdd(CreditConfirmationUseCaseParam(msgId: msgId));
  }

  void shareFiles(BuildContext context, File file) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.shareXFiles([XFile(file.path)],
        subject: 'Credit Confirmation PDF', sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
