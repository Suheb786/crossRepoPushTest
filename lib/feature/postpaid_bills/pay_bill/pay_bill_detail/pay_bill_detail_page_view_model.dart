import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_details_bill_paymemts_model.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list_content.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/utils/validator.dart';
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
  final TextEditingController payFromController = TextEditingController();
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

  final BehaviorSubject<bool> isShowBillerNumber = BehaviorSubject<bool>.seeded(false);

  String? isSelectedBillerName;
  bool isSelectedServiceType = false;
  String? billername;
  String? billerCodeString;
  String? billerType;
  bool isAddThisBillerToSaveList = false;

  List<GetPrepaidCategoriesModelData> getPrepaidCategoriesModelData = [];

  List<BillerDetailsList>? billerDetailsList = [];

  Stream<bool> get isShowBillerNumberStream => isShowBillerNumber.stream;

  void callFromPage() {}

  setData() {
    AppConstantsUtils.SELECTED_BILLING_NUMBER = billingNumberTextControl.text;
    AppConstantsUtils.NICK_NAME = nicknameTextControl.text;
    AppConstantsUtils.ACCOUNT_NUMBER = payFromController.text;
    AddNewDetailsBillPaymentsModel addNewDetailsBillPaymentsModel = AddNewDetailsBillPaymentsModel();

    addNewDetailsBillPaymentsModel.amount = amountTextControl.text;
    addNewDetailsBillPaymentsModel.billerName = billerNameTextController.text;
    addNewDetailsBillPaymentsModel.nickName = nicknameTextControl.text;
    addNewDetailsBillPaymentsModel.refNo = billingNumberTextControl.text;
    addNewDetailsBillPaymentsModel.service = serviceTypeTextControl.text;
    addNewDetailsBillPaymentsModel.isPrepaidCategoryListEmpty = isPrepaidCategoryListEmpty;
    addNewDetailsBillPaymentsModel.accountNumber = payFromController.text;
    return addNewDetailsBillPaymentsModel;
  }

//////////////////
  final BehaviorSubject<bool> isShowAmount = BehaviorSubject<bool>.seeded(false);

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
        isShowAmount.safeAdd(showAmountField);
      }
    }
    isShowAmount.safeAdd(showAmountField);
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  bool isValidated = false;
  bool isNickNameValid = true;

  validateData(BuildContext context) {
    isValidated = false;

    if (billerNameTextController.text != "") {
      isValidated = true;
    } else {
      isValidated = false;
      return;
    }
    if (serviceTypeTextControl.text != "") {
      isValidated = true;
    } else {
      isValidated = false;
      return;
    }

    if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
      AppConstantsUtils.POST_PAID_FLOW = true;
      AppConstantsUtils.PRE_PAID_FLOW = false;
      AppConstantsUtils.IS_NEW_PAYMENT = true;

      if (billingNumberTextControl.text.trim() != "") {
        isValidated = true;
        if (isAddThisBillerToSaveList) {
          isValidated = false;
          nickNameValidation();
        }
      }
      if (!isValidated) {
        _showButtonSubject.safeAdd(false);
        return;
      }
    } else if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.PREPAID_KEY) {
      AppConstantsUtils.POST_PAID_FLOW = false;
      AppConstantsUtils.PRE_PAID_FLOW = true;
      AppConstantsUtils.IS_NEW_PAYMENT = true;

      isValidated = false;
      if (amountTextControl.text.trim() != "" || denominationTextController.text.trim() != "") {
        isValidated = true;
        if (isShowBillingNumberSizeBox) {
          isValidated = false;
          if (billingNumberTextControl.text.trim() != "") {
            isValidated = true;
            if (isAddThisBillerToSaveList) {
              isValidated = false;
              nickNameValidation();
            }
          }
        } else {
          if (isAddThisBillerToSaveList) {
            isValidated = false;
            nickNameValidation();
          }
        }
      } else {
        isValidated = false;
      }

      if (!isValidated) {
        _showButtonSubject.safeAdd(false);
        return;
      }
    }
    isValidated = false;
    if (payFromController.text.trim() != "") {
      isValidated = true;
    }

    _showButtonSubject.safeAdd(isValidated);
  }

  addThisBillerToSaveList(value, context) {
    isAddThisBillerToSaveList = value;
    validateData(context);
  }

