import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/model/dashboard/transactions/transactions.dart';
import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:domain/usecase/card_delivery/get_credit_card_transactions_usecase.dart';
import 'package:domain/usecase/dashboard/card_transaction_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/transaction_item.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CardTransactionViewModel extends BasePageViewModel {
  CardTransactionUseCase _useCase;
  final GetCreditCardTransactionsUseCase _cardTransactionsUseCase;
  TextEditingController searchController = TextEditingController();

  ///get transaction request
  PublishSubject<GetCreditCardTransactionsUseCaseParams>
      _getTransactionsRequest = PublishSubject();

  ///get transaction response
  PublishSubject<Resource<GetTransactionsResponse>> _getTransactionsResponse =
      PublishSubject();

  ///get transaction response stream
  Stream<Resource<GetTransactionsResponse>> get getTransactionsStream =>
      _getTransactionsResponse.stream;

  Resource<GetTransactionsResponse>? transactionsResponse;

  Resource<GetTransactionsResponse>? searchTransactionResponse;

  List<GetTransactionsResponse> transactionList = [];

  List<String> _searchTextList = [];

  void updateSearchList(int index) {
    _searchTextList.clear();
    _searchTextSubject.add(_searchTextList);
    searchController.clear();
    _getTransactionsResponse.safeAdd(transactionsResponse);
  }

  BehaviorSubject<List<TransactionItem>> _transactionListSubject =
      BehaviorSubject();

  Stream<List<TransactionItem>> get transactionListStream =>
      _transactionListSubject.stream;

  BehaviorSubject<List<String>> _searchTextSubject = BehaviorSubject();

  Stream<List<String>> get searchTextStream => _searchTextSubject.stream;

  List<GetTransactionsResponse> searchTransactionList = [];

  CardTransactionViewModel(this._useCase, this._cardTransactionsUseCase) {
    // _transactionListSubject.safeAdd(transactionList);

    _getTransactionsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _cardTransactionsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        transactionList.add(event.data!);
        _getTransactionsResponse.safeAdd(event);
        transactionsResponse = event;
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    getTransactions();
  }

  onSearchTextChanged(String text) async {
    if (text.isNotEmpty) {
      List<TransactionContent> tempList = [];
      GetTransactionsResponse getTransactionsResponse;
      transactionsResponse!.data!.transactionResponse!.forEach((element) {
        int i;
        List<Transactions> searchList = [];
        TransactionContent searchContent;
        GetTransactionsResponse getTransactionsResponse;
        for (i = 0; i < element.transactions!.length; i++) {
          if ((element.transactions![i].amount.toString().toLowerCase() ==
                  text.toLowerCase()) ||
              (element.transactions![i].description.toString().toLowerCase() ==
                  text.toLowerCase())) {
            searchList.add(element.transactions![i]);
            if (_searchTextList.isEmpty) {
              _searchTextList.add(text);
              _searchTextSubject.safeAdd(_searchTextList);
            } else {
              int flag = 0;
              for (int i = 0; i < _searchTextList.length; i++) {
                if (_searchTextList[i].toLowerCase() == text.toLowerCase()) {
                  flag = 1;
                  break;
                }
              }
              if (flag == 0) {
                _searchTextList.add(text);
                _searchTextSubject.safeAdd(_searchTextList);
              }
            }
          }
        }
        if (searchList.isNotEmpty) {
          searchContent = TransactionContent(
              label: element.label!, transactions: searchList);
          tempList.add(searchContent);
        }
      });
      if (tempList.isNotEmpty) {
        getTransactionsResponse =
            GetTransactionsResponse(transactionResponse: tempList);
        searchTransactionResponse =
            Resource.success(data: getTransactionsResponse);
        _getTransactionsResponse.safeAdd(searchTransactionResponse);
      } else {
        _getTransactionsResponse.safeAdd(transactionsResponse);
      }
    }
  }

  void getTransactions() {
    _getTransactionsRequest.safeAdd(GetCreditCardTransactionsUseCaseParams());
  }

  @override
  void dispose() {
    _transactionListSubject.close();
    _searchTextSubject.close();
    super.dispose();
  }
}
