import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/model/dashboard/transactions/transactions.dart';
import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:domain/usecase/card_delivery/get_debit_card_transactions_usecase.dart';
import 'package:domain/usecase/dashboard/account_transaction_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/transaction_item.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AccountTransactionViewModel extends BasePageViewModel {
  final GetDebitCardTransactionsUseCase _cardTransactionsUseCase;
  AccountTransactionUseCase _useCase;
  TextEditingController searchController = TextEditingController();

  ///get transaction request
  PublishSubject<GetDebitCardTransactionsUseCaseParams>
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
    _searchTextList.removeAt(index);
    if (_searchTextList.isEmpty) {
      _searchTextList.clear();
      _searchTextSubject.add(_searchTextList);
      searchController.clear();
      _getTransactionsResponse.safeAdd(transactionsResponse);
    } else {
      _searchTextSubject.add(_searchTextList);
      _searchTextList.forEach((element) {
        onSearchTextChanged(element, true);
      });
    }
  }

  BehaviorSubject<List<TransactionItem>> _transactionListSubject =
      BehaviorSubject();

  Stream<List<TransactionItem>> get transactionListStream =>
      _transactionListSubject.stream;

  BehaviorSubject<List<String>> _searchTextSubject = BehaviorSubject();

  Stream<List<String>> get searchTextStream => _searchTextSubject.stream;

  List<TransactionContent> searchTransactionList = [];

  AccountTransactionViewModel(this._useCase, this._cardTransactionsUseCase) {
    _getTransactionsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _cardTransactionsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
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

  onSearchTextChanged(String text, [bool? isUpdated = false]) async {
    if (text.isNotEmpty) {
      print("here");
      List<TransactionContent> tempList = [];
      GetTransactionsResponse getTransactionsResponse;
      if (searchTransactionList.isEmpty || isUpdated!) {
        transactionsResponse!.data!.transactionResponse!.forEach((element) {
          int i;
          List<Transactions> searchList = [];
          TransactionContent searchContent;
          GetTransactionsResponse getTransactionsResponse;
          for (i = 0; i < element.transactions!.length; i++) {
            print("description: ${element.transactions![i].description}");
            if ((element.transactions![i].amount
                    .toString()
                    .toLowerCase()
                    .contains(text.toLowerCase())) ||
                (element.transactions![i].description
                    .toString()
                    .toLowerCase()
                    .contains(text.toLowerCase()))) {
              searchList.add(element.transactions![i]);
              print("element found");
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
      } else {
        print("here");
        searchTransactionList.forEach((element) {
          int i;
          print("search transaction : $searchTransactionList}");
          List<Transactions> searchList = [];
          TransactionContent searchContent;
          GetTransactionsResponse getTransactionsResponse;
          for (i = 0; i < element.transactions!.length; i++) {
            if ((element.transactions![i].amount
                    .toString()
                    .toLowerCase()
                    .contains(text.toLowerCase())) ||
                (element.transactions![i].description
                    .toString()
                    .toLowerCase()
                    .contains(text.toLowerCase()))) {
              print("got it");
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
      }
      if (tempList.isNotEmpty) {
        getTransactionsResponse =
            GetTransactionsResponse(transactionResponse: tempList);
        searchTransactionResponse =
            Resource.success(data: getTransactionsResponse);
        _getTransactionsResponse.safeAdd(searchTransactionResponse);
        searchTransactionList = [];
        searchTransactionList.addAll(tempList);
      } else {
        _getTransactionsResponse
            .safeAdd(Resource.none<GetTransactionsResponse>());
      }
    }
  }

  void getTransactions() {
    _getTransactionsRequest.safeAdd(GetDebitCardTransactionsUseCaseParams());
  }

  @override
  void dispose() {
    _transactionListSubject.close();
    _searchTextSubject.close();
    super.dispose();
  }
}
