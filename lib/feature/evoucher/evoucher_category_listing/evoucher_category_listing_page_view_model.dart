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

  ValueNotifier<bool> searchListToggleNotifier = ValueNotifier(true);
  ValueNotifier<bool> categoriesDisplayToggleNotifier = ValueNotifier(true);

  /// ------------- voucher filter stream -----------------------

  List<VoucherItem> filterList = [];

  PublishSubject<EVoucherItemFilterUseCaseParams> _voucherItemFilterRequestSubject = PublishSubject();

  PublishSubject<Resource<List<VoucherItem>>> voucherItemFilterResponseSubject = PublishSubject();

  Stream<Resource<List<VoucherItem>>> get voucherItemFilterResponseStream =>
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

  EVoucherCategoryListingPageViewModel(this.argument, this.eVoucherItemFilterUseCase) {
    _voucherItemFilterRequestSubject.listen((value) {
      RequestManager(value, createCall: () => eVoucherItemFilterUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        voucherItemFilterResponseSubject.safeAdd(event);
        categoriesDisplayToggleNotifier.value = false;
        if (event.status == Status.ERROR) {
          showErrorState();

          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {
          voucherItems.clear();
          voucherItems.addAll(event.data ?? []);
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
      voucherItemFilterResponseSubject.safeAdd(Resource.success(data: voucherItems));
    } else {
      List<VoucherItem> searchedItems = voucherItems
          .where((element) => element.name.toLowerCase().contains(categorayListController.text.trim()))
          .toList();
      voucherItemFilterResponseSubject.safeAdd(Resource.success(data: searchedItems));
    }
  }

  getError(Resource<List<VoucherItem>> event) {
    if (categorayListController.text.trim().isEmpty) {
      voucherItemFilterResponseSubject.safeAdd(Resource.error(data: event.appError));
    }
  }
}
