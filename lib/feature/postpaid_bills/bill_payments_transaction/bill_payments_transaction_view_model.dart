import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_data.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_list.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transactions.dart';
import 'package:domain/usecase/bill_payment/bill_payments_transaction_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BillPaymentsTransactionViewModel extends BasePageViewModel {
  BillPaymentsTransactionUseCase _billPaymentsTransactionUseCase;
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool hasMoreData = true;
  int pageNo = 1;
  int pageSize = 10;

  ///get transaction request
  BehaviorSubject<BillPaymentsTransactionUseCaseParams> _getTransactionsRequest = BehaviorSubject();

  ///get transaction response
  BehaviorSubject<Resource<BillPaymentsTransactionModel>> _getTransactionsResponse = BehaviorSubject();

  List<BillPaymentsTransactionData>? allDataList = [];

  ///get transaction response stream
  Stream<Resource<BillPaymentsTransactionModel>> get getTransactionsStream => _getTransactionsResponse.stream;

  Resource<BillPaymentsTransactionModel>? transactionsResponse;

  Resource<BillPaymentsTransactionModel>? searchTransactionResponse;

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

  BehaviorSubject<List<BillPaymentsTransactionList>> _transactionListSubject = BehaviorSubject();

  Stream<List<BillPaymentsTransactionList>> get transactionListStream => _transactionListSubject.stream;

  BehaviorSubject<List<String>> _searchTextSubject = BehaviorSubject();

  Stream<List<String>> get searchTextStream => _searchTextSubject.stream;

  List<BillPaymentsTransactionData> searchTransactionList = [];

  BillPaymentsTransactionViewModel(this._billPaymentsTransactionUseCase) {
    ///getTransactionListener api call
    getTransactionListener();

    ///getTransactions api call
    if (pageNo == 1) getTransactions(pageNo: pageNo, pageSize: pageSize);

    ///searchController api call
    if (searchController.text.isEmpty || searchTextList == null || searchTextList.isEmpty) {
      debugPrint("getMoreScrollListener");
      getMoreScrollListener();
    }
  }

  onSearchTransaction({String? searchText}) {
    searchController.clear();
    List<BillPaymentsTransactionData> tempTransactionList = [];
    List<String> tempSearchTextList = searchTextList;
    if (searchText != null && searchText.isNotEmpty) {
      tempSearchTextList.add(searchText.toLowerCase());
      tempTransactionList = searchTransactionResponse?.data?.billPaymentsTransactionData ?? [];
    } else {
      tempTransactionList = transactionsResponse?.data?.billPaymentsTransactionData ?? [];
    }

    List<BillPaymentsTransactionData> filteredTransactionList = tempTransactionList;

    tempSearchTextList.forEach((tag) {
      List<BillPaymentsTransactionData> tempList = [];

      filteredTransactionList.forEach((element) {
        List<BillPaymentsTransactionList>? nestedFilteredTransaction =
            element.billPaymentsTransactionDataList?.where((transaction) {
          return (((transaction.amount ?? 0.0).toString().toLowerCase().contains(tag.toLowerCase())) ||
              ((transaction.nickname ?? '').toLowerCase().contains(tag.toLowerCase())));
        }).toList();
        if ((nestedFilteredTransaction ?? []).isNotEmpty) {
          BillPaymentsTransactionData content = BillPaymentsTransactionData(
              label: element.label, billPaymentsTransactionDataList: nestedFilteredTransaction);

          tempList.add(content);
        }
      });
      filteredTransactionList = tempList;
    });

    searchTextList = tempSearchTextList;
    _searchTextSubject.add(searchTextList);
    searchTransactionResponse = Resource.success(
        data: BillPaymentsTransactionModel(billPaymentsTransactionData: filteredTransactionList));
    _getTransactionsResponse.add(Resource.success(
        data: BillPaymentsTransactionModel(billPaymentsTransactionData: filteredTransactionList)));
  }

  void getMoreScrollListener() {
    scrollController.addListener(() {
      // Don't call the API again
      if (hasMoreData == false) return;

      // If is scrolled till the end
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // Increment the Page no. for more data
        pageNo++;

        // Call the API for getting more data with
        // incremented Page no.
        if (pageNo > 1 && searchController.text.isEmpty ||
            pageNo > 1 && searchTextList == null ||
            pageNo > 1 && searchTextList.isEmpty) {
          getTransactions(pageNo: pageNo, pageSize: pageSize);
        }
      }
    });
  }

  getTransactionListener() {
    _getTransactionsRequest.listen((value) {
      RequestManager(value, createCall: () => _billPaymentsTransactionUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          hasMoreData = false;
          _getTransactionsResponse.safeAdd(
              Resource.success(data: BillPaymentsTransactionModel(billPaymentsTransactionData: allDataList)));
          transactionsResponse =
              Resource.success(data: BillPaymentsTransactionModel(billPaymentsTransactionData: allDataList));
        } else if (event.status == Status.SUCCESS) {
          bool isContentNull = event.data?.billPaymentsTransactionData == null;

          if (isContentNull) {
            // Don't call the API again
            hasMoreData = false;
            // return;
          }

          var list = event.data?.billPaymentsTransactionData;
          bool isListEmpty = list == null || list.isEmpty || list.length < pageSize;
          if (isListEmpty) {
            // Don't call the API again
            hasMoreData = false;
            // return;
          }
          allDataList?.addAll(list!);
          allDataList = allDataList?.toSet().toList();
          _getTransactionsResponse.safeAdd(
              Resource.success(data: BillPaymentsTransactionModel(billPaymentsTransactionData: allDataList)));
          transactionsResponse =
              Resource.success(data: BillPaymentsTransactionModel(billPaymentsTransactionData: allDataList));
        }
      });
    });
  }

  void getTransactions({num? pageNo: 1, num? pageSize: 10}) {
    debugPrint("getTransactions");
    _getTransactionsRequest.safeAdd(BillPaymentsTransactionUseCaseParams(
        pageNo: pageNo,
        pageSize: pageSize,
        type: AppConstantsUtils.POST_PAID_FLOW == true
            ? AppConstantsUtils.POSTPAID_KEY.toLowerCase()
            : AppConstantsUtils.PREPAID_KEY.toLowerCase()));
  }

  @override
  void dispose() {
    _getTransactionsResponse.close();
    _getTransactionsRequest.close();
    _transactionListSubject.close();
    _searchTextSubject.close();
    super.dispose();
  }
}
