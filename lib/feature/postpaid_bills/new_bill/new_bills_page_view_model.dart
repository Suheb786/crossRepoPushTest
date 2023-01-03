import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_data.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_list.dart';
import 'package:domain/usecase/bill_payment/get_bill_categories_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class NewBillsPageViewModel extends BasePageViewModel {
  GetBillCategoriesUseCase getBillCategoriesUseCase;
  final TextEditingController searchBillController = TextEditingController();
  List<GetBillCategoriesList>? list = [];
  List<GetBillCategoriesList>? fList = [];
  String? title = "";
  String? titleIcon = "";

  String billerCategory = "";
  String billerCategoryApiValue = "";

  NewBillsPageViewModel(this.getBillCategoriesUseCase) {
    _getCategoriesRequest.listen(
      (params) {
        RequestManager(params, createCall: () => getBillCategoriesUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _getCategoriesResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            AppConstantsUtils.billCategoriesCacheList =
                event.data!.getBillCategoriesData?.getBillCategoriesList;
            list = event.data!.getBillCategoriesData?.getBillCategoriesList;
            _getCategoriesResponse.safeAdd(event);
            _searchCategoryListSubject
                .safeAdd(Resource.success(data: event.data!.getBillCategoriesData!.getBillCategoriesList));
          }
        });
      },
    );
    getCategories();
  }

  /// ---------------------- Get Category -------------------------------- ///
  PublishSubject<GetBillCategoriesUseCaseParams> _getCategoriesRequest = PublishSubject();

  BehaviorSubject<Resource<GetBillCategories>> _getCategoriesResponse = BehaviorSubject();

  Stream<Resource<GetBillCategories>> get getCategoriesStream => _getCategoriesResponse.stream;

  BehaviorSubject<Resource<List<GetBillCategoriesList>>> _searchCategoryListSubject = BehaviorSubject();

  Stream<Resource<List<GetBillCategoriesList>>> get searchCategoryListStream =>
      _searchCategoryListSubject.stream;

  void getCategories() {
    list = AppConstantsUtils.billCategoriesCacheList;
    if (list == null || list!.isEmpty) {
      _getCategoriesRequest.safeAdd(GetBillCategoriesUseCaseParams());
    } else {
      _getCategoriesResponse.safeAdd(Resource.success(
          data:
              GetBillCategories(getBillCategoriesData: GetBillCategoriesData(getBillCategoriesList: list))));
      _searchCategoryListSubject.safeAdd(Resource.success(data: list));
    }
  }

  void searchBillerCategory(String? searchText) {
    fList!.clear();
    List<GetBillCategoriesList>? billCategoryList =
        _getCategoriesResponse.value.data?.getBillCategoriesData?.getBillCategoriesList;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < billCategoryList!.length; i++) {
        GetBillCategoriesList item = billCategoryList[i];
        if (item.categoryName != null) {
          if (item.categoryName!.toLowerCase().contains(searchText.toLowerCase())) {
            fList!.add(item);
          }
        }
      }
      _searchCategoryListSubject.safeAdd(Resource.success(data: fList));
    } else {
      _searchCategoryListSubject.safeAdd(Resource.success(
          data: _getCategoriesResponse.value.data?.getBillCategoriesData?.getBillCategoriesList));
    }
  }

// Dispose
  @override
  void dispose() {
    _getCategoriesRequest.close();
    _getCategoriesResponse.close();
    super.dispose();
  }
}
