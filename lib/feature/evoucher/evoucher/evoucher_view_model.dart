import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/evoucher_categories_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_history_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_item_filter_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_landing_page_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/model/transaction_period.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:rxdart/rxdart.dart';

class EvoucherViewModel extends BasePageViewModel {
  TextEditingController myVoucherSearchController = TextEditingController();
  TextEditingController buyVoucherSearchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isApiCalling = false;

  ValueNotifier<bool> categoriesDisplayToggleNotifier =
      ValueNotifier(true); // default true as showing categories

  late VoucherCategories selectedVoucherCategories;

  /// ------------- my vouchers stream -----------------------
  BehaviorSubject<Resource<List<VouchersByDate>>> _myVoucherResponseSubject =
      BehaviorSubject();

  Stream<Resource<List<VouchersByDate>>> get myVoucherResponseStream =>
      _myVoucherResponseSubject.stream;

  /// ------------- voucher by Filter & Search stream -----------------------
  BehaviorSubject<Resource<List<VoucherItem>>>
      _voucherByFilterAndSearchResponseSubject = BehaviorSubject();

  Stream<Resource<List<VoucherItem>>>
      get voucherByFilterAndSearchResponseStream =>
          _voucherByFilterAndSearchResponseSubject.stream;

  /// ------------- tabChange listener -----------------------

  ValueNotifier<int> tabChangeNotifier = ValueNotifier(0);

  List<TransactionPeriod> transactionPeriods = [];
  late int selectedTransactionHistoryPeriod;

  List<VouchersByDate> myVoucherHistoryList = [];
  EVoucherCategoriesUseCase eVoucherCategoriesUseCase;
  EVoucherHistoryUseCase eVoucherHistoryUseCase;
  EVoucherItemFilterUseCase eVoucherItemFilterUseCase;

  EvoucherViewModel({
    required this.eVoucherCategoriesUseCase,
    required this.eVoucherHistoryUseCase,
    required this.eVoucherItemFilterUseCase,
  }) {
    getVoucherCategories();

    getVoucherHistorySubject();

    getMoreScrollListener();

    getVoucherItemFilterSubject();
  }

  /// ------------- voucher categories stream -------------------------------------------

