import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories_list.dart';
import 'package:domain/usecase/bill_payment/get_bill_categories_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class NewBillsPageViewModel extends BasePageViewModel {
  GetBillCategoriesUseCase getBillCategoriesUseCase;
  final TextEditingController searchBillController = TextEditingController();
  List<GetBillCategoriesList>? billCategoriesList = [];
  String? title = "";
  String? titleIcon = "";

  NewBillsPageViewModel(this.getBillCategoriesUseCase) {
    _getCategoriesRequest.listen(
          (params) {
        RequestManager(params,
            createCall: () =>
                getBillCategoriesUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _getCategoriesResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
    getCategories();
  }

  /// ---------------------- Get Category -------------------------------- ///
  PublishSubject<GetBillCategoriesUseCaseParams> _getCategoriesRequest =
  PublishSubject();

  BehaviorSubject<Resource<GetBillCategories>> _getCategoriesResponse =
  BehaviorSubject();

  Stream<Resource<GetBillCategories>> get getCategoriesStream =>
      _getCategoriesResponse.stream;

  void getCategories() {
    _getCategoriesRequest.safeAdd(GetBillCategoriesUseCaseParams());
  }

  // Dispose
  @override
  void dispose() {
    _getCategoriesRequest.close();
    _getCategoriesResponse.close();
    super.dispose();
  }
}

