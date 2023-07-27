import 'package:domain/constants/enum/evoucher_filter_option_enum.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/evoucher_categories_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_history_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_item_filter_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/transaction_period.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:rxdart/rxdart.dart';

class EvoucherViewModel extends BasePageViewModel {
  TextEditingController myVoucherHistorySearchController = TextEditingController();
  TextEditingController buyVoucherSearchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isApiCalling = false;

  ValueNotifier<bool> categoriesDisplayToggleNotifier =
      ValueNotifier(true); // default true as showing categories

  late VoucherCategories selectedVoucherCategories;

  /// ------------- my vouchers stream -----------------------
  BehaviorSubject<Resource<List<VouchersByDate>>> _myVoucherResponseSubject = BehaviorSubject();

  Stream<Resource<List<VouchersByDate>>> get myVoucherResponseStream => _myVoucherResponseSubject.stream;

  /// ------------- voucher by Filter & Search stream -----------------------
  BehaviorSubject<Resource<List<VoucherItem>>> _voucherByFilterAndSearchResponseSubject = BehaviorSubject();

  Stream<Resource<List<VoucherItem>>> get voucherByFilterAndSearchResponseStream =>
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
      RequestManager(value, createCall: () => eVoucherCategoriesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        voucherCategoriesResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();

          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {
          categoriesList = event.data ?? [];
          getVoucherHistory(pageNo: pageNo, rangeOfMonths: filterDay);
        }
      });
    });

    _voucherCategoriesRequestSubject.safeAdd(EVoucherCategoriesUseCaseParams());
  }

  List<VoucherCategories> categoriesList = [];
  BehaviorSubject<EVoucherCategoriesUseCaseParams> _voucherCategoriesRequestSubject = BehaviorSubject();

  BehaviorSubject<Resource<List<VoucherCategories>>> voucherCategoriesResponseSubject = BehaviorSubject();

  Stream<Resource<List<VoucherCategories>>> get voucherCategoriesResponseStream =>
      voucherCategoriesResponseSubject.stream;

  /// ------------- voucher History  -------------------------------------------

  void getVoucherHistorySubject() {
    _voucherHistoryRequestSubject.listen((value) {
      RequestManager(value, createCall: () => eVoucherHistoryUseCase.execute(params: value))
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
              if (TimeUtils.getFormattedDateMonth(myVoucherHistoryList.last.date ?? "") ==
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
              _voucherHistoryResponseSubject.safeAdd(Resource.success(data: myVoucherHistoryList));
            }
          }
        }
      });
    });
  }

  getVoucherHistory({required int pageNo, required int rangeOfMonths, String searchPhrase = ''}) {
    _voucherHistoryRequestSubject.safeAdd(EVoucherHistoryUseCaseParams(
        pageNo: pageNo, rangeOfMonths: rangeOfMonths, searchPhrase: searchPhrase));
  }

  BehaviorSubject<EVoucherHistoryUseCaseParams> _voucherHistoryRequestSubject = BehaviorSubject();

  BehaviorSubject<Resource<List<VouchersByDate>>> _voucherHistoryResponseSubject = BehaviorSubject();

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
          getVoucherHistory(
              pageNo: pageNo,
              rangeOfMonths: filterDay,
              searchPhrase: myVoucherHistorySearchController.text.trim());
          // selectTransactionPeriodAndCallApi();
        }
      }
    });
  }

  /// ------------- voucher Item Filter  -------------------------------------------

  void getVoucherItemFilterSubject() {
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
          filterList = event.data ?? [];
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
        category: category, region: region, maxValue: maxValue, minValue: minValue, searchText: searchText));
  }

  EvoucherFilterOption evoucherFilterOption = EvoucherFilterOption.FROM_SEARCH_FILTER;

  List<VoucherItem> filterList = [];
  PublishSubject<EVoucherItemFilterUseCaseParams> _voucherItemFilterRequestSubject = PublishSubject();

  PublishSubject<Resource<List<VoucherItem>>> voucherItemFilterResponseSubject = PublishSubject();

  Stream<Resource<List<VoucherItem>>> get voucherItemFilterResponseStream =>
      voucherItemFilterResponseSubject.stream;

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

  void toggleSearch(bool focus) {
    if (buyVoucherSearchController.text.trim().isEmpty) {
      categoriesDisplayToggleNotifier.value = true;
      voucherCategoriesResponseSubject
          .safeAdd(Resource.success(data: categoriesList));
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

  void setSelectedCategory(VoucherCategories category) {
    this.selectedVoucherCategories = category;
  }

  @override
  void dispose() {
    _voucherCategoriesRequestSubject.close();
    voucherCategoriesResponseSubject.close();
    _myVoucherResponseSubject.close();
    _voucherByFilterAndSearchResponseSubject.close();
    tabChangeNotifier.dispose();
    scrollController.dispose();
    super.dispose();
  }


}
