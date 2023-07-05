import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history_content.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history_response.dart';
import 'package:domain/usecase/manage_contacts/beneficiary_transaction_history_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'beneficiary_transaction_history_list_page.dart';

class BeneficiaryTransactionHistoryListPageViewModel extends BasePageViewModel {
  List<Beneficiary>? searchResult = [];
  final BeneficiaryTransactionHistoryListPageArguments arguments;
  final BeneficiaryTransactionHistoryUseCase _getBeneficiaryUseCase;
  int filterDay = 180;
  int pageNo = 1;
  bool hasMore = true;
  List<BeneficiaryTransactionHistoryContent>? allDataList = [];
  final ScrollController listController = ScrollController();
  final TextEditingController contactSearchController = TextEditingController();

  ///--------------------------get-beneficiary-list-----------------------------------------///
  PublishSubject<BeneficiaryTransactionHistoryUseCaseParams> _getBeneficiaryListRequest = PublishSubject();
  BehaviorSubject<Resource<BeneficiaryTransactionHistoryResponse>> _getBeneficiaryListResponse =
      BehaviorSubject();

  Stream<Resource<BeneficiaryTransactionHistoryResponse>> get getBeneficiaryListStream =>
      _getBeneficiaryListResponse.stream;

  ///---------------------------search-beneficiary-list---------------------------------///

  // Stream<Resource<List<Beneficiary>>> get getBeneficiaryListStream => _searchBeneficiaryListResponse.stream;
  BehaviorSubject<Resource<List<Beneficiary>>> _searchBeneficiaryListResponse = BehaviorSubject();

  ///--------------------------public-other-methods-------------------------------------///
  /* void searchBeneficiary(String? searchText) {
    searchResult!.clear();
    List<Beneficiary>? beneficiaryList = _getBeneficiaryListResponse.value.data!.beneficiaryList;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < beneficiaryList!.length; i++) {
        Beneficiary beneficiary = beneficiaryList[i];
        if (beneficiary.nickName != null) {
          if (beneficiary.nickName!.toLowerCase().contains(searchText.toLowerCase())) {
            searchResult!.add(beneficiary);
          }
        }
      }
      _searchBeneficiaryListResponse.safeAdd(Resource.success(data: searchResult));
    } else {
      _searchBeneficiaryListResponse
          .safeAdd(Resource.success(data: _getBeneficiaryListResponse.value.data!.beneficiaryList));
    }
  }*/

  void getBeneficiaryList(BeneficiaryTransactionHistoryListPageArguments arguments) {
    _getBeneficiaryListRequest.listen((value) {
      RequestManager(value, createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        //   _getBeneficiaryListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          hasMore = false;
          _getBeneficiaryListResponse.safeAdd(event);
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          if ((event.data?.beneficiaryTransactionHistoryContent ?? []).isNotEmpty) {
            hasMore = true;

            var list = event.data?.beneficiaryTransactionHistoryContent ?? [];
            if (allDataList == null || allDataList!.isEmpty) {
              allDataList?.addAll(list);
            } else {
              if (TimeUtils.getFormattedDateMonth(allDataList?.last.date ?? "") ==
                  TimeUtils.getFormattedDateMonth(list.first.date ?? "")) {
                allDataList?.last.data?.addAll(list.first.data ?? []);
              } else {
                allDataList?.addAll(list);
              }
            }
            allDataList = allDataList?.toSet().toList();

            _getBeneficiaryListResponse.safeAdd(Resource.success(
                data: BeneficiaryTransactionHistoryResponse(
                    beneficiaryTransactionHistoryContent: allDataList)));
          } else {
            hasMore = false;
            //   pageNo--;
            if (pageNo == 1 && (event.data?.beneficiaryTransactionHistoryContent ?? []).isEmpty) {
              _getBeneficiaryListResponse.safeAdd(Resource.success(
                  data: BeneficiaryTransactionHistoryResponse(
                      beneficiaryTransactionHistoryContent: allDataList)));
            }
          }

          //   _searchBeneficiaryListResponse.safeAdd(Resource.success(data: event.data));
        }
      });
    });

    ///for catching end of scrollView
    listController.addListener(() {
      if (listController.position.pixels == listController.position.maxScrollExtent) {
        if (hasMore) {
          pageNo++;
          getTransactions(
              beneficiaryId: arguments.beneficiaryId,
              filterDays: filterDay,
              searchText: contactSearchController.text,
              pageNo: pageNo);
        }
      }
    });

    getTransactions(beneficiaryId: arguments.beneficiaryId);
  }

  ///--------------------------public-override-methods-------------------------------------///

  @override
  void dispose() {
    _getBeneficiaryListRequest.close();
    _getBeneficiaryListResponse.close();
    _searchBeneficiaryListResponse.close();
    super.dispose();
  }

  ///--------------------------public-constructor-------------------------------------///

  BeneficiaryTransactionHistoryListPageViewModel(this._getBeneficiaryUseCase, this.arguments) {
    getBeneficiaryList(this.arguments);
  }

  void getTransactions(
      {required String beneficiaryId, int filterDays = 180, String searchText = '', int pageNo = 1}) {
    _getBeneficiaryListRequest.safeAdd(BeneficiaryTransactionHistoryUseCaseParams(
        filterDays: filterDays,
        beneficiaryId: beneficiaryId,
        transactionType: 'ALL',
        totalRecords: '10',
        pageNo: pageNo,
        searchText: searchText));
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
}
