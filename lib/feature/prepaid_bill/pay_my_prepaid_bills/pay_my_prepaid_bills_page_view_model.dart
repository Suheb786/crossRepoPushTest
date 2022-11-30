import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_data.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PayMyPrePaidBillsPageViewModel extends BasePageViewModel {
  TextEditingController searchBillController = TextEditingController();
  List<GetPrepaidBillerListModelData>? getPrepaidBillData = [];
  List<GetPrepaidCategoriesModelData> getPrepaidCategoriesModelData = [];
  int selectedIndex = 0;

  final GetPrepaidBillerListUseCase getPrepaidBillerListUseCase;
  final GetPrePaidCategoriesListUseCase getPrePaidCategoriesListUseCase;
  final RemovePrepaidBillerUseCase removePrepaidBillerUseCase;

  PayMyPrePaidBillsPageViewModel(this.getPrepaidBillerListUseCase,
      this.getPrePaidCategoriesListUseCase, this.removePrepaidBillerUseCase) {
    prepaidBillerListener();
    prePaidCategoriesRequestListener();
    removePrepaidBillerListenr();
    getPrepaidBiller();
  }

  /// ---------------- Call Api GetPrepaidBillerList -------------------------------- ///

  PublishSubject<GetPrepaidBillerListUseCaseParams> _prepaidBillerRequest =
      PublishSubject();
  PublishSubject<Resource<GetPrepaidBillerListModel>> _prepaidBillerResponse =
      PublishSubject();

  Stream<Resource<GetPrepaidBillerListModel>> get prepaidBillerStream =>
      _prepaidBillerResponse.stream;

  void getPrepaidBiller() {
    _prepaidBillerRequest.safeAdd(GetPrepaidBillerListUseCaseParams());
  }

  void prepaidBillerListener() {
    _prepaidBillerRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    getPrepaidBillerListUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _prepaidBillerResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- Call Api GetPrePaidCategoriesList -------------------------------- ///

  PublishSubject<GetPrePaidCategoriesListUseCaseParams>
      _gerPrePaidCategoriesRequest = PublishSubject();

  PublishSubject<Resource<GetPrePaidCategoriesModel>>
      _gerPrePaidCategoriesResponse = PublishSubject();

  Stream<Resource<GetPrePaidCategoriesModel>> get gerPrePaidCategoriesStream =>
      _gerPrePaidCategoriesResponse.stream;

  void getPrePaidCategoresList(String? serviceCode, String? billerCode) {
    _gerPrePaidCategoriesRequest.safeAdd(
      GetPrePaidCategoriesListUseCaseParams(
          billerCode: billerCode, serviceCode: serviceCode),
    );
  }

  void prePaidCategoriesRequestListener() {
    _gerPrePaidCategoriesRequest.listen(
      (params) {
        RequestManager(
          params,
          createCall: () => getPrePaidCategoriesListUseCase.execute(
            params: params,
          ),
        ).asFlow().listen((event) {
          updateLoader();
          _gerPrePaidCategoriesResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- remove prepaid biller -------------------------------- ///

  PublishSubject<RemovePrepaidBillerUseCaseParams> _removePrepaidBillerRequest =
      PublishSubject();

  BehaviorSubject<Resource<bool>> _removePrepaidBillerResponse =
      BehaviorSubject();

  Stream<Resource<bool>> get removePrepaidBillerStream =>
      _removePrepaidBillerResponse.stream;

  void removePrepaidBillerListenr() {
    _removePrepaidBillerRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    removePrepaidBillerUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();

          _removePrepaidBillerResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            if (event.data == true) {
              // showToastWithSuccess(AppConstants.SUCCESS_MESSAGE_BOOL);
              Future.delayed(Duration(milliseconds: 200))
                  .then((value) => getPrepaidBiller());
            } else {
              // showToastWithErrorMessage(AppConstants.ERROR_MESSAGE_BOOL);
            }
          }
        });
      },
    );
  }

  void removePrepaidBiller(
    String? registrationID,
  ) {
    _removePrepaidBillerRequest.safeAdd(
      RemovePrepaidBillerUseCaseParams(
        registrationID: registrationID,
      ),
    );
  }
}
