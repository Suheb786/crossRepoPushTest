import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transactions.dart';
import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:domain/usecase/bill_payment/bill_payments_transaction_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/transaction_item.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BillPaymentsTransactionViewModel extends BasePageViewModel {
  BillPaymentsTransactionUseCase _billPaymentsTransactionUseCase;
  TextEditingController searchController = TextEditingController();

  ///get transaction request
  PublishSubject<BillPaymentsTransactionUseCaseParams> _getTransactionsRequest = PublishSubject();

  ///get transaction response
  PublishSubject<Resource<BillPaymentsTransactionModel>> _getTransactionsResponse = PublishSubject();

  ///get transaction response stream
  Stream<Resource<BillPaymentsTransactionModel>> get getTransactionsStream => _getTransactionsResponse.stream;

  Resource<BillPaymentsTransactionModel>? transactionsResponse;

  Resource<BillPaymentsTransactionModel>? searchTransactionResponse;

  List<BillPaymentsTransactionModel> transactionList = [];

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

  BehaviorSubject<List<TransactionItem>> _transactionListSubject = BehaviorSubject();

  Stream<List<TransactionItem>> get transactionListStream => _transactionListSubject.stream;

  BehaviorSubject<List<String>> _searchTextSubject = BehaviorSubject();

  Stream<List<String>> get searchTextStream => _searchTextSubject.stream;

  List<TransactionContent> searchTransactionList = [];

  BillPaymentsTransactionViewModel(this._billPaymentsTransactionUseCase) {
    _getTransactionsRequest.listen((value) {
      RequestManager(value, createCall: () => _billPaymentsTransactionUseCase.execute(params: value))
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

    getTransactions(pageNo: 1, pageSize: 10);
  }

  onSearchTextChanged(String text, [bool? isUpdated = false]) async {
    // if (text.isNotEmpty) {
    //   print("here");
    //   List<TransactionContent> tempList = [];
    //   BillPaymentsTransactionModel getTransactionsResponse;
    //   if (searchTransactionList.isEmpty || isUpdated!) {
    //     transactionsResponse!.data!.billPaymentsTransactionData?.billPaymentsTransactionDataList?.forEach((element) {
    //       int i;
    //       List<Transactions> searchList = [];
    //       TransactionContent searchContent;
    //       BillPaymentsTransactionModel getTransactionsResponse;
    //       for (i = 0; i < element.transactions!.length; i++) {
    //         print("description: ${element.transactions![i].description}");
    //         if ((element.transactions![i].amount.toString().toLowerCase().contains(text.toLowerCase())) ||
    //             (element.transactions![i].description
    //                 .toString()
    //                 .toLowerCase()
    //                 .contains(text.toLowerCase()))) {
    //           searchList.add(element.transactions![i]);
    //           print("element found");
    //           if (_searchTextList.isEmpty) {
    //             _searchTextList.add(text);
    //             _searchTextSubject.safeAdd(_searchTextList);
    //           } else {
    //             int flag = 0;
    //             for (int i = 0; i < _searchTextList.length; i++) {
    //               if (_searchTextList[i].toLowerCase() == text.toLowerCase()) {
    //                 flag = 1;
    //                 break;
    //               }
    //             }
    //             if (flag == 0) {
    //               _searchTextList.add(text);
    //               _searchTextSubject.safeAdd(_searchTextList);
    //             }
    //           }
    //         }
    //       }
    //       if (searchList.isNotEmpty) {
    //         searchContent = TransactionContent(label: element.label!, transactions: searchList);
    //         tempList.add(searchContent);
    //       }
    //     });
    //   } else {
    //     print("here");
    //     searchTransactionList.forEach((element) {
    //       int i;
    //       print("search transaction : $searchTransactionList}");
    //       List<Transactions> searchList = [];
    //       TransactionContent searchContent;
    //       GetTransactionsResponse getTransactionsResponse;
    //       for (i = 0; i < element.transactions!.length; i++) {
    //         if ((element.transactions![i].amount.toString().toLowerCase().contains(text.toLowerCase())) ||
    //             (element.transactions![i].description
    //                 .toString()
    //                 .toLowerCase()
    //                 .contains(text.toLowerCase()))) {
    //           print("got it");
    //           searchList.add(element.transactions![i]);
    //           if (_searchTextList.isEmpty) {
    //             _searchTextList.add(text);
    //             _searchTextSubject.safeAdd(_searchTextList);
    //           } else {
    //             int flag = 0;
    //             for (int i = 0; i < _searchTextList.length; i++) {
    //               if (_searchTextList[i].toLowerCase() == text.toLowerCase()) {
    //                 flag = 1;
    //                 break;
    //               }
    //             }
    //             if (flag == 0) {
    //               _searchTextList.add(text);
    //               _searchTextSubject.safeAdd(_searchTextList);
    //             }
    //           }
    //         }
    //       }
    //       if (searchList.isNotEmpty) {
    //         searchContent = TransactionContent(label: element.label!, transactions: searchList);
    //         tempList.add(searchContent);
    //       }
    //     });
    //   }
    //   if (tempList.isNotEmpty) {
    //     getTransactionsResponse = GetTransactionsResponse(transactionResponse: tempList);
    //     searchTransactionResponse = Resource.success(data: getTransactionsResponse);
    //     _getTransactionsResponse.safeAdd(searchTransactionResponse);
    //     searchTransactionList = [];
    //     searchTransactionList.addAll(tempList);
    //   } else {
    //     _getTransactionsResponse.safeAdd(Resource.none<GetTransactionsResponse>());
    //   }
    // }
  }

  void getTransactions({num? pageNo: 1, num? pageSize: 10}) {
    _getTransactionsRequest.safeAdd(BillPaymentsTransactionUseCaseParams(
        pageNo: pageNo,
        pageSize: pageSize,
        type: AppConstantsUtils.POST_PAID_FLOW == true
            ? AppConstantsUtils.POSTPAID_KEY.toLowerCase()
            : AppConstantsUtils.PREPAID_KEY.toLowerCase()));
  }

  void getFilteredData(String value) {
    // getTransactions(pageNo: 1, pageSize: 10);
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

  @override
  void dispose() {
    _transactionListSubject.close();
    _searchTextSubject.close();
    super.dispose();
  }
}
