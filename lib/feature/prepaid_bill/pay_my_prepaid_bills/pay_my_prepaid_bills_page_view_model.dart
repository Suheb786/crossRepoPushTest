import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PayMyPrePaidBillsPageViewModel extends BasePageViewModel {
  TextEditingController searchBillController = TextEditingController();
  List<GetPrepaidBillerListModelData>? getPrepaidBillData = [];
  List<GetPrepaidBillerListModelData>? fList = [];
  GetPrepaidBillerListModelData getPrepaidBillerListModelData = GetPrepaidBillerListModelData();
  List<GetPrepaidCategoriesModelData> getPrepaidCategoriesModelData = [];
  bool isPrePaidCategoryEmpty = true;

  final GetPrepaidBillerListUseCase getPrepaidBillerListUseCase;
  final GetPrePaidCategoriesListUseCase getPrePaidCategoriesListUseCase;
  final RemovePrepaidBillerUseCase removePrepaidBillerUseCase;

  PayMyPrePaidBillsPageViewModel(this.getPrepaidBillerListUseCase, this.getPrePaidCategoriesListUseCase,
      this.removePrepaidBillerUseCase) {
    prepaidBillerListener();
    gerPrePaidCategoriesListener();
    removePrepaidBillerListener();
    getPrepaidBiller();
  }

  /// ---------------- Call Api GetPrepaidBillerList -------------------------------- ///

  BehaviorSubject<GetPrepaidBillerListUseCaseParams> _prepaidBillerRequest = BehaviorSubject();
  BehaviorSubject<Resource<GetPrepaidBillerListModel>> _prepaidBillerResponse = BehaviorSubject();

  ////search list
  PublishSubject<Resource<List<GetPrepaidBillerListModelData>?>> _searchPrepaidBillerResponse =
      PublishSubject();

  Stream<Resource<List<GetPrepaidBillerListModelData>?>> get searchPrepaidBillerStream =>
      _searchPrepaidBillerResponse.stream;

  void getPrepaidBiller() {
    _prepaidBillerRequest.safeAdd(GetPrepaidBillerListUseCaseParams());
  }

  void prepaidBillerListener() {
    _prepaidBillerRequest.listen(
      (params) {
        RequestManager(params, createCall: () => getPrepaidBillerListUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _prepaidBillerResponse.safeAdd(event);
          _searchPrepaidBillerResponse.safeAdd(Resource.success(
              data: event.data?.getPrepaidBillerListContent?.getPrepaidBillerListData ?? []));

          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- Call Api GetPrePaidCategoriesList -------------------- ///

  PublishSubject<GetPrePaidCategoriesListUseCaseParams> _gerPrePaidCategoriesRequest = PublishSubject();

  PublishSubject<Resource<GetPrePaidCategoriesModel>> _gerPrePaidCategoriesResponse = PublishSubject();

  Stream<Resource<GetPrePaidCategoriesModel>> get gerPrePaidCategoriesStream =>
      _gerPrePaidCategoriesResponse.stream;

  void getPrePaidCategoriesList(String? serviceCode, String? billerCode) {
    _gerPrePaidCategoriesRequest.safeAdd(
      GetPrePaidCategoriesListUseCaseParams(billerCode: billerCode, serviceCode: serviceCode),
    );
  }

  void gerPrePaidCategoriesListener() {
    _gerPrePaidCategoriesRequest.listen(
      (params) {
        RequestManager(
          params,
          createCall: () => getPrePaidCategoriesListUseCase.execute(params: params),
        ).asFlow().listen((event) {
          updateLoader();
          _gerPrePaidCategoriesResponse.safeAdd(event);

          if (event.status == Status.ERROR) {
            // showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- remove prepaid biller -------------------------------- ///

  PublishSubject<RemovePrepaidBillerUseCaseParams> _removePrepaidBillerRequest = PublishSubject();

  BehaviorSubject<Resource<bool>> _removePrepaidBillerResponse = BehaviorSubject();

  Stream<Resource<bool>> get removePrepaidBillerStream => _removePrepaidBillerResponse.stream;

  void removePrepaidBillerListener() {
    _removePrepaidBillerRequest.listen(
      (params) {
        RequestManager(params, createCall: () => removePrepaidBillerUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();

          _removePrepaidBillerResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
              showSuccessToast('Your bill has been removed.');
            Future.delayed(Duration(milliseconds: 200)).then((value) => getPrepaidBiller());
          }
        });
      },
    );
  }

  void removePrepaidBiller(
    String? registrationID,
  ) {
    _removePrepaidBillerRequest.safeAdd(
      RemovePrepaidBillerUseCaseParams(
        registrationID: registrationID,
      ),
    );
  }

  void searchPrePaidBillerList(String? searchText) {
    if (fList != null && fList!.isNotEmpty) {
      fList!.clear();
    }
    List<GetPrepaidBillerListModelData>? getPrepaidBillerList =
        _prepaidBillerResponse.value.data?.getPrepaidBillerListContent?.getPrepaidBillerListData ?? [];
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < getPrepaidBillerList.length; i++) {
        GetPrepaidBillerListModelData item = getPrepaidBillerList[i];

        /// nickname filter
        if (item.nickname != null && item.nickname!.isNotEmpty) {
          if (item.nickname!.toLowerCase().contains(searchText.toLowerCase())) {
            fList?.add(item);
          }
        }

        /// billerName filter
        if (item.billerName != null && item.billerName!.isNotEmpty) {
          if (item.billerName!.toLowerCase().contains(searchText.toLowerCase())) {
            fList?.add(item);
          }
        }
      }
      fList = fList!.toSet().toList();
      _searchPrepaidBillerResponse.safeAdd(Resource.success(data: fList));
    } else {
      _searchPrepaidBillerResponse.safeAdd(Resource.success(
          data: _prepaidBillerResponse.value.data?.getPrepaidBillerListContent?.getPrepaidBillerListData ??
              []));
    }
  }
}
