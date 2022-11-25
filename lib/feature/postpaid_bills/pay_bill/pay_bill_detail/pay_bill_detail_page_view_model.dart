import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:domain/model/bill_payments/add_new_prepaid_biller/add_new_prepaid_biller_model.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
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
  final TextEditingController refNoController = TextEditingController();
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
  bool? isPrepaidCategoryListEmpty = false;
  bool isAddThisBillerToSaveList = false;


  List<GetPrepaidCategoriesModelData> getPrepaidCategoriesModelData = [];

  Stream<bool> get isShowBillerNumberStream => isShowBillerNumber.stream;

  void callFromPage() {}

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

    notifyListeners();
  }


  bool isValidated = false;

  validateData() {
    isValidated = false;
    if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
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
    notifyListeners();
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
  AddNewPostpaidBillerUseCase addNewPostpaidBillerUseCase;
  AddNewPrepaidBillerUseCase addNewPrepaidBillerUseCase;
  GetPrePaidCategoriesListUseCase getPrePaidCategoriesListUseCase;

  Stream<bool> get totalBillAmtDueStream => _switchStatusSubject.stream;

  void switchStatus(bool isActive) {
    _switchStatusSubject.safeAdd(isActive);
  }

  PayBillDetailPageViewModel(this.addNewPostpaidBillerUseCase,
      this.addNewPrepaidBillerUseCase, this.getPrePaidCategoriesListUseCase) {
    _addNewPostpaidBillerListener();
    _addNewPrepaidBillerListener();
    _gerPrePaidCategoriesListener();
  }

  /// ---------------- Call Api AddNewPostpaidBiller -------------------- ///

  PublishSubject<AddNewPostpaidBillerUseCaseParams>
      _addNewPostpaidBillerRequest = PublishSubject();

  PublishSubject<Resource<AddNewPostpaidBillerModel>>
      _addNewPostpaidBillerResponce = PublishSubject();

  Stream<Resource<AddNewPostpaidBillerModel>> get addNewPostpaidStream =>
      _addNewPostpaidBillerResponce.stream;

  void addNewPostpaidBiller() {
    _addNewPostpaidBillerRequest.safeAdd(
      AddNewPostpaidBillerUseCaseParams(
        serviceType: serviceTypeApiVal.trim(),
        billerCode: billerCodeTextControl.text.trim(),
        billingNumber: billingNumberTextControl.text.trim(),
        nickname: nicknameTextControl.text.trim(),
      ),
    );
  }

  void _addNewPostpaidBillerListener() {
    _addNewPostpaidBillerRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    addNewPostpaidBillerUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _addNewPostpaidBillerResponce.safeAdd(event);
        });
      },
    );
  }

  /// ---------------- Call Api AddNewPrepaidBiller -------------------- ///

  PublishSubject<Resource<AddNewPrepaidBillerModel>>
      _addNewPrepaidBillerResponce = PublishSubject();

  Stream<Resource<AddNewPrepaidBillerModel>> get addNewPrepaidBillerStream =>
      _addNewPrepaidBillerResponce.stream;

  PublishSubject<AddNewPrepaidBillerUseCaseParams> _addNewPrepaidBillerRequest =
      PublishSubject();

  void addNewPrepaidBiller() {
    _addNewPrepaidBillerRequest.safeAdd(
      AddNewPrepaidBillerUseCaseParams(
          prepaidCategoryType: AppConstantsUtils.PREPAID_CATEGORY_TYPE,
          prepaidCategoryCode: AppConstantsUtils.PREPAID_CATEGORY_CODE,
          serviceType: AppConstantsUtils.SELECTED_SERVICE_TYPE,
          serviceCode: AppConstantsUtils.SELECTED_SERVICE_CODE,
          billerCode: AppConstantsUtils.SELECTED_BILLER_CODE,
          billerName: AppConstantsUtils.BILLER_NAME,
          billingNumber: billingNumberTextControl.text.trim(),
          nickname: nicknameTextControl.text.trim(),
          amount: amountTextControl.text.trim(),
          billingNumberRequired:
              AppConstantsUtils.SELECTED_BILLING_NUMBER_REQUIRED),
    );
  }

  void _addNewPrepaidBillerListener() {
    _addNewPrepaidBillerRequest.listen(
      (params) {
        RequestManager(params,
                createCall: () =>
                    addNewPrepaidBillerUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
              updateLoader();
          _addNewPrepaidBillerResponce.safeAdd(event);
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
          isPrepaidCategoryListEmpty = true;

          if (event.status == Status.SUCCESS) {
            isPrepaidCategoryListEmpty = false;
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
    _addNewPostpaidBillerRequest.close();
    _addNewPostpaidBillerResponce.close();
    serviceTypeTextControl.dispose();
    _switchStatusSubject.close();
    super.dispose();
  }
}
