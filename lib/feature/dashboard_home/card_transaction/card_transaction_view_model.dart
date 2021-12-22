import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
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

  List<TransactionItem> transactionList = [
    TransactionItem(
        createdAt: "12 September 2021",
        to: "Host International Inc Dubai\nAED 533.03",
        amount: "102.92",
        type: "debit",
        time: "8:32 pm"),
    TransactionItem(
        createdAt: "13 September 2021",
        to: "Host International Inc Dubai\nAED 533.03",
        amount: "102.92",
        type: "debit",
        time: "8:32 pm"),
    TransactionItem(
        createdAt: "12 September 2021",
        to: "Ahmed*Abdali Mall\nAED 533.03",
        amount: "102.92",
        type: "debit",
        time: "8:32 pm"),
    TransactionItem(
        createdAt: "13 September 2021",
        to: "Razer*Abdali Mall\nAED 533.03",
        amount: "102.92",
        type: "debit",
        time: "8:32 pm"),
  ];

  List<String> _searchTextList = [];

  void updateSearchList(int index) {
    for (int i = 0; i < searchTransactionList.length; i++) {
      if ((searchTransactionList[i].to!.contains(_searchTextList[index]) ||
              searchTransactionList[i]
                  .to!
                  .toLowerCase()
                  .contains(_searchTextList[index].toLowerCase())) ||
          (searchTransactionList[i].amount!.contains(_searchTextList[index]) ||
              searchTransactionList[i]
                  .amount!
                  .toLowerCase()
                  .contains(_searchTextList[index].toLowerCase()))) {
        searchTransactionList.remove(searchTransactionList[i]);
        break;
      }
    }
    _searchTextList.removeAt(index);
    _searchTextSubject.safeAdd(_searchTextList);
    if (searchTransactionList.length > 0) {
      _transactionListSubject.safeAdd(searchTransactionList);
    } else {
      searchController.clear();
      _transactionListSubject.safeAdd(transactionList);
    }
    print("length ${searchTransactionList.length}");
  }

  BehaviorSubject<List<TransactionItem>> _transactionListSubject =
      BehaviorSubject();

  Stream<List<TransactionItem>> get transactionListStream =>
      _transactionListSubject.stream;

  BehaviorSubject<List<String>> _searchTextSubject = BehaviorSubject();

  Stream<List<String>> get searchTextStream => _searchTextSubject.stream;

  List<TransactionItem> searchTransactionList = [];

  CardTransactionViewModel(this._useCase, this._cardTransactionsUseCase) {
    _transactionListSubject.safeAdd(transactionList);

    _getTransactionsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _cardTransactionsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getTransactionsResponse.safeAdd(event);
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
      List<TransactionItem> searchList = [];
      transactionList.forEach((element) {
        if ((element.to!.contains(text) ||
                element.to!.toLowerCase().contains(text.toLowerCase())) ||
            (element.amount!.contains(text) ||
                element.amount!.toLowerCase().contains(text.toLowerCase())))
          searchList.add(element);
      });
      searchTransactionList.clear();
      searchTransactionList.addAll(searchList);
      _searchTextList.clear();
      if (searchTransactionList.length > 0) {
        _searchTextList.add(text);
      }
      _transactionListSubject.safeAdd(searchTransactionList);
      _searchTextSubject.safeAdd(_searchTextList);
      return;
    } else {
      searchTransactionList.clear();
      searchTransactionList.addAll(transactionList);
      _transactionListSubject.safeAdd(searchTransactionList);
      _searchTextList.clear();
      _searchTextSubject.safeAdd(_searchTextList);
      print(searchTransactionList.first.to);
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
