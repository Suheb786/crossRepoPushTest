import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/evoucher_item_filter_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EVoucherCategoryListingPageViewModel extends BasePageViewModel {
  final CategoryListArgument argument;
  EVoucherItemFilterUseCase eVoucherItemFilterUseCase;

  TextEditingController categorayListController = TextEditingController();

  /// ------------- voucher filter stream -----------------------

  List<VoucherItem> filterList = [];

  PublishSubject<EVoucherItemFilterUseCaseParams> _voucherItemFilterRequestSubject = PublishSubject();

  PublishSubject<Resource<List<List<VoucherItem>>>> voucherItemFilterResponseSubject = PublishSubject();

  Stream<Resource<List<List<VoucherItem>>>> get voucherItemFilterResponseStream =>
      voucherItemFilterResponseSubject.stream;

  void getVoucherItemFilter(
      {required String category,
      required String region,
      required num maxValue,
      required num minValue,
      required String searchText}) {
    _voucherItemFilterRequestSubject.safeAdd(EVoucherItemFilterUseCaseParams(
        category: category, region: region, maxValue: maxValue, minValue: minValue, searchText: searchText));
  }

  late VoucherCategories selectedVoucherCategories;

  List<VoucherItem> voucherItems = [];
  List<List<VoucherItem>> filteredVoucherItems = [];

  EVoucherCategoryListingPageViewModel(this.argument, this.eVoucherItemFilterUseCase) {
    _voucherItemFilterRequestSubject.listen((value) {
      RequestManager(value, createCall: () => eVoucherItemFilterUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {
          voucherItems.clear();
          voucherItems.addAll(event.data ?? []);
          Map<String, dynamic> allData = {};
          voucherItems.forEach((voucher) {
            if (allData.isEmpty) {
              allData[voucher.brand] = [voucher];
            } else {
              if (allData.containsKey(voucher.brand)) {
                var models = allData[voucher.brand] as List<VoucherItem>;
                models.add(voucher);
                allData[voucher.brand] = models;
              } else {
                allData[voucher.brand] = [voucher];
              }
            }
          });
          List<List<VoucherItem>> filteredElements = [];

          allData.values.forEach((element) {
            filteredElements.add(element);
          });
          filteredVoucherItems = filteredElements;
          voucherItemFilterResponseSubject.safeAdd(Resource.success(data: filteredElements));
        }
      });
    });
    getVoucherItemFilter(
      category: argument.id.toString(),
      region: '',
      maxValue: 0.0,
      minValue: 0.0,
      searchText: "",
    );
  }

  void searchItems() {
    if (categorayListController.text.trim().isEmpty) {
      voucherItemFilterResponseSubject.safeAdd(Resource.success(data: filteredVoucherItems));
    } else {
      List<List<VoucherItem>> searchedItems = filteredVoucherItems
          .where((element) =>
              element.first.name.toLowerCase().contains(categorayListController.text.toLowerCase().trim()))
          .toList();
      voucherItemFilterResponseSubject.safeAdd(Resource.success(data: searchedItems));
    }
  }
}
