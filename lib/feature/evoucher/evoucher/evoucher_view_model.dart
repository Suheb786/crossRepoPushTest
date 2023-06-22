import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/evoucher_landing_page_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EvoucherViewModel extends BasePageViewModel {
  TextEditingController myVoucherSearchController = TextEditingController();
  TextEditingController buyVoucherSearchController = TextEditingController();

  EVoucherLandingPageUseCase _eVoucherLandingPageUseCase;

  ValueNotifier<bool> categoriesDisplayToggleNotifier =
      ValueNotifier(true); // default true as showing categories

  late VoucherCategories selectedVoucherCategories;

  /// ------------- voucher categories stream -----------------------
  PublishSubject<EVoucherLandingPageUseCaseParams> _voucherLandingPageRequestSubject = PublishSubject();

  BehaviorSubject<Resource<List<VoucherCategories>>> _voucherCategoriesResponseSubject = BehaviorSubject();

  Stream<Resource<List<VoucherCategories>>> get voucherCategoriesResponseStream =>
      _voucherCategoriesResponseSubject.stream;

  /// ------------- my vouchers stream -----------------------
  BehaviorSubject<Resource<bool>> _myVoucherResponseSubject = BehaviorSubject();

  Stream<Resource<bool>> get myVoucherResponseStream => _myVoucherResponseSubject.stream;

  /// ------------- voucher by Filter & Search stream -----------------------
  BehaviorSubject<Resource<List<VoucherItem>>> _voucherByFilterAndSearchResponseSubject = BehaviorSubject();

  Stream<Resource<List<VoucherItem>>> get voucherByFilterAndSearchResponseStream =>
      _voucherByFilterAndSearchResponseSubject.stream;

  /*/// ------------- voucher by Search stream -----------------------
  BehaviorSubject<Resource<bool>> _voucherBySearchResponseSubject = BehaviorSubject();

  Stream<Resource<bool>> get voucherBySearchResponseStream => _voucherBySearchResponseSubject.stream;*/

  /// ------------- tabChange listener -----------------------

  ValueNotifier<int> tabChangeNotifier = ValueNotifier(0);

  EvoucherViewModel(this._eVoucherLandingPageUseCase) {
    _voucherLandingPageRequestSubject.listen((value) {
      switch (value.eVoucherLandingPageDataEnum) {
        case EVoucherLandingPageDataEnum.voucherCategories:
          listenToVoucherCategories(value);
          break;
        case EVoucherLandingPageDataEnum.myVouchers:
          listenToMyVouchers(value);
          break;
        case EVoucherLandingPageDataEnum.voucherDetails:
          listenToVoucherDetails(value);
          break;
        /*case EVoucherLandingPageDataEnum.vouchersByCategory:
          listenToVoucherByCategory(value);
          break;*/
        case EVoucherLandingPageDataEnum.voucherByFilter:
          listenToVoucherByFilter(value);
          break;
        case EVoucherLandingPageDataEnum.voucherBySearch:
          listenToVoucherBySearch(value);
          break;
      }
    });

    getVoucherCategories();
  }

  void listenToVoucherCategories(EVoucherLandingPageUseCaseParams value) {
    RequestManager<List<VoucherCategories>>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value)
          as Future<Either<BaseError, List<VoucherCategories>>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
      } else if (event.status == Status.ERROR) {
        showToastWithError(event.appError!);
      }
      _voucherCategoriesResponseSubject.safeAdd(event);
      updateLoader();
    });
  }

  void listenToMyVouchers(EVoucherLandingPageUseCaseParams value) {
    RequestManager<bool>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value) as Future<Either<BaseError, bool>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
        getMyVouchers();
      } else if (event.status == Status.ERROR) {
        showToastWithError(event.appError!);
      }
      updateLoader();
    });
  }

  void listenToVoucherDetails(EVoucherLandingPageUseCaseParams value) {
    RequestManager<bool>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value) as Future<Either<BaseError, bool>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
      } else if (event.status == Status.ERROR) {
        showToastWithError(event.appError!);
      }
      updateLoader();
    });
  }

  void listenToVoucherByCategory(EVoucherLandingPageUseCaseParams value) {
    RequestManager<bool>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value) as Future<Either<BaseError, bool>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
      } else {
        if (event.status == Status.ERROR) showToastWithError(event.appError!);
      }
      updateLoader();
    });
  }

  void listenToVoucherByFilter(EVoucherLandingPageUseCaseParams value) {
    RequestManager<List<VoucherItem>>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value)
          as Future<Either<BaseError, List<VoucherItem>>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
      } else if (event.status == Status.ERROR) {
        showToastWithError(event.appError!);
      }
      _voucherByFilterAndSearchResponseSubject.safeAdd(event);
      updateLoader();
    });
  }

  void listenToVoucherBySearch(EVoucherLandingPageUseCaseParams value) {
    RequestManager<List<VoucherItem>>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value)
          as Future<Either<BaseError, List<VoucherItem>>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
        categoriesDisplayToggleNotifier.value = false;
      } else if (event.status == Status.ERROR) {
        showToastWithError(event.appError!);
      }
      _voucherByFilterAndSearchResponseSubject.safeAdd(event);
      updateLoader();
    });
  }

  void getVoucherCategories() {
    _voucherLandingPageRequestSubject.safeAdd(EVoucherLandingPageUseCaseParams(
      eVoucherLandingPageDataEnum: EVoucherLandingPageDataEnum.voucherCategories,
    ));
  }

  void getMyVouchers() {
    _voucherLandingPageRequestSubject.safeAdd(EVoucherLandingPageUseCaseParams(
      eVoucherLandingPageDataEnum: EVoucherLandingPageDataEnum.myVouchers,
      pageNo: '0',
      fromDate: '2013-04-27 20:57:01',
      toDate: '2013-04-28 20:57:01',
    ));
  }

  void toggleSearch(bool focus) {
    if (buyVoucherSearchController.text.trim().isEmpty) {
      categoriesDisplayToggleNotifier.value = true;
    } else {
      // call search api...
      if (!focus) {
        callSearchApi();
      }
    }
  }

  void callSearchApi() {
    if (buyVoucherSearchController.text.trim().isEmpty) {
      return;
    }
    _voucherLandingPageRequestSubject.safeAdd(EVoucherLandingPageUseCaseParams(
        eVoucherLandingPageDataEnum: EVoucherLandingPageDataEnum.voucherBySearch,
        searchText: buyVoucherSearchController.text.trim()));
  }

  void setSelectedCategory(VoucherCategories category) {
    this.selectedVoucherCategories = category;
  }

  @override
  void dispose() {
    _voucherLandingPageRequestSubject.close();
    _voucherCategoriesResponseSubject.close();
    _myVoucherResponseSubject.close();
    // _voucherByCategoryResponseSubject.close();
    _voucherByFilterAndSearchResponseSubject.close();
    // _voucherBySearchResponseSubject.close();
    // _voucherBySearchResponseSubject.close();
    tabChangeNotifier.dispose();
    super.dispose();
  }
}
