import 'package:domain/usecase/dashboard/account_transaction_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/transaction_item.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class AccountTransactionViewModel extends BasePageViewModel {
  AccountTransactionUseCase _useCase;
  TextEditingController searchController = TextEditingController();

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
        amount: "91.92",
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

  List<TransactionItem> tempList = [];

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
    print("_searchlist: ${_searchTextList}");
    _searchTextSubject.safeAdd(_searchTextList);
    if (_searchTextList.isEmpty) {
      searchController.clear();
      _transactionListSubject.safeAdd(transactionList);
    } else if (searchTransactionList.length > 0) {
      print("list: $searchTransactionList");
      _transactionListSubject.safeAdd(searchTransactionList);
    } else {
      if (tempList.isEmpty) {
        searchController.clear();
        _transactionListSubject.safeAdd(transactionList);
      } else {
        searchTransactionList.addAll(tempList);
        _transactionListSubject.safeAdd(searchTransactionList);
      }
    }
  }

  BehaviorSubject<List<TransactionItem>> _transactionListSubject =
      BehaviorSubject();

  Stream<List<TransactionItem>> get transactionListStream =>
      _transactionListSubject.stream;

  BehaviorSubject<List<String>> _searchTextSubject = BehaviorSubject();

  Stream<List<String>> get searchTextStream => _searchTextSubject.stream;

  List<TransactionItem> searchTransactionList = [];

  AccountTransactionViewModel(this._useCase) {
    _transactionListSubject.safeAdd(transactionList);
  }

  onSearchTextChanged(String text) async {
    int flag = 0;
    if (_searchTextList.length > 0) {
      for (int i = 0; i < _searchTextList.length; i++) {
        if (_searchTextList[i] == text) {
          flag = 1;
          break;
        }
      }
    }
    if (flag == 0) {
      if (text.isNotEmpty) {
        if (_searchTextList.length == 0) {
          searchTransactionList.clear();
        }
        List<TransactionItem> searchList = [];
        searchTransactionList.isEmpty
            ? transactionList.forEach((element) {
                if ((element.to!.contains(text) ||
                        element.to!
                            .toLowerCase()
                            .contains(text.toLowerCase())) ||
                    (element.amount!.contains(text) ||
                        element.amount!
                            .toLowerCase()
                            .contains(text.toLowerCase())))
                  searchList.add(element);
              })
            : searchTransactionList.forEach((element) {
                print("for loop");
                if ((element.to!.contains(text) ||
                        element.to!
                            .toLowerCase()
                            .contains(text.toLowerCase())) ||
                    (element.amount!.contains(text) ||
                        element.amount!
                            .toLowerCase()
                            .contains(text.toLowerCase())))
                  searchList.add(element);
              });
        if (searchTransactionList.isNotEmpty)
          tempList.addAll(searchTransactionList);
        else
          tempList.clear();
        searchTransactionList.clear();
        searchTransactionList.addAll(searchList);
        print("searchTransactionList: $searchTransactionList");
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
        _searchTextSubject.safeAdd(_searchTextList);
        print(searchTransactionList.first.to);
      }
    }
  }

  @override
  void dispose() {
    _transactionListSubject.close();
    _searchTextSubject.close();
    super.dispose();
  }
}
