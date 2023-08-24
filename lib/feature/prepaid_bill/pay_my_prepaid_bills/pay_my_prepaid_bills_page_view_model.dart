import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
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
  final ValidatePrePaidUseCase validatePrePaidUseCase;

  bool showBackButton = false;

  PayMyPrePaidBillsPageViewModel(this.getPrepaidBillerListUseCase, this.getPrePaidCategoriesListUseCase,
      this.removePrepaidBillerUseCase, this.validatePrePaidUseCase) {
    prepaidBillerListener();
    gerPrePaidCategoriesListener();
    removePrepaidBillerListener();
    getPrepaidBiller();
    validatePrePaidBillListener();
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


  setShowBackButton(bool needBackButton) {
    this.showBackButton = needBackButton;
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
        });
      },
    );
  }

  /// ---------------- validate prepaid bill -------------------------------- ///
  PublishSubject<ValidatePrePaidUseCaseParams> _validatePrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<ValidatePrePaidBill>> _validatePrePaidResponse = BehaviorSubject();

  Stream<Resource<ValidatePrePaidBill>> get validatePrePaidStream => _validatePrePaidResponse.stream;

  void validatePrePaidBill() {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("new_pre_paid_inquire_bill", {"new_pre_paid_inquire_bill_call": true});
    _validatePrePaidRequest.safeAdd(ValidatePrePaidUseCaseParams(
        billerCode: getPrepaidBillerListModelData.billerCode,
        amount: isPrePaidCategoryEmpty == true ? double.parse("0").toStringAsFixed(3) : "",
        serviceType: getPrepaidBillerListModelData.serviceType,
        billingNumber: getPrepaidBillerListModelData.billingNumber,
        prepaidCategoryCode: isPrePaidCategoryEmpty == false ? AppConstantsUtils.PREPAID_CATEGORY_CODE : "",
        prepaidCategoryType: isPrePaidCategoryEmpty == false ? AppConstantsUtils.PREPAID_CATEGORY_TYPE : "",
        billingNumberRequired: getPrepaidBillerListModelData.billingNumber != null &&
                getPrepaidBillerListModelData.billingNumber != ""
            ? true
            : false));
  }

  void validatePrePaidBillListener() {
    _validatePrePaidRequest.listen(
      (params) {
        RequestManager(params, createCall: () => validatePrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _validatePrePaidResponse.safeAdd(event);

          if (event.status == Status.ERROR) {
            ///LOG EVENT TO FIREBASE
            FireBaseLogUtil.fireBaseLog(
                "new_pre_paid_inquire_bill_fail_call", {"new_pre_paid_inquire_bill_fail": true});
            showToastWithError(event.appError!);
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
        if (item.billerName != null && item.billerName!.isNotEmpty ||
            item.billerNameAR != null && item.billerNameAR!.isNotEmpty) {
          if (item.billerName!.toLowerCase().contains(searchText.toLowerCase()) ||
              item.billerNameAR!.toLowerCase().contains(searchText.toLowerCase())) {
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