//////////////////

  void updateStreamForBillingNumber(bool value) {
    isShowBillerNumber.add(value);
    isShowBillingNumberSizeBox = value;
    SELECTED_BILLING_NUMBER_REQUIRED = value;
  }

  PublishSubject<bool> _switchStatusSubject = PublishSubject();
  GetPrePaidCategoriesListUseCase getPrePaidCategoriesListUseCase;

  GetBillerLookupUseCase getBillerLookupUseCase;

  Stream<bool> get totalBillAmtDueStream => _switchStatusSubject.stream;

  void switchStatus(bool isActive) {
    _switchStatusSubject.safeAdd(isActive);
  }

  PayBillDetailPageViewModel(this.getPrePaidCategoriesListUseCase, this.getBillerLookupUseCase) {
    _gerPrePaidCategoriesListener();
    billerLookUpListListener();
  }

  /// ---------------- Call Api Get biller look up list -------------------- ///
  PublishSubject<GetBillerLookupUseCaseParams> _getBillerLookupRequest = PublishSubject();

  PublishSubject<Resource<GetBillerLookUpList>> _getBillerLookupResponse = PublishSubject();

  Stream<Resource<GetBillerLookUpList>> get getBillerLookupStream => _getBillerLookupResponse.stream;

  void billerList() {
    billerDetailsList = AppConstantsUtils.billerDetailsCacheList;
    if (billerDetailsList == null || billerDetailsList!.isEmpty) {
      _getBillerLookupRequest.safeAdd(GetBillerLookupUseCaseParams(
          categoryName: AppConstantsUtils.BILLER_CATEGORY,
          type: AppConstantsUtils.POST_PAID_FLOW == true
              ? AppConstantsUtils.POSTPAID_KEY.toString().toLowerCase()
              : AppConstantsUtils.PREPAID_KEY.toString().toLowerCase()));
    } else {
      _getBillerLookupResponse.safeAdd(Resource.success(
          data: GetBillerLookUpList(
              content: GetBillerLookupListContent(billerDetailsList: billerDetailsList))));
    }
  }

  void billerLookUpListListener() {
    _getBillerLookupRequest.listen(
          (params) {
        RequestManager(
          params,
          createCall: () => getBillerLookupUseCase.execute(
            params: params,
          ),
        ).asFlow().listen((event) {
          updateLoader();
          _getBillerLookupResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          }
        });
      },
    );
  }

  /// ---------------- Call Api GetPrePaidCategoriesList -------------------- ///

  PublishSubject<GetPrePaidCategoriesListUseCaseParams> _getPrePaidCategoriesRequest = PublishSubject();

  PublishSubject<Resource<GetPrePaidCategoriesModel>> _gerPrePaidCategoriesResponse = PublishSubject();

  Stream<Resource<GetPrePaidCategoriesModel>> get gerPrePaidCategoriesStream =>
      _gerPrePaidCategoriesResponse.stream;

  void getPrePaidCategoriesList(String? serviceCode, String? billerCode) {
    _getPrePaidCategoriesRequest.safeAdd(
      GetPrePaidCategoriesListUseCaseParams(billerCode: billerCode, serviceCode: serviceCode),
    );
  }

  final BehaviorSubject<bool> isPrepaidCategoryListEmptyResponse = BehaviorSubject<bool>.seeded(true);

  Stream<bool> get isPrepaidCategoryListEmptyStream => isPrepaidCategoryListEmptyResponse.stream;
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
            getPrepaidCategoriesModelData = event.data!.content!.getPrepaidBillerListModelData!;
          }
          if (event.status == Status.ERROR) {
            // showToastWithError(event.appError!);
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
    _getBillerLookupRequest.close();
    _getBillerLookupResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }

  void nickNameValidation() {
    if (nicknameTextControl.text.trim() == "") {
      isValidated = false;
      return;
    } else {
      if (Validator.nickName(nicknameTextControl.text) == false) {
        isValidated = false;
        isNickNameValid = false;
        return;
      } else {
        isNickNameValid = true;
        isValidated = true;
      }
    }
  }
}
