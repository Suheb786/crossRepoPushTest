import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/error/network_error.dart';
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

  /// ------------- voucher categories stream -----------------------
  PublishSubject<EVoucherLandingPageUseCaseParams> _voucherLandingPageRequestSubject = PublishSubject();

  BehaviorSubject<Resource<bool>> _voucherCategoriesResponseSubject = BehaviorSubject();

  Stream<Resource<bool>> get voucherCategoriesResponseStream => _voucherCategoriesResponseSubject.stream;

  /// ------------- my vouchers stream -----------------------
  BehaviorSubject<Resource<bool>> _myVoucherResponseSubject = BehaviorSubject();

  Stream<Resource<bool>> get myVoucherResponseStream => _myVoucherResponseSubject.stream;

  /// ------------- voucher by category stream -----------------------
  BehaviorSubject<Resource<bool>> _voucherByCategoryResponseSubject = BehaviorSubject();

  Stream<Resource<bool>> get voucherByCategoryResponseStream => _voucherByCategoryResponseSubject.stream;

  /// ------------- voucher by Filter stream -----------------------
  BehaviorSubject<Resource<bool>> _voucherByFilterResponseSubject = BehaviorSubject();

  Stream<Resource<bool>> get voucherByFilterResponseStream => _voucherByFilterResponseSubject.stream;

  /// ------------- voucher by Search stream -----------------------
  BehaviorSubject<Resource<bool>> _voucherBySearchResponseSubject = BehaviorSubject();

  Stream<Resource<bool>> get voucherBySearchResponseStream => _voucherBySearchResponseSubject.stream;

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
        case EVoucherLandingPageDataEnum.vouchersByCategory:
          listenToVoucherByCategory(value);
          break;
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

  void listenToVoucherBySearch(EVoucherLandingPageUseCaseParams value) {
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

  @override
  void dispose() {
    _voucherLandingPageRequestSubject.close();
    _voucherCategoriesResponseSubject.close();
    _myVoucherResponseSubject.close();
    _voucherByCategoryResponseSubject.close();
    _voucherByFilterResponseSubject.close();
    _voucherBySearchResponseSubject.close();
    _voucherBySearchResponseSubject.close();
    tabChangeNotifier.dispose();
    super.dispose();
  }
}
