import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/validate_prepaid_biller/validate_prepaid_biller.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'how_much_like_to_pay_prepaid_bills_page.dart';

class HowMuchLikeToPayPrePaidBillsPageViewModel extends BasePageViewModel {
  final HowMuchLikeToPayPrePaidBillsPageArgument argument;
  final ValidatePrePaidUseCase validatePrePaidUseCase;
  final PayPrePaidUseCase payPrePaidUseCase;
  bool isPrepaidCategoryListEmpty = false;
  Account? selectedAccount;

  TextEditingController amtController = TextEditingController(text: "0.0");
  final GlobalKey<AppTextFieldState> amtKey = GlobalKey(debugLabel: "amtKey");

  String? serviceDescriptionEn = "";
  String? billerCode = "";
  String? billingNumber = "";
  String? serviceType = "";
  String? categoryCode = "";
  String? currencyCode = "JOD";
  String? accountNo = "";
  String? otpCode = "";
  String? validationCode = "";
  bool? isNewBiller = false;
  String? prepaidCategoryCode = "";
  String? prepaidCategoryType = "";
  String? dueAmount = "0";
  String? feesAmt = "0";
  bool? billingNumberRequired = false;
  bool? isCreditCardPayment = false;

  List<GetPrepaidCategoriesModelData> getPrepaidCategoriesModelData = [];

  HowMuchLikeToPayPrePaidBillsPageViewModel(
      this.argument, this.validatePrePaidUseCase, this.payPrePaidUseCase) {
    if (isPrepaidCategoryListEmpty == false) {
      if (argument.validatePrePaidBillData != null) {
        _validatePrePaidResponse
            .safeAdd(Resource.success(data: ValidatePrePaidBill(content: argument.validatePrePaidBillData)));
      }
    }
    validatePrePaidBillListener();
    payPrePaidBillListener();
  }

  bool validatePrepaidCall = false;

  /// ---------------- validate prepaid bill -------------------------------- ///
  PublishSubject<ValidatePrePaidUseCaseParams> _validatePrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<ValidatePrePaidBill>> _validatePrePaidResponse = BehaviorSubject();

  Stream<Resource<ValidatePrePaidBill>> get validatePrePaidStream => _validatePrePaidResponse.stream;

  void validatePrePaidBill() {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("new_pre_paid_inquire_bill", {"new_pre_paid_inquire_bill_call": true});
    _validatePrePaidRequest.safeAdd(ValidatePrePaidUseCaseParams(
        fromAccount: selectedAccount?.accountNo ?? '',
        billerCode: argument.payMyPrePaidBillsPageDataList[0].billerCode,
        amount: isPrepaidCategoryListEmpty == true
            ? (amtController.text.isNotEmpty ? double.parse(amtController.text).toStringAsFixed(3) : '')
            : "",
        serviceType: argument.payMyPrePaidBillsPageDataList[0].serviceType,
        billingNumber: argument.payMyPrePaidBillsPageDataList[0].billingNumber,
        prepaidCategoryCode:
            isPrepaidCategoryListEmpty == false ? AppConstantsUtils.PREPAID_CATEGORY_CODE : "",
        prepaidCategoryType:
            isPrepaidCategoryListEmpty == false ? AppConstantsUtils.PREPAID_CATEGORY_TYPE : "",
        billingNumberRequired: argument.payMyPrePaidBillsPageDataList[0].billingNumber != null &&
                argument.payMyPrePaidBillsPageDataList[0].billingNumber != ""
            ? true
            : false));
  }

  void validatePrePaidBillListener() {
    _validatePrePaidRequest.listen(
      (params) {
        RequestManager(params, createCall: () => validatePrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _validatePrePaidResponse.safeAdd(event);

          if (event.status == Status.ERROR) {
            if (event.appError!.type == ErrorType.ENTER_AMOUNT) {
              amtKey.currentState!.isValid = false;
            }

            ///LOG EVENT TO FIREBASE
            FireBaseLogUtil.fireBaseLog(
                "new_pre_paid_inquire_bill_fail_call", {"new_pre_paid_inquire_bill_fail": true});
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- pay prepaid bill -------------------------------- ///
  PublishSubject<PayPrePaidUseCaseParams> _payPrePaidRequest = PublishSubject();

  BehaviorSubject<Resource<PayPrePaid>> _payPrePaidResponse = BehaviorSubject();

  Stream<Resource<PayPrePaid>> get payPrePaidStream => _payPrePaidResponse.stream;

  ///already saved flow.
  void payPrePaidBill(BuildContext context) {
    if (_showButtonSubject.value) {
      if (double.parse(selectedAccount?.availableBalance ?? '-1') >= double.parse(amtController.text)) {
        if (validatePrepaidCall) {
          ///LOG EVENT TO FIREBASE
          FireBaseLogUtil.fireBaseLog("pay_pre_paid_saved_bill", {"pay_pre_paid_saved_bill_call": true});
          _payPrePaidRequest.safeAdd(PayPrePaidUseCaseParams(
              billerName: StringUtils.isDirectionRTL(context)
                  ? argument.payMyPrePaidBillsPageDataList[0].billerNameAR
                  : argument.payMyPrePaidBillsPageDataList[0].billerName,
              billerCode: billerCode,
              billingNumber: billingNumber,
              serviceType: argument.payMyPrePaidBillsPageDataList[0].serviceType,
              amount:
                  amtController.text.isNotEmpty ? double.parse(amtController.text).toStringAsFixed(3) : '',
              fees: double.parse(feesAmt ?? "0").toStringAsFixed(3),
              validationCode: validationCode ?? "",
              currencyCode: "JOD",
              accountNo: selectedAccount?.accountNo ?? '',
              otpCode: "",
              isNewBiller: false,
              nickName: argument.payMyPrePaidBillsPageDataList[0].nickname ?? "",

              /// only need to be added in case of new biller added request
              prepaidCategoryCode:
                  isPrepaidCategoryListEmpty == false ? AppConstantsUtils.PREPAID_CATEGORY_CODE : "",
              prepaidCategoryType:
                  isPrepaidCategoryListEmpty == false ? AppConstantsUtils.PREPAID_CATEGORY_TYPE : "",
              billingNumberRequired: argument.payMyPrePaidBillsPageDataList[0].billingNumber != null &&
                      argument.payMyPrePaidBillsPageDataList[0].billingNumber != ""
                  ? true
                  : false,
              CardId: "",
              isCreditCardPayment: false));
        }
      } else {
        showToastWithError(AppError(
            cause: Exception(),
            error: ErrorInfo(message: ''),
            type: ErrorType.INSUFFICIENT_FUNDS_BILL_CANNOT_BE_PAYED));
      }
    }
  }

  void payPrePaidBillListener() {
    _payPrePaidRequest.listen(
      (params) {
        RequestManager(params, createCall: () => payPrePaidUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _payPrePaidResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {}
        });
      },
    );
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  validate(String? amount) {
    if ((double.tryParse(amount ?? "0") ?? 0.0) > 0.0) {
      _showButtonSubject.safeAdd(true);
    }
  }
}
