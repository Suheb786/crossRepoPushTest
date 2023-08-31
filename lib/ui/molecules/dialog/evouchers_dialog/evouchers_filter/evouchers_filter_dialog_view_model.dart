import 'package:domain/constants/enum/evoucher_filter_option_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/e_voucher/voucher_min_max_value.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/usecase/evouchers/evoucher_filter_validation_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_min_max_value_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_region_by_categories_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EVouchersFilterDialogViewModel extends BasePageViewModel {
  ///Controllers and Keys
  TextEditingController categoryController = new TextEditingController();
  GlobalKey<AppTextFieldState> categoryKey = GlobalKey(debugLabel: "category");

  TextEditingController preferredRegionController = new TextEditingController();
  GlobalKey<AppTextFieldState> preferredRegionKey = GlobalKey(debugLabel: "preferredRegion");

  TextEditingController minPriceController = new TextEditingController();
  GlobalKey<AppTextFieldState> minPriceKey = GlobalKey(debugLabel: "minPrice");

  TextEditingController maxPriceController = new TextEditingController();
  GlobalKey<AppTextFieldState> maxPriceKey = GlobalKey(debugLabel: "maxPrice");

  final EVoucherRegionByCategoriesUseCase eVoucherRegionByCategoriesUseCase;
  final EVoucherFilterValidationUseCase eVoucherFilterValidationUseCase;
  final EVoucherMinMaxValueUseCase eVoucherMinMaxValueUseCase;

  EVouchersFilterDialogViewModel(this.eVoucherRegionByCategoriesUseCase, this.eVoucherFilterValidationUseCase,
      this.eVoucherMinMaxValueUseCase) {
   // getRegionByCategoriesSubject();
    getFilterValidationSubject();
    //  getMinMaxValueSubject();
  }

  /// Region By Categories
  PublishSubject<EVoucherRegionByCategoriesUseCaseParams> _voucherRegionByCategoriesRequestSubject =
      PublishSubject();

  PublishSubject<Resource<List<VoucherRegionByCategories>>> _voucherRegionByCategoriesResponseSubject =
      PublishSubject();

  Stream<Resource<List<VoucherRegionByCategories>>> get voucherRegionByCategoriesResponseStream =>
      _voucherRegionByCategoriesResponseSubject.stream;

  getRegionByCategoriesSubject() {
    _voucherRegionByCategoriesRequestSubject.listen((value) {
      RequestManager(value, createCall: () => eVoucherRegionByCategoriesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _voucherRegionByCategoriesResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();

          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {}
      });
    });
  }

  getRegionByCategories(String categoryId) {
    _voucherRegionByCategoriesRequestSubject
        .safeAdd(EVoucherRegionByCategoriesUseCaseParams(category: categoryId));
  }

  /// Filter Validation
  // FilterSelectedData filterSelectedData=FilterSelectedData(categryId: "", region: "", minValue: "", maxValue: "");
  PublishSubject<EVoucherFilterValidationUseCaseParams> _eVoucherFilterValidationRequest = PublishSubject();
  PublishSubject<Resource<bool>> _eVoucherFilterValidationResponse = PublishSubject();

  Stream<Resource<bool>> get eVoucherFilterValidationResponseStream =>
      _eVoucherFilterValidationResponse.stream;

  getFilterValidationSubject() {
    _eVoucherFilterValidationRequest.listen((value) {
      RequestManager(value, createCall: () => eVoucherFilterValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _eVoucherFilterValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showToastWithError(event.appError!);
        }
      });
    });
  }

  getFilterValidated() {
    _eVoucherFilterValidationRequest.safeAdd(EVoucherFilterValidationUseCaseParams(
        category: categoryController.text.trim(),
        region: preferredRegionController.text.trim(),
        minValue: minPriceController.text.trim(),
        maxValue: maxPriceController.text.trim()));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.SELECT_CATEGORY:
        categoryKey.currentState!.isValid = false;
        break;
      case ErrorType.SELECT_REGION:
        preferredRegionKey.currentState!.isValid = false;
        break;
      case ErrorType.SELECT_MIN_VALUE:
        minPriceKey.currentState!.isValid = false;
        break;
      case ErrorType.SELECT_MAX_VALUE:
        maxPriceKey.currentState!.isValid = false;
        break;
      case ErrorType.MAX_VALUE_SHOULD_BE_GREATER_THAN_MIN:
        minPriceKey.currentState!.isValid = false;
        maxPriceKey.currentState!.isValid = false;
        break;

      default:
        break;
    }
  }

  /// Filter Min & Max Value

  PublishSubject<EVoucherMinMaxValueUseCaseParams> _voucherMinMaxValueRequestSubject = PublishSubject();

  PublishSubject<Resource<VoucherMinMaxValue>> _voucherMinMaxValueResponseSubject = PublishSubject();

  Stream<Resource<VoucherMinMaxValue>> get voucherMinMaxResponseStream =>
      _voucherMinMaxValueResponseSubject.stream;

  getMinMaxValueSubject() {
    _voucherMinMaxValueRequestSubject.listen((value) {
      RequestManager(value, createCall: () => eVoucherMinMaxValueUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _voucherMinMaxValueResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();

          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {
          // rangeList.clear();
          //
          // generateListForMinMax(event.data?.minRange ?? 0.0, event.data?.maxRange ?? 0.0);

          //  regionByCategoriesList = event.data ?? [];
        }
      });
    });
  }

  getMinMaxValue(String categoryId, String region) {
    _voucherMinMaxValueRequestSubject
        .safeAdd(EVoucherMinMaxValueUseCaseParams(category: categoryId, region: region));
  }

  String categryId = "";
  String region = "";



  /// button subject
  BehaviorSubject<bool> _showResetButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showResetButtonSubject.stream;

  void showResetFilterButton() {
    if (categoryController.text.isNotEmpty ||
        preferredRegionController.text.isNotEmpty ||
        minPriceController.text.isNotEmpty ||
        maxPriceController.text.isNotEmpty) {
      _showResetButtonSubject.add(true);
    } else {
      _showResetButtonSubject.add(false);
    }
  }

  resetFilter() {
    categoryController.clear();
    preferredRegionController.clear();
    minPriceController.clear();
    maxPriceController.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class FilterSelectedData {
  String categryId;
  String region;
  String minValue;
  String maxValue;
  EvoucherFilterOption filterOption;

  FilterSelectedData(
      {required this.categryId,
      required this.region,
      required this.minValue,
      required this.maxValue,
      required this.filterOption});
}
