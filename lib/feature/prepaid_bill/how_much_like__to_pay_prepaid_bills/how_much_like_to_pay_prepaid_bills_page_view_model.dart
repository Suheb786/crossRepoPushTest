import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import 'how_much_like_to_pay_prepaid_bills_page.dart';

class HowMuchLikeToPayPrePaidBillsPageViewModel extends BasePageViewModel {
  final HowMuchLikeToPayPrePaidBillsPageArgument argument;
  final GetPrePaidCategoriesListUseCase getPrePaidCategoriesListUseCase;
  final ValidatePrePaidUseCase validatePrePaidUseCase;
  final PayPrePaidUseCase payPrePaidUseCase;
  bool isPrepaidCategoryListEmpty = false;

  TextEditingController searchBillController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  TextEditingController denominationController = TextEditingController();
  TextEditingController savingAccountController = TextEditingController()
    ..text = 'Savings Account';

  String? billName = "";
  String? nickName = "";
  String? serviceDescriptionEn = "";
  String? billerCode = "";
  String? billingNumber = "";
  String? serviceType = "";
  String? categoryCode = "";
  String? currencyCode = "JOD";
  String? accountNo = "";
  String? otpCode = "";
  bool? isNewBiller = false;
  String? prepaidCategoryCode = "";
  String? prepaidCategoryType = "";
  String? dueAmount = "0";
  String? feesAmt = "0";
  bool? billingNumberRequired = false;
  bool? isCreditCardPayment = false;

  List<GetPrepaidCategoriesModelData> getPrepaidCategoriesModelData = [];

  HowMuchLikeToPayPrePaidBillsPageViewModel(
      this.argument,
      this.getPrePaidCategoriesListUseCase,
      this.validatePrePaidUseCase,
      this.payPrePaidUseCase) {
    // Future.delayed(Duration(milliseconds: 200)).then((value) =>
    //     getPrePaidCategoresList(
    //         argument.payMyPrePaidBillsPageDataList[0].serviceCode,
    //         argument.payMyPrePaidBillsPageDataList[0].billerCode));
    _gerPrePaidCategoriesListener();
    validatePrePaidBillListener();
    payPrePaidBillListener();
  }

  /// ---------------- validate prepaid bill -------------------------------- ///
  PublishSubject<ValidatePrePaidUseCaseParams> _validatePrePaidRequest =
      PublishSubject();

  BehaviorSubject<Resource<ValidatePrePaidBill>> _validatePrePaidResponse =
      BehaviorSubject();

  Stream<Resource<ValidatePrePaidBill>> get validatePrePaidStream =>
      _validatePrePaidResponse.stream;

  void validatePrePaidBill() {
    _validatePrePaidRequest.safeAdd(ValidatePrePaidUseCaseParams(
        billerCode: argument.payMyPrePaidBillsPageDataList[0].billerCode,
        amount: isPrepaidCategoryListEmpty == true ? amtController.text : "",
        serviceType: argument.payMyPrePaidBillsPageDataList[0].serviceType,
        billingNumber: argument.payMyPrePaidBillsPageDataList[0].billingNumber,
        prepaidCategoryCode: isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_CODE
            : "",
        prepaidCategoryType: isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_TYPE
            : "",
        billingNumberRequired:
            argument.payMyPrePaidBillsPageDataList[0].billingNumber != null &&
                    argument.payMyPrePaidBillsPageDataList[0].billingNumber !=
                        ""
                ? true
                : false));
  }

  void validatePrePaidBillListener() {
    _validatePrePaidRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    validatePrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _validatePrePaidResponse.safeAdd(event);

          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- pay prepaid bill -------------------------------- ///
  PublishSubject<PayPrePaidUseCaseParams> _payPrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPrePaid>> _payPrePaidResponse = BehaviorSubject();

  Stream<Resource<PayPrePaid>> get payPrePaidStream =>
      _payPrePaidResponse.stream;

  ///already saved flow.
  void payPrePaidBill() {
    _payPrePaidRequest.safeAdd(PayPrePaidUseCaseParams(
        billerName: argument.payMyPrePaidBillsPageDataList[0].billerName,
        billerCode: billerCode,
        billingNumber: billingNumber,
        serviceType: argument.payMyPrePaidBillsPageDataList[0].serviceType,
        amount: isPrepaidCategoryListEmpty == true ? dueAmount : "",
        currencyCode: "JOD",
        accountNo: savingAccountController.text,
        otpCode: otpCode,
        isNewBiller: isNewBiller,
        prepaidCategoryCode: isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_CODE
            : "",
        prepaidCategoryType: isPrepaidCategoryListEmpty == false
            ? AppConstantsUtils.PREPAID_CATEGORY_TYPE
            : "",
        billingNumberRequired:
            argument.payMyPrePaidBillsPageDataList[0].billingNumber != null &&
                    argument.payMyPrePaidBillsPageDataList[0].billingNumber !=
                        ""
                ? true
                : false,
        CardId: "",
        isCreditCardPayment: false));
  }

  void payPrePaidBillListener() {
    _payPrePaidRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () => payPrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          //to do
          updateLoader();
          _payPrePaidResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            _payPrePaidResponse.safeAdd(event);
          }
        });
      },
    );
  }

  /// ---------------- Call Api GetPrePaidCategoriesList -------------------- ///

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

  final BehaviorSubject<bool> isPrepaidCategoryListEmptyResponse =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isPrepaidCategoryListEmptyStream =>
      isPrepaidCategoryListEmptyResponse.stream;

  void _gerPrePaidCategoriesListener() {
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
          isPrepaidCategoryListEmptyResponse.safeAdd(true);

          if (event.status == Status.SUCCESS) {
            isPrepaidCategoryListEmptyResponse.safeAdd(false);
            getPrepaidCategoriesModelData =
                event.data!.content!.getPrepaidBillerListModelData!;
          }
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  validate() {
    if (isPrepaidCategoryListEmpty == true &&
        double.parse(amtController.text) > 0.0) {
      if (savingAccountController.text.isNotEmpty) {
        _showButtonSubject.safeAdd(true);
      }
    } else if (isPrepaidCategoryListEmpty == false &&
        denominationController.text.isNotEmpty) {
      if (savingAccountController.text.isNotEmpty) {
        _showButtonSubject.safeAdd(true);
      }
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }
}
