// import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';
// import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
// import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';
// import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
// import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
// import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:neo_bank/base/base_page_view_model.dart';
// import 'package:neo_bank/utils/app_constants.dart';
// import 'package:neo_bank/utils/extension/stream_extention.dart';
// import 'package:neo_bank/utils/request_manager.dart';
// import 'package:neo_bank/utils/resource.dart';
// import 'package:neo_bank/utils/status.dart';
// import 'package:rxdart/rxdart.dart';
//
// class PayPrePaidBillDetailPageViewModel extends BasePageViewModel {
//   final ScrollController controller = ScrollController();
//   final TextEditingController refNoController = TextEditingController();
//   final TextEditingController payFromController = TextEditingController();
//   String fieldTextLabelEn = "Enter Billing Number";
//
//   var denominationTextController = TextEditingController(text: '');
//   final billerNameTextController = TextEditingController();
//   final serviceTypeTextControl = TextEditingController();
//   var serviceTypeApiVal = "";
//   final billerCodeTextControl = TextEditingController();
//   final billingNumberTextControl = TextEditingController(text: '');
//   final nicknameTextControl = TextEditingController(text: '');
//   final amountTextControl = TextEditingController(text: '');
//   final serviceDescriptionEn = TextEditingController(text: '');
//   GetPrePaidCategoriesListUseCase getPrePaidCategoriesListUseCase;
//   GetBillerLookupUseCase getBillerLookupUseCase;
//
//   bool isShowBillingNumberSizeBox = false;
//   bool isShowDemominationSizeBox = false;
//
//   bool SELECTED_BILLING_NUMBER_REQUIRED = false;
//
//   List<BillerService> billerService = [];
//
//   final BehaviorSubject<bool> isShowBillerNumber =
//       BehaviorSubject<bool>.seeded(false);
//
//   String? isSelectedBillerName;
//   bool isSelectedServiceType = false;
//   String? billername;
//   String? billerCodeString;
//   String? billerType;
//   bool? isPrepaidCategoryListEmpty = false;
//
//   List<BillerDetailsList>? billerDetailsList = [];
//
//   Stream<bool> get isShowBillerNumberStream => isShowBillerNumber.stream;
//
//   void callFromPage() {}
//
// //////////////////
//   final BehaviorSubject<bool> isShowAmount =
//       BehaviorSubject<bool>.seeded(false);
//
//   Stream<bool> get isShowAmountStream => isShowAmount.stream;
//   bool showAmountField = false;
//
//   void updateStreamForShowAmount(bool value) {
//     isShowAmount.add(value);
//     isShowDemominationSizeBox = value;
//     if (isShowDemominationSizeBox) {
//       showAmountField = false;
//     } else {
//       if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
//         showAmountField = false;
//       } else {
//         showAmountField = true;
//       }
//     }
//
//     notifyListeners();
//   }
//
//
//   // final ScrollController controller = ScrollController();
//   final TextEditingController billNameController = TextEditingController();
//   final TextEditingController serviceController = TextEditingController();
//   // final TextEditingController refNoController = TextEditingController();
//   // final TextEditingController nickNameController = TextEditingController();
//   // final TextEditingController payFromController = TextEditingController();
//
//   PublishSubject<bool> _switchStatusSubject = PublishSubject();
//
//   Stream<bool> get totalBillAmtDueStream => _switchStatusSubject.stream;
//
//   void switchStatus(bool isActive) {
//     _switchStatusSubject.safeAdd(isActive);
//   }
//
//   void updateStreamForBillingNumber(bool value) {
//     isShowBillerNumber.add(value);
//     isShowBillingNumberSizeBox = value;
//     SELECTED_BILLING_NUMBER_REQUIRED = value;
//   }
//
//   PayPrePaidBillDetailPageViewModel(
//       this.getPrePaidCategoriesListUseCase, this.getBillerLookupUseCase) {
//     prePaidCategoriesRequestListener();
//     billerLookUpListListener();
//   }
//
//   /// ---------------- Call Api Get biller look up list -------------------- ///
//   PublishSubject<GetBillerLookupUseCaseParams> _getBillerLookupRequest =
//       PublishSubject();
//
//   PublishSubject<Resource<GetBillerLookUpList>> _getBillerLookupResponse =
//       PublishSubject();
//
//   Stream<Resource<GetBillerLookUpList>> get getBillerLookupStream =>
//       _getBillerLookupResponse.stream;
//
//   void billerList() {
//     _getBillerLookupRequest.safeAdd(
//       GetBillerLookupUseCaseParams(
//           categoryName: AppConstantsUtils.BILLER_CATEGORY),
//     );
//   }
//
//   void billerLookUpListListener() {
//     _getBillerLookupRequest.listen(
//       (params) {
//         RequestManager(
//           params,
//           createCall: () => getBillerLookupUseCase.execute(
//             params: params,
//           ),
//         ).asFlow().listen((event) {
//           updateLoader();
//           _getBillerLookupResponse.safeAdd(event);
//           if (event.status == Status.ERROR) {
//             showToastWithError(event.appError!);
//           }
//         });
//       },
//     );
//   }
//
//   /// ---------------- Call Api GetPrePaidCategoriesList -------------------------------- ///
//
//   PublishSubject<GetPrePaidCategoriesListUseCaseParams>
//       _gerPrePaidCategoriesRequest = PublishSubject();
//
//   PublishSubject<Resource<GetPrePaidCategoriesModel>>
//       _gerPrePaidCategoriesResponse = PublishSubject();
//
//   Stream<Resource<GetPrePaidCategoriesModel>> get gerPrePaidCategoriesStream =>
//       _gerPrePaidCategoriesResponse.stream;
//
//   void getPrePaidCategoriesList(String? serviceCode, String? billerCode) {
//     _gerPrePaidCategoriesRequest.safeAdd(
//       GetPrePaidCategoriesListUseCaseParams(
//           billerCode: billerCode, serviceCode: serviceCode),
//     );
//   }
//
//   void prePaidCategoriesRequestListener() {
//     _gerPrePaidCategoriesRequest.listen(
//           (params) {
//         RequestManager(
//           params,
//           createCall: () => getPrePaidCategoriesListUseCase.execute(
//             params: params,
//           ),
//         ).asFlow().listen((event) {
//           updateLoader();
//           _gerPrePaidCategoriesResponse.safeAdd(event);
//           if (event.status == Status.ERROR) {
//             showToastWithError(event.appError!);
//           }
//         });
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _switchStatusSubject.close();
//     super.dispose();
//   }
// }
