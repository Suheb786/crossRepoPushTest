import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/usecase/card_delivery/get_card_statement_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/download_transaction/download_transaction_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DownloadTransactionViewModel extends BasePageViewModel {
  final GetCardStatementUseCase _cardStatementUseCase;

  final DownloadStatementArguments arguments;

  ///card statement request
  PublishSubject<GetCardStatementUseCaseParams> _cardStatementRequest = PublishSubject();

  ///card statement response
  PublishSubject<Resource<CardStatementResponse>> _cardStatementResponse = PublishSubject();

  ///card statement response stream
  Stream<Resource<CardStatementResponse>> get cardStatementStream => _cardStatementResponse.stream;

  DownloadTransactionViewModel(this._cardStatementUseCase, this.arguments) {
    _cardStatementRequest.listen((value) {
      RequestManager(value, createCall: () => _cardStatementUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _cardStatementResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    getStatements();
  }

  void getStatements() {
    _cardStatementRequest.safeAdd(GetCardStatementUseCaseParams(
        monthYear: arguments.transactionDate,
        statementType: arguments.statementType,
        cardId: arguments.cardId,
        secureCode: arguments.secureCode,
        issuedFromCms: arguments.issuedFromCms));
  }
}
