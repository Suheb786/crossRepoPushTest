import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:domain/model/bill_payments/add_new_prepaid_biller/add_new_prepaid_biller_model.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_details_bill_paymemts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PayBillDetailPageViewModel extends BasePageViewModel {
  final ScrollController controller = ScrollController();
  final TextEditingController payFromController = TextEditingController()
    ..text = 'Savings Account';
  String fieldTextLabelEn = "Enter Billing Number";

  var denominationTextController = TextEditingController();
  final billerNameTextController = TextEditingController();
  final serviceTypeTextControl = TextEditingController();
  var serviceTypeApiVal = "";
  final billerCodeTextControl = TextEditingController();
  final billingNumberTextControl = TextEditingController();
  final nicknameTextControl = TextEditingController();
  final amountTextControl = TextEditingController();
  final serviceDescriptionEn = TextEditingController();
  bool isShowBillingNumberSizeBox = false;
  bool isShowDemominationSizeBox = false;
  var nickName = "";

  bool SELECTED_BILLING_NUMBER_REQUIRED = false;

  List<BillerService> billerService = [];

  final BehaviorSubject<bool> isShowBillerNumber =
      BehaviorSubject<bool>.seeded(false);

  String? isSelectedBillerName;
  bool isSelectedServiceType = false;
  String? billername;
  String? billerCodeString;
  String? billerType;
  bool isAddThisBillerToSaveList = false;

  List<GetPrepaidCategoriesModelData> getPrepaidCategoriesModelData = [];

  Stream<bool> get isShowBillerNumberStream => isShowBillerNumber.stream;

  void callFromPage() {}

  setData() {
    AppConstantsUtils.SELECTED_BILLING_NUMBER = billingNumberTextControl.text;
    AppConstantsUtils.NICK_NAME = nicknameTextControl.text;
    AppConstantsUtils.ACCOUNT_NUMBER = payFromController.text;
    AddNewDetailsBillPaymentsModel addNewDetailsBillPaymentsModel =
        AddNewDetailsBillPaymentsModel();

    addNewDetailsBillPaymentsModel.amount = amountTextControl.text;
    addNewDetailsBillPaymentsModel.billerName = billerNameTextController.text;
    addNewDetailsBillPaymentsModel.nickName = nicknameTextControl.text;
    addNewDetailsBillPaymentsModel.refNo = billingNumberTextControl.text;
    addNewDetailsBillPaymentsModel.service = serviceTypeTextControl.text;
    addNewDetailsBillPaymentsModel.isPrepaidCategoryListEmpty =
        isPrepaidCategoryListEmpty;
    addNewDetailsBillPaymentsModel.accountNumber = payFromController.text;
    return addNewDetailsBillPaymentsModel;
  }

//////////////////
  final BehaviorSubject<bool> isShowAmount =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isShowAmountStream => isShowAmount.stream;
  bool showAmountField = false;

  void updateStreamForShowAmount(bool value) {
    isShowAmount.add(value);
    isShowDemominationSizeBox = value;
    if (isShowDemominationSizeBox) {
      showAmountField = false;
    } else {
      if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
        showAmountField = false;
      } else {
        showAmountField = true;
      }
    }
    isShowAmount.safeAdd(showAmountField);
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  bool isValidated = false;

  validateData() {
    isValidated = false;
    if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
      AppConstantsUtils.POST_PAID_FLOW = true;
      AppConstantsUtils.PRE_PAID_FLOW = false;
      AppConstantsUtils.IS_NEW_PAYMENT = true;

      if (billingNumberTextControl.text.trim() != "") {
        isValidated = true;
        if (isAddThisBillerToSaveList) {
          isValidated = false;
          if (nicknameTextControl.text.trim() != "") {
            isValidated = true;
          }
        }
      }
    }
    if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.PREPAID_KEY) {
      AppConstantsUtils.POST_PAID_FLOW = false;
      AppConstantsUtils.PRE_PAID_FLOW = true;
      AppConstantsUtils.IS_NEW_PAYMENT = true;

      isValidated = false;
      if (amountTextControl.text.trim() != "" ||
          denominationTextController.text.trim() != "") {
        isValidated = true;
        if (isShowBillingNumberSizeBox) {
          isValidated = false;
          if (billingNumberTextControl.text.trim() != "") {
            isValidated = true;
            if (isAddThisBillerToSaveList) {
              isValidated = false;
              if (nicknameTextControl.text.trim() != "") {
                isValidated = true;
              }
            }
          }
        } else {
          if (isAddThisBillerToSaveList) {
            isValidated = false;
            if (nicknameTextControl.text.trim() != "") {
              isValidated = true;
            }
          }
        }
      } else {
        isValidated = false;
      }
    }
    _showButtonSubject.safeAdd(isValidated);
  }

  addThisBillerToSaveList(value) {
    isAddThisBillerToSaveList = value;
    validateData();
  }

//////////////////

  void updateStreamForBillingNumber(bool value) {
    isShowBillerNumber.add(value);
    isShowBillingNumberSizeBox = value;
    SELECTED_BILLING_NUMBER_REQUIRED = value;
  }

  PublishSubject<bool> _switchStatusSubject = PublishSubject();
  GetPrePaidCategoriesListUseCase getPrePaidCategoriesListUseCase;

  Stream<bool> get totalBillAmtDueStream => _switchStatusSubject.stream;

  void switchStatus(bool isActive) {
    _switchStatusSubject.safeAdd(isActive);
  }

  PayBillDetailPageViewModel(this.getPrePaidCategoriesListUseCase) {
    _gerPrePaidCategoriesListener();
  }

  /// ---------------- Call Api GetPrePaidCategoriesList -------------------- ///

  PublishSubject<GetPrePaidCategoriesListUseCaseParams>
      _getPrePaidCategoriesRequest = PublishSubject();

  PublishSubject<Resource<GetPrePaidCategoriesModel>>
      _gerPrePaidCategoriesResponse = PublishSubject();

  Stream<Resource<GetPrePaidCategoriesModel>> get gerPrePaidCategoriesStream =>
      _gerPrePaidCategoriesResponse.stream;

  void getPrePaidCategoresList(String? serviceCode, String? billerCode) {
    _getPrePaidCategoriesRequest.safeAdd(
      GetPrePaidCategoriesListUseCaseParams(
          billerCode: billerCode, serviceCode: serviceCode),
    );
  }

  final BehaviorSubject<bool> isPrepaidCategoryListEmptyResponse =
      BehaviorSubject<bool>.seeded(true);

  Stream<bool> get isPrepaidCategoryListEmptyStream =>
      isPrepaidCategoryListEmptyResponse.stream;
  bool isPrepaidCategoryListEmpty = false;

  updateIsPrepaidCategoryListEmptyResponse(bool isPrepaidCategoryListEmpty) {
    isPrepaidCategoryListEmptyResponse.safeAdd(true);
  }

  void _gerPrePaidCategoriesListener() {
    _getPrePaidCategoriesRequest.listen(
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

  @override
  void dispose() {
    _getPrePaidCategoriesRequest.close();
    _gerPrePaidCategoriesResponse.close();
    serviceTypeTextControl.dispose();
    _switchStatusSubject.close();
    super.dispose();
  }
}
