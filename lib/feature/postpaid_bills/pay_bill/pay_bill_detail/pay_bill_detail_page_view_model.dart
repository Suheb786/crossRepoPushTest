import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class PayBillDetailPageViewModel extends BasePageViewModel {
  final ScrollController controller = ScrollController();
  final TextEditingController refNoController = TextEditingController();
  final TextEditingController payFromController = TextEditingController()
    ..text = 'Savings Account';
  String fieldTextLabelEn = "Enter Billing Number";


  var denominationTextController = TextEditingController(text: '');
  final billerNameTextController = TextEditingController();
  final serviceTypeTextControl = TextEditingController();
  var serviceTypeApiVal = "";
  final billerCodeTextControl = TextEditingController();
  final billingNumberTextControl = TextEditingController(text: '');
  final nicknameTextControl = TextEditingController(text: '');
  final amountTextControl = TextEditingController(text: '');
  final serviceDescriptionEn = TextEditingController(text: '');
  bool isShowBillingNumberSizeBox = false;
  bool isShowDemominationSizeBox = false;

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
//////////////////

  void updateStreamForBillingNumber(bool value) {
    isShowBillerNumber.add(value);
    isShowBillingNumberSizeBox = value;
    SELECTED_BILLING_NUMBER_REQUIRED = value;
  }

  PublishSubject<bool> _switchStatusSubject = PublishSubject();
  AddNewPostpaidBillerUseCase addNewPostpaidBillerUseCase;

  Stream<bool> get totalBillAmtDueStream => _switchStatusSubject.stream;

  void switchStatus(bool isActive) {
    _switchStatusSubject.safeAdd(isActive);
  }

  PayBillDetailPageViewModel(
      this.addNewPostpaidBillerUseCase) {
    _addNewPostpaidBillerListener();
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
          _addNewPostpaidBillerResponce.safeAdd(event);
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