  void getVoucherCategories() {
    _voucherCategoriesRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () =>
                  eVoucherCategoriesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _voucherCategoriesResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          //   getVoucherHistory(pageNo.toString(), 3);
          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {
          print("event.status==Status.SUCCESS");
          getVoucherHistory(pageNo.toString(), filterDay);
        }
      });
    });

    _voucherCategoriesRequestSubject.safeAdd(EVoucherCategoriesUseCaseParams());
  }

  PublishSubject<EVoucherCategoriesUseCaseParams>
      _voucherCategoriesRequestSubject = PublishSubject();

  PublishSubject<Resource<List<VoucherCategories>>>
      _voucherCategoriesResponseSubject = PublishSubject();

  Stream<Resource<List<VoucherCategories>>>
      get voucherCategoriesResponseStream =>
          _voucherCategoriesResponseSubject.stream;

  /// ------------- voucher History  -------------------------------------------

  void getVoucherHistorySubject() {
    _voucherHistoryRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () => eVoucherHistoryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();

        if (event.status == Status.ERROR) {
          isApiCalling = false;
          hasMoreData = false;
          showToastWithError(event.appError!);
          _voucherHistoryResponseSubject.safeAdd(event);
        } else if (event.status == Status.SUCCESS) {
          // done...

          if ((event.data ?? []).isNotEmpty) {
            hasMoreData = true;
            isApiCalling = false;
            var list = event.data ?? [];
            if (myVoucherHistoryList == null || myVoucherHistoryList.isEmpty) {
              myVoucherHistoryList.addAll(list);
            } else {
              if (TimeUtils.getFormattedDateMonth(
                      myVoucherHistoryList.last.date ?? "") ==
                  TimeUtils.getFormattedDateMonth(list.first.date ?? "")) {
                myVoucherHistoryList.last.data.addAll(list.first.data ?? []);
              } else {
                myVoucherHistoryList.addAll(list);
              }
            }
            myVoucherHistoryList = myVoucherHistoryList.toSet().toList();

            _voucherHistoryResponseSubject
                .safeAdd(Resource.success(data: myVoucherHistoryList));
          } else {
            hasMoreData = false;
            isApiCalling = true;
            //   pageNo--;
            if (pageNo == 1 && (event.data ?? []).isEmpty) {
              _voucherHistoryResponseSubject
                  .safeAdd(Resource.success(data: myVoucherHistoryList));
            }
          }
        }
      });
    });
  }

  getVoucherHistory(String page, int rangeOfMonths) {
    _voucherHistoryRequestSubject.safeAdd(EVoucherHistoryUseCaseParams(
        pageNo: page, rangeOfMonths: rangeOfMonths));
  }

  PublishSubject<EVoucherHistoryUseCaseParams> _voucherHistoryRequestSubject =
      PublishSubject();

  PublishSubject<Resource<List<VouchersByDate>>>
      _voucherHistoryResponseSubject = PublishSubject();

  Stream<Resource<List<VouchersByDate>>> get voucherHistoryResponseStream =>
      _voucherHistoryResponseSubject.stream;

  int pageNo = 1;
  bool hasMoreData = true;

  void getMoreScrollListener() {
    if (scrollController.hasListeners) return;
    scrollController.addListener(() {
      // Don't call the API again
      if (!hasMoreData) return;

      // If is scrolled till the end
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isApiCalling) return;
        isApiCalling = true;
        // Increment the Page no. for more data
        pageNo++;

        // Call the API for getting more data with
        // incremented Page no.
        if (pageNo > 1 /*&& searchTextList.isEmpty*/) {
          debugPrint('Entered here--------> too');
          getVoucherHistory(pageNo.toString(), filterDay);
          // selectTransactionPeriodAndCallApi();
        }
      }
    });
  }

  /// ------------- voucher Item Filter  -------------------------------------------

  void getVoucherItemFilterSubject() {
    _voucherItemFilterRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () =>
                  eVoucherItemFilterUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _voucherItemFilterResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();

          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {
          categoriesDisplayToggleNotifier.value = false;
        }
      });
    });
  }

  void getVoucherItemFilter(
      {required String category,
      required String region,
      required num maxValue,
      required num minValue,
      required String searchText}) {
    _voucherItemFilterRequestSubject.safeAdd(EVoucherItemFilterUseCaseParams(
        category: category,
        region: region,
        maxValue: maxValue,
        minValue: minValue,
        searchText: searchText));
  }

  PublishSubject<EVoucherItemFilterUseCaseParams>
      _voucherItemFilterRequestSubject = PublishSubject();

  PublishSubject<Resource<List<VoucherItem>>>
      _voucherItemFilterResponseSubject = PublishSubject();

  Stream<Resource<List<VoucherItem>>> get voucherItemFilterResponseStream =>
      _voucherItemFilterResponseSubject.stream;

  ///---------------------Filter option for date-------------------------------------

  int filterDay = 6; //Last 6 month

  int getFilterDays(String value) {
    switch (value) {
      case "Last 30 days":
        return 1;
      case "Last 3 months":
        return 3;
      case "Last 6 months":
        return 6;
      case "آخر 30 يوم":
        return 1;
      case "آخر 3 اشهر":
        return 3;
      case "آخر 6 اشهر":
        return 6;
      default:
        return 6;
    }
  }

  // void listenToVoucherCategories(EVoucherCategoriesUseCaseParams value) {
  //   RequestManager<List<VoucherCategories>>(value, createCall: () {
  //     return _eVoucherCategoriesUseCase.execute(params: value)
  //         as Future<Either<BaseError, List<VoucherCategories>>>;
  //   }).asFlow().listen((event) {
  //     if (event.status == Status.SUCCESS) {
  //       // done...
  //       addTransactionPeriod();
  //     } else if (event.status == Status.ERROR) {
  //       showToastWithError(event.appError!);
  //     }
  //     _voucherCategoriesResponseSubject.safeAdd(event);
  //     updateLoader();
  //   });
  // }

  // void listenToMyVouchers(EVoucherLandingPageUseCaseParams value) {
  //   RequestManager<List<VouchersByDate>>(value, createCall: () {
  //     return _eVoucherCategoriesUseCase.execute(params: value)
  //         as Future<Either<BaseError, List<VouchersByDate>>>;
  //   }).asFlow().listen((event) {
  //     if (event.status == Status.SUCCESS) {
  //       // done...
  //       isApiCalling = false;
  //       myVoucherHistoryList.addAll(event.data!);
  //     } else if (event.status == Status.ERROR) {
  //       isApiCalling = false;
  //       showToastWithError(event.appError!);
  //     }
  //     _myVoucherResponseSubject.safeAdd(event);
  //     updateLoader();
  //   });
  // }
  //
  // void listenToVoucherDetails(EVoucherLandingPageUseCaseParams value) {
  //   RequestManager<bool>(value, createCall: () {
  //     return _eVoucherCategoriesUseCase.execute(params: value) as Future<Either<BaseError, bool>>;
  //   }).asFlow().listen((event) {
  //     if (event.status == Status.SUCCESS) {
  //       // done...
  //     } else if (event.status == Status.ERROR) {
  //       showToastWithError(event.appError!);
  //     }
  //     updateLoader();
  //   });
  // }
  //
  // void listenToVoucherByCategory(EVoucherLandingPageUseCaseParams value) {
  //   RequestManager<bool>(value, createCall: () {
  //     return _eVoucherCategoriesUseCase.execute(params: value) as Future<Either<BaseError, bool>>;
  //   }).asFlow().listen((event) {
  //     if (event.status == Status.SUCCESS) {
  //       // done...
  //     } else {
  //       if (event.status == Status.ERROR) showToastWithError(event.appError!);
  //     }
  //     updateLoader();
  //   });
  // }
  //
  // void listenToVoucherByFilter(EVoucherLandingPageUseCaseParams value) {
  //   RequestManager<List<VoucherItem>>(value, createCall: () {
  //     return _eVoucherCategoriesUseCase.execute(params: value)
  //         as Future<Either<BaseError, List<VoucherItem>>>;
  //   }).asFlow().listen((event) {
  //     if (event.status == Status.SUCCESS) {
  //       // done...
  //     } else if (event.status == Status.ERROR) {
  //       showToastWithError(event.appError!);
  //     }
  //     _voucherByFilterAndSearchResponseSubject.safeAdd(event);
  //     updateLoader();
  //   });
  // }
  //
  // void listenToVoucherBySearch(EVoucherLandingPageUseCaseParams value) {
  //   RequestManager<List<VoucherItem>>(value, createCall: () {
  //     return _eVoucherCategoriesUseCase.execute(params: value)
  //         as Future<Either<BaseError, List<VoucherItem>>>;
  //   }).asFlow().listen((event) {
  //     _voucherByFilterAndSearchResponseSubject.safeAdd(event);
  //     updateLoader();
  //     if (event.status == Status.SUCCESS) {
  //       // done...
  //       categoriesDisplayToggleNotifier.value = false;
  //     } else if (event.status == Status.ERROR) {
  //       showToastWithError(event.appError!);
  //     }
  //
  //   });
  // }

  void toggleSearch(bool focus) {
    if (buyVoucherSearchController.text.trim().isEmpty) {
      categoriesDisplayToggleNotifier.value = true;
    } else {
      // call search api...
      if (!focus) {
        getVoucherItemFilter(
            category: '',
            region: '',
            maxValue: 0.0,
            minValue: 0.0,
            searchText: buyVoucherSearchController.text.trim());
      }
    }
  }

  void callSearchApi() {
    if (buyVoucherSearchController.text.trim().isEmpty) {
      return;
    }
    _voucherCategoriesRequestSubject.safeAdd(EVoucherLandingPageUseCaseParams(
        eVoucherLandingPageDataEnum:
            EVoucherLandingPageDataEnum.voucherBySearch,
        searchText: buyVoucherSearchController.text.trim()));
  }

  void setSelectedCategory(VoucherCategories category) {
    this.selectedVoucherCategories = category;
  }

  @override
  void dispose() {
    _voucherCategoriesRequestSubject.close();
    _voucherCategoriesResponseSubject.close();
    _myVoucherResponseSubject.close();
    _voucherByFilterAndSearchResponseSubject.close();
    tabChangeNotifier.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void addTransactionPeriod() {
    transactionPeriods.clear();
    transactionPeriods.add(TransactionPeriod(
        dayPeriodString: S.current.last_30_days, dayPeriod: 30));
    transactionPeriods.add(TransactionPeriod(
        dayPeriodString: S.current.last_60_days, dayPeriod: 60));
    transactionPeriods.add(TransactionPeriod(
        dayPeriodString: S.current.last_90_days, dayPeriod: 90));

    selectedTransactionHistoryPeriod = transactionPeriods.first.dayPeriod;
    selectTransactionPeriodAndCallApi();
  }

  void selectTransactionPeriodAndCallApi() {
    _voucherCategoriesRequestSubject.safeAdd(EVoucherLandingPageUseCaseParams(
      eVoucherLandingPageDataEnum: EVoucherLandingPageDataEnum.myVouchers,
      pageNo: '$pageNo',
      rangeOfMonths: selectedTransactionHistoryPeriod,
    ));
  }

  void setSelectedTransactionPeriod(String value) {
    selectedTransactionHistoryPeriod = transactionPeriods
        .firstWhere((element) => element.dayPeriodString == value)
        .dayPeriod;
    myVoucherHistoryList = [];
    _myVoucherResponseSubject
        .safeAdd(Resource.success(data: myVoucherHistoryList));
  }
}
