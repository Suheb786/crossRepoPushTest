import 'package:domain/constants/enum/evoucher_filter_option_enum.dart';
import 'package:domain/model/e_voucher/get_voucher_details.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/evoucher_categories_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_history_usecase.dart';
import 'package:domain/usecase/evouchers/evoucher_item_filter_usecase.dart';
import 'package:domain/usecase/evouchers/get_voucher_details_usecase.dart';
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
  TextEditingController buyVoucherSearchController = TextEditingController();
  ValueNotifier<bool> categoriesDisplayToggleNotifier =
      ValueNotifier(true); // default true as showing categories

  List<VoucherCategories> categoriesList = [];
  EVoucherCategoriesUseCase eVoucherCategoriesUseCase;
  EVoucherHistoryUseCase eVoucherHistoryUseCase;
  EVoucherItemFilterUseCase eVoucherItemFilterUseCase;
  EvoucherFilterOption evoucherFilterOption = EvoucherFilterOption.FROM_SEARCH_FILTER;

  ///---------------------Filter option for date-------------------------------------

  int filterDay = 6; //Last 6 month

  List<VoucherItem> filterList = [];
  late GetVoucherDetails? getSelectedVoucher;
  final GetVoucherDetailUseCase getVoucherDetailsUseCase;
  bool hasMoreData = true;
  bool isApiCalling = false;
  List<VouchersByDate> myVoucherHistoryList = [];
  TextEditingController myVoucherHistorySearchController = TextEditingController();
  int pageNo = 1;
  final ScrollController scrollController = ScrollController();
  late int selectedTransactionHistoryPeriod;
  late VoucherCategories selectedVoucherCategories;

  late VoucherDetail historyData;

  /// ------------- tabChange listener -----------------------

  ValueNotifier<int> tabChangeNotifier = ValueNotifier(0);

  List<TransactionPeriod> transactionPeriods = [];
  BehaviorSubject<Resource<List<VoucherCategories>>> voucherCategoriesResponseSubject = BehaviorSubject();
  PublishSubject<Resource<List<VoucherItem>>> voucherItemFilterResponseSubject = PublishSubject();

  /// get voucher details subjects ----
  PublishSubject<GetVoucherDetailsUseCaseParams> _getvoucherDetailsRequest = PublishSubject();

  PublishSubject<Resource<GetVoucherDetails>> _getvoucherDetailsResponse = PublishSubject();

  /// ------------- my vouchers stream -----------------------
  BehaviorSubject<Resource<List<VouchersByDate>>> _myVoucherResponseSubject = BehaviorSubject();

  /// ------------- voucher by Filter & Search stream -----------------------
  BehaviorSubject<Resource<List<VoucherItem>>> _voucherByFilterAndSearchResponseSubject = BehaviorSubject();

  BehaviorSubject<EVoucherCategoriesUseCaseParams> _voucherCategoriesRequestSubject = BehaviorSubject();
  BehaviorSubject<EVoucherHistoryUseCaseParams> _voucherHistoryRequestSubject = BehaviorSubject();
  BehaviorSubject<Resource<List<VouchersByDate>>> _voucherHistoryResponseSubject = BehaviorSubject();
  PublishSubject<EVoucherItemFilterUseCaseParams> _voucherItemFilterRequestSubject = PublishSubject();

  EvoucherViewModel({
    required this.getVoucherDetailsUseCase,
    required this.eVoucherCategoriesUseCase,
    required this.eVoucherHistoryUseCase,
    required this.eVoucherItemFilterUseCase,
  }) {
    getVoucherCategories();
    getVoucherCategoriesSubject();
    getVoucherHistorySubject();

    getMoreScrollListener();

    getVoucherItemFilterSubject();

    listenGetVoucherDetials();
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

  Stream<Resource<GetVoucherDetails>> get getvoucherDetiailsStream => _getvoucherDetailsResponse.stream;

  Stream<Resource<List<VouchersByDate>>> get myVoucherResponseStream => _myVoucherResponseSubject.stream;

  Stream<Resource<List<VoucherItem>>> get voucherByFilterAndSearchResponseStream =>
      _voucherByFilterAndSearchResponseSubject.stream;

  listenGetVoucherDetials() {
    _getvoucherDetailsRequest.listen((value) {
      RequestManager(value, createCall: () => getVoucherDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getvoucherDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();

          showToastWithError(event.appError!);
        }
        if (event.status == Status.SUCCESS) {
          getSelectedVoucher = event.data;
        }
      });
    });
  }

  /// ------------- voucher categories stream -------------------------------------------

  void getVoucherCategoriesSubject() {
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
  }

  getVoucherCategories() {
    _voucherCategoriesRequestSubject.safeAdd(EVoucherCategoriesUseCaseParams());
  }

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
          if ((event.data ?? []).isNotEmpty) {
            hasMoreData = true;
            isApiCalling = false;
            var list = event.data ?? [];
            if (myVoucherHistoryList.isEmpty) {
              myVoucherHistoryList.addAll(list);
            } else {
              if (TimeUtils.convertDateTimeToDateMonth(myVoucherHistoryList.last.date) ==
                  TimeUtils.convertDateTimeToDateMonth(list.first.date)) {
                myVoucherHistoryList.last.data.addAll(list.first.data);
                if (list.length > 1) {
                  list..removeAt(0);
                  myVoucherHistoryList.addAll(list);
                }
              } else {
                myVoucherHistoryList.addAll(list);
              }
            }
            myVoucherHistoryList = myVoucherHistoryList.toSet().toList();

            _voucherHistoryResponseSubject.safeAdd(Resource.success(data: myVoucherHistoryList));
          } else {
            hasMoreData = false;
            isApiCalling = true;
            if (pageNo == 1 && (event.data ?? []).isEmpty) {
              _voucherHistoryResponseSubject.safeAdd(Resource.success(data: myVoucherHistoryList));
            }
          }
        }
      });
    });
  }

  getVoucherHistory({
    required int pageNo,
    required int rangeOfMonths,
    String searchPhrase = '',
    int totalRecord = 10,
  }) {
    _voucherHistoryRequestSubject.safeAdd(EVoucherHistoryUseCaseParams(
        pageNo: pageNo, rangeOfMonths: rangeOfMonths, searchPhrase: searchPhrase, totalRecord: totalRecord));
  }

  Stream<Resource<List<VouchersByDate>>> get voucherHistoryResponseStream =>
      _voucherHistoryResponseSubject.stream;

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
          getVoucherHistory(
              pageNo: pageNo, rangeOfMonths: filterDay, searchPhrase: myVoucherHistorySearchController.text);
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

  void getVoucherDetailCall({required String? OrderIdentifier}) {
    _getvoucherDetailsRequest.safeAdd(GetVoucherDetailsUseCaseParams(OrderIdentifier: OrderIdentifier));
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

  Stream<Resource<List<VoucherItem>>> get voucherItemFilterResponseStream =>
      voucherItemFilterResponseSubject.stream;

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
      voucherCategoriesResponseSubject.safeAdd(Resource.success(data: categoriesList));
    } else {
      /// call search api...
      if (!focus) {
        getVoucherItemFilter(
            category: "",
            region: '',
            maxValue: 0.0,
            minValue: 0.0,
            searchText: buyVoucherSearchController.text);
      }
    }
  }

  void setSelectedCategory(VoucherCategories category) {
    this.selectedVoucherCategories = category;
  }
}
