import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/evoucher_landing_page_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/model/transaction_period.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EvoucherViewModel extends BasePageViewModel {
  TextEditingController myVoucherSearchController = TextEditingController();
  TextEditingController buyVoucherSearchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isApiCalling = false;

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
  BehaviorSubject<Resource<List<VouchersByDate>>> _myVoucherResponseSubject = BehaviorSubject();

  Stream<Resource<List<VouchersByDate>>> get myVoucherResponseStream => _myVoucherResponseSubject.stream;

  List<VouchersByDate> myVoucherHistoryList = [];

  /// ------------- voucher by Filter & Search stream -----------------------
  BehaviorSubject<Resource<List<VoucherItem>>> _voucherByFilterAndSearchResponseSubject = BehaviorSubject();

  Stream<Resource<List<VoucherItem>>> get voucherByFilterAndSearchResponseStream =>
      _voucherByFilterAndSearchResponseSubject.stream;

  /// ------------- tabChange listener -----------------------

  ValueNotifier<int> tabChangeNotifier = ValueNotifier(0);

  List<TransactionPeriod> transactionPeriods = [];
  late int selectedTransactionHistoryPeriod;

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
    getMoreScrollListener();
    getVoucherCategories();
  }

  void listenToVoucherCategories(EVoucherLandingPageUseCaseParams value) {
    RequestManager<List<VoucherCategories>>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value)
          as Future<Either<BaseError, List<VoucherCategories>>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
        addTransactionPeriod();
      } else if (event.status == Status.ERROR) {
        showToastWithError(event.appError!);
      }
      _voucherCategoriesResponseSubject.safeAdd(event);
      updateLoader();
    });
  }

  void listenToMyVouchers(EVoucherLandingPageUseCaseParams value) {
    RequestManager<List<VouchersByDate>>(value, createCall: () {
      return _eVoucherLandingPageUseCase.execute(params: value)
          as Future<Either<BaseError, List<VouchersByDate>>>;
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
        // done...
        isApiCalling = false;
        myVoucherHistoryList.addAll(event.data!);
      } else if (event.status == Status.ERROR) {
        isApiCalling = false;
        showToastWithError(event.appError!);
      }
      _myVoucherResponseSubject.safeAdd(event);
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
    _voucherByFilterAndSearchResponseSubject.close();
    tabChangeNotifier.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void addTransactionPeriod() {
    transactionPeriods.clear();
    transactionPeriods.add(TransactionPeriod(dayPeriodString: S.current.last_30_days, dayPeriod: 30));
    transactionPeriods.add(TransactionPeriod(dayPeriodString: S.current.last_60_days, dayPeriod: 60));
    transactionPeriods.add(TransactionPeriod(dayPeriodString: S.current.last_90_days, dayPeriod: 90));

    selectedTransactionHistoryPeriod = transactionPeriods.first.dayPeriod;
    selectTransactionPeriodAndCallApi();
  }

  void selectTransactionPeriodAndCallApi() {
    _voucherLandingPageRequestSubject.safeAdd(EVoucherLandingPageUseCaseParams(
      eVoucherLandingPageDataEnum: EVoucherLandingPageDataEnum.myVouchers,
      pageNo: '$pageNo',
      rangeOfMonths: selectedTransactionHistoryPeriod,
    ));
  }

  int pageNo = 1;
  bool hasMoreData = true;

  void getMoreScrollListener() {
    if (scrollController.hasListeners) return;
    scrollController.addListener(() {
      // Don't call the API again
      if (!hasMoreData) return;

      // If is scrolled till the end
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isApiCalling) return;
        isApiCalling = true;
        // Increment the Page no. for more data
        pageNo++;

        // Call the API for getting more data with
        // incremented Page no.
        if (pageNo > 1 /*&& searchTextList.isEmpty*/) {
          debugPrint('Entered here--------> too');
          selectTransactionPeriodAndCallApi();
        }
      }
    });
  }

  void setSelectedTransactionPeriod(String value) {
    selectedTransactionHistoryPeriod =
        transactionPeriods.firstWhere((element) => element.dayPeriodString == value).dayPeriod;
    myVoucherHistoryList = [];
    _myVoucherResponseSubject.safeAdd(Resource.success(data: myVoucherHistoryList));
  }
}
