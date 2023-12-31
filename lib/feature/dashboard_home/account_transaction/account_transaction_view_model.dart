import 'package:domain/model/card/get_debit_years_response.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/model/dashboard/transactions/transactions.dart';
import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:domain/usecase/card_delivery/get_debit_card_transactions_usecase.dart';
import 'package:domain/usecase/card_delivery/get_debit_years_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/transaction_item.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import 'account_transaction_page.dart';

class AccountTransactionViewModel extends BasePageViewModel {
  final AccountTransactionPageArgument argument;
  final GetDebitCardTransactionsUseCase _cardTransactionsUseCase;
  final GetDebitYearsUseCase _debitYearsUseCase;
  TextEditingController searchController = TextEditingController();

  bool hasTransactions = false;
  bool hasDebitYears = false;

  ///get transaction request
  PublishSubject<GetDebitCardTransactionsUseCaseParams> _getTransactionsRequest = PublishSubject();

  ///get transaction response
  PublishSubject<Resource<GetTransactionsResponse>> _getTransactionsResponse = PublishSubject();

  ///get transaction response stream
  Stream<Resource<GetTransactionsResponse>> get getTransactionsStream => _getTransactionsResponse.stream;

  Resource<GetTransactionsResponse>? transactionsResponse;

  Resource<GetTransactionsResponse>? searchTransactionResponse;

  List<GetTransactionsResponse> transactionList = [];

  ///get debit years
  PublishSubject<GetDebitYearsUseCaseParams> _getDebitYearsRequest = PublishSubject();

  ///get debit response
  PublishSubject<Resource<GetDebitYearsResponse>> _getDebitYearsResponse = PublishSubject();

  ///get debit response stream
  Stream<Resource<GetDebitYearsResponse>> get getDebitYearsStream => _getDebitYearsResponse.stream;

  List<String> searchTextList = [];

  void updateSearchList(int index) {
    searchTextList.removeAt(index);
    if (searchTextList.isEmpty) {
      searchTextList.clear();
      _searchTextSubject.add(searchTextList);
      searchController.clear();
      searchTransactionResponse = transactionsResponse;
      _getTransactionsResponse.safeAdd(transactionsResponse);
    } else {
      onSearchTransaction();
    }
  }

  BehaviorSubject<List<TransactionItem>> _transactionListSubject = BehaviorSubject();

  Stream<List<TransactionItem>> get transactionListStream => _transactionListSubject.stream;

  BehaviorSubject<List<String>> _searchTextSubject = BehaviorSubject();

  Stream<List<String>> get searchTextStream => _searchTextSubject.stream;

  List<TransactionContent> searchTransactionList = [];

  AccountTransactionViewModel(this._cardTransactionsUseCase, this._debitYearsUseCase, this.argument) {
    _getTransactionsRequest.listen((value) {
      RequestManager(value, createCall: () => _cardTransactionsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getTransactionsResponse.safeAdd(event);
        transactionsResponse = event;
        searchTransactionResponse = event;
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          onSearchTransaction();
          hasTransactions = event.data?.transactionResponse?.isEmpty == false;
          _getDebitYearsRequest.safeAdd(GetDebitYearsUseCaseParams());
        }
      });
    });

    _getDebitYearsRequest.listen((value) {
      RequestManager(value, createCall: () => _debitYearsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getDebitYearsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          hasDebitYears = event.data?.years.isEmpty == false;
        }
      });
    });

    getTransactions(noOfDays: 180, accountNo: argument.accountNo);
  }

  onSearchTransaction({String? searchText}) {
    searchController.clear();
    List<TransactionContent> tempTransactionList = [];
    List<String> tempSearchTextList = searchTextList;
    if (searchText != null && searchText.isNotEmpty) {
      tempSearchTextList.add(searchText.toLowerCase());
      tempTransactionList = searchTransactionResponse?.data?.transactionResponse ?? [];
    } else {
      tempTransactionList = transactionsResponse?.data?.transactionResponse ?? [];
    }

    List<TransactionContent> filteredTransactionList = tempTransactionList;

    tempSearchTextList.forEach((tag) {
      List<TransactionContent> tempList = [];

      filteredTransactionList.forEach((element) {
        List<Transactions>? nestedFilteredTransaction = element.transactions?.where((transaction) {
          return (((transaction.amount ?? 0.0).toString().toLowerCase().contains(tag.toLowerCase())) ||
              ((transaction.description ?? '').toLowerCase().contains(tag.toLowerCase())));
        }).toList();
        if ((nestedFilteredTransaction ?? []).isNotEmpty) {
          TransactionContent content =
              TransactionContent(label: element.label, transactions: nestedFilteredTransaction);

          tempList.add(content);
        }
      });

      filteredTransactionList = tempList;
    });

    searchTextList = tempSearchTextList;
    _searchTextSubject.add(searchTextList);
    searchTransactionResponse =
        Resource.success(data: GetTransactionsResponse(transactionResponse: filteredTransactionList));
    _getTransactionsResponse
        .add(Resource.success(data: GetTransactionsResponse(transactionResponse: filteredTransactionList)));
  }

  void getTransactions({num? noOfDays, String? accountNo}) {
    _getTransactionsRequest
        .safeAdd(GetDebitCardTransactionsUseCaseParams(accountNo: accountNo, noOfDays: noOfDays ?? 180));
  }

  void getFilteredData(String value, accountNo) {
    getTransactions(noOfDays: getFilterDays(value), accountNo: accountNo);
  }

  int getFilterDays(String value) {
    switch (value) {
      case "Last 30 days":
        return 30;
      case "Last 3 months":
        return 90;
      case "Last 6 months":
        return 180;
      case "آخر 30 يوم":
        return 30;
      case "آخر 3 اشهر":
        return 90;
      case "آخر 6 اشهر":
        return 180;
      default:
        return 180;
    }
  }

  void animateBackToDashboard(BuildContext context) {
    final dashboardProvider = ProviderScope.containerOf(context).read(
      appHomeViewModelProvider,
    );

    dashboardProvider.animateReverseTransactionPage();
  }

  @override
  void dispose() {
    _getTransactionsRequest.close();
    _getTransactionsResponse.close();
    _transactionListSubject.close();
    _searchTextSubject.close();
    super.dispose();
  }
}
