// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/evoucher_by_category_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class EVoucherCategoryListingPageViewModel extends BasePageViewModel {
  // final CategoryListArgument argument;

  EVoucherByCategoryPageUseCase _eVoucherByCategoryPageUseCase;
  TextEditingController categorayListController = TextEditingController();

  /// ------------- voucher categories stream -----------------------
  PublishSubject<EVoucherByCategoryPageUseCaseParams> _voucherByCategoryRequestSubject = PublishSubject();

  /// ------------- voucher by category stream -----------------------
  BehaviorSubject<Resource<List<VoucherItem>>> _voucherByCategoryResponseSubject = BehaviorSubject();

  Stream<Resource<List<VoucherItem>>> get voucherByCategoryResponseStream =>
      _voucherByCategoryResponseSubject.stream;

  late VoucherCategories selectedVoucherCategories;

  List<VoucherItem> voucherItems = [];

  EVoucherCategoryListingPageViewModel(
    this._eVoucherByCategoryPageUseCase,
  ) {
    _voucherByCategoryRequestSubject.listen((value) {
      RequestManager<List<VoucherItem>>(value, createCall: () {
        return _eVoucherByCategoryPageUseCase.execute(params: value);
      }).asFlow().listen((event) {
        if (event.status == Status.SUCCESS) {
          // initial api data...
          voucherItems.clear();
          voucherItems.addAll(event.data ?? []);
        } else if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
        _voucherByCategoryResponseSubject.safeAdd(event);
        updateLoader();
      });
    });

    getVouchersByCategory();
  }

  void getVouchersByCategory() {
    final provider = ProviderScope.containerOf(appLevelKey.currentContext!).read(
      evoucherViewModelProvider,
    );
    selectedVoucherCategories = provider.selectedVoucherCategories;
    _voucherByCategoryRequestSubject.safeAdd(
        EVoucherByCategoryPageUseCaseParams(category: provider.selectedVoucherCategories.categoryName ?? ''));
  }

  void searchItems() {
    if (categorayListController.text.trim().isEmpty) {
      _voucherByCategoryResponseSubject.safeAdd(Resource.success(data: voucherItems));
      return;
    }

    List<VoucherItem> searchedItems = voucherItems
        .where((element) => element.name.toLowerCase().contains(categorayListController.text.trim()))
        .toList();

    _voucherByCategoryResponseSubject.safeAdd(Resource.success(data: searchedItems));
  }
}
