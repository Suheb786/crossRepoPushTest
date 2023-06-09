import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model_data.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_list_data.dart';
import 'package:domain/usecase/bill_payment/get_postpaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_customer_billing_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PayAllPostPaidBillsPageViewModel extends BasePageViewModel {
  final PayAllPostPaidBillsPageArguments arguments;

  final GetPostpaidBillerListUseCase getPostpaidBillerListUseCase;
  final RemoveCustomerBillingUseCase removeCustomerBillingUseCase;
  final PostPaidBillInquiryUseCase postPaidBillInquiryUseCase;

  final TextEditingController searchBillController = TextEditingController();
  List<GetPostpaidBillerListModelData> payPostPaidBillsDataList = [];
  List<GetPostpaidBillerListModelData> fList = [];
  List<GetPostpaidBillerListModelData> mList = [];
  List<GetPostpaidBillerListModelData> selectedPostPaidBillsList = [];
  List<PostpaidBillInquiry> postPaidRequestListJson = [];
  List<PostPaidBillInquiryData>? postPaidBillInquiryData = [];

  PublishSubject<List<GetPostpaidBillerListModelData>> _itemSelectedSubject = PublishSubject();

  Stream<List<GetPostpaidBillerListModelData>> get itemSelectedStream => _itemSelectedSubject.stream;

  BehaviorSubject<double> _totalBillAmtDueSubject = BehaviorSubject();

  Stream<double> get totalBillAmtDueStream => _totalBillAmtDueSubject.stream;

  double totalBillAmt = 0.0;

  PayAllPostPaidBillsPageViewModel(this.getPostpaidBillerListUseCase, this.removeCustomerBillingUseCase,
      this.postPaidBillInquiryUseCase, this.arguments) {
    getPostpaidBiller();
    postPaidBillerListener();
    removeCustomerBillingListener();
    postPaidBillInquiryListener();
  }

  isDisabledConditions(GetPostpaidBillerListModelData item) {
    var flag1 = (double.parse(item.actualdueAmountFromApi ?? "0.0") <= 0.0 && item.isPartial == false);
    var flag2 = (double.parse(item.actualdueAmountFromApi ?? "0.0") <= 0.0 &&
        item.isPartial == true &&
        double.parse(item.maxValue ?? "0.0") <= 0.0);
    var flag3 = (item.expDateStatus == false);
    var isDisable = flag1 || flag2 || flag3;
    return isDisable;
  }

  void selectedItem(int index, bool isFromSelectedItem) {
    if (payPostPaidBillsDataList.isNotEmpty) {
      if (payPostPaidBillsDataList[index].isChecked == true &&
          !isDisabledConditions(payPostPaidBillsDataList[index])) {
        payPostPaidBillsDataList[index].isChecked = false;
        totalBillAmt =
            totalBillAmt - double.parse(payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0.0");
        postPaidRequestListJson = postPaidRequestListJson.toSet().toList();
        _totalBillAmtDueSubject.safeAdd(totalBillAmt);
        _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
      } else {
        payPostPaidBillsDataList[index].isChecked = true;
        if (payPostPaidBillsDataList[index].isPartial == true &&
            double.parse(payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0") <= 0.0 &&
            double.parse(payPostPaidBillsDataList[index].maxValue ?? "0") <= 0.0) {
          payPostPaidBillsDataList[index].isChecked = false;
        }

        /// expired/open/close date bill
        else if (payPostPaidBillsDataList[index].expDateStatus == false) {
          payPostPaidBillsDataList[index].isChecked = false;
        }
        postPaidRequestListJson = [];
        postPaidRequestListJson.add(PostpaidBillInquiry(
          billerCode: payPostPaidBillsDataList[index].billerCode,
          serviceType: payPostPaidBillsDataList[index].serviceType,
          billingNumber: payPostPaidBillsDataList[index].billingNo,
          nickName: payPostPaidBillsDataList[index].nickName,
        ));
        selectedPostPaidBillsList.add(payPostPaidBillsDataList[index]);
        selectedPostPaidBillsList = selectedPostPaidBillsList.toSet().toList();
        postPaidRequestListJson = postPaidRequestListJson.toSet().toList();

        totalBillAmt =
            totalBillAmt + double.parse(payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0.0");
        selectedIndex = index;
        _totalBillAmtDueSubject.safeAdd(totalBillAmt);
        _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
        if (payPostPaidBillsDataList[index].dueAmount != null &&
                payPostPaidBillsDataList[index].dueAmount!.isNotEmpty ||
            payPostPaidBillsDataList[index].dueAmount != null &&
                payPostPaidBillsDataList[index].dueAmount == "0") {
          if (postPaidBillInquiryData == null || postPaidBillInquiryData!.isEmpty) {
            postPaidBillInquiry(postPaidRequestListJson,
                isFromSelectedItem: isFromSelectedItem, index: index);
          } else {
            if (payPostPaidBillsDataList[index].isAmountUpdatedFromApi == false) {
              postPaidBillInquiry(postPaidRequestListJson,
                  isFromSelectedItem: isFromSelectedItem, index: index);
            } else {
              postpaidBillEnquiryOnSuccessMethod(postPaidBillInquiryData,
                  isFromSelectedItem: isFromSelectedItem, index: index, isFromApiCall: false);
            }
          }
        }
      }
    }
  }

  void postPaidRequestJsonListMethod() {
    selectedPostPaidBillsList = [];
    postPaidRequestListJson = [];
    if (arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS) {
      for (var item in payPostPaidBillsDataList) {
        item.isChecked = true;
        if (item.isPartial == true &&
            double.parse(item.actualdueAmountFromApi ?? "0") <= 0.0 &&
            double.parse(item.maxValue ?? "0") <= 0.0) {
          item.isChecked = false;
        }

        /// expired/open/close date bill
        else if (item.expDateStatus == false) {
          item.isChecked = false;
        }
        postPaidRequestListJson.add(PostpaidBillInquiry(
          billerCode: item.billerCode,
          serviceType: item.serviceType,
          billingNumber: item.billingNo,
          nickName: item.nickName,
        ));
        selectedPostPaidBillsList.add(item);
      }
      selectedPostPaidBillsList = selectedPostPaidBillsList.toSet().toList();
      postPaidRequestListJson = postPaidRequestListJson.toSet().toList();
      _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
      postPaidBillInquiry(postPaidRequestListJson, isFromSelectedItem: false, index: 0);
    }
  }

  void addAllBillAmt(List<GetPostpaidBillerListModelData> list) {
    totalBillAmt = 0.0;
    list.forEach((element) {
      if (element.isChecked == true) {
        totalBillAmt = double.parse(element.actualdueAmountFromApi ?? "0.0") + totalBillAmt;
      }
    });
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
  }

  /// ---------------- Call Api GetPostpaidBillerList -------------------------------- ///
  BehaviorSubject<GetPostpaidBillerListUseCaseParams> _postpaidBillerRequest = BehaviorSubject();
  BehaviorSubject<Resource<GetPostpaidBillerListModel>> _postpaidBillerResponse = BehaviorSubject();

  ///search list
  PublishSubject<Resource<List<GetPostpaidBillerListModelData>?>> _searchPostpaidBillerResponse =
      PublishSubject();

  Stream<Resource<List<GetPostpaidBillerListModelData>?>> get searchPostpaidBillerStream =>
      _searchPostpaidBillerResponse.stream;

  Stream<Resource<GetPostpaidBillerListModel>> get postpaidBillerStream => _postpaidBillerResponse.stream;

  void getPostpaidBiller() {
    _postpaidBillerRequest.safeAdd(GetPostpaidBillerListUseCaseParams());
  }

  void postPaidBillerListener() {
    _postpaidBillerRequest.listen(
      (params) {
        RequestManager(params, createCall: () => getPostpaidBillerListUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _postpaidBillerResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showErrorState();
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            payPostPaidBillsDataList =
                event.data?.getPostpaidBillerListContent?.getPostpaidBillerListData ?? [];
            mList = payPostPaidBillsDataList;
            _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);

            postPaidRequestJsonListMethod();
          }
        });
      },
    );
  }

  /// ---------------- post paid bill enquiry -------------------------------- ///
  PublishSubject<PostPaidBillInquiryUseCaseParams> _postPaidBillEnquiryRequest = PublishSubject();

  BehaviorSubject<Resource<PostPaidBillInquiry>> _postPaidBillEnquiryResponse = BehaviorSubject();

  Stream<Resource<PostPaidBillInquiry>> get postPaidBillEnquiryStream => _postPaidBillEnquiryResponse.stream;

  int selectedIndex = -1;

  void postPaidBillInquiry(List<PostpaidBillInquiry> postpaidBillInquiry,
      {required bool isFromSelectedItem, required int index}) {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("post_paid_saved_bill_enquiry", {"post_paid_saved_bill_enquiry_call": true});
    _postPaidBillEnquiryRequest.safeAdd(PostPaidBillInquiryUseCaseParams(
        postpaidBillInquiries: postpaidBillInquiry, isFromSelectedItem: isFromSelectedItem, index: index));
  }

  List<PostPaidBillInquiryData> postPaidBillInquiryDataForOneItem = [];

  void postPaidBillInquiryListener() {
    _postPaidBillEnquiryRequest.listen(
      (params) {
        RequestManager(params, createCall: () => postPaidBillInquiryUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _postPaidBillEnquiryResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showErrorState();
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            if (arguments.paidBillsPayTypeOptionEnum != PostPaidBillsPayTypeOptionEnum.PAYALLBILLS) {
              postPaidBillInquiryDataForOneItem = event.data?.content?.postPaidBillInquiryData ?? [];
            }
            postPaidBillInquiryData?.addAll(event.data?.content?.postPaidBillInquiryData ?? []);
            postPaidBillInquiryData = postPaidBillInquiryData!.toSet().toList();
            if (payPostPaidBillsDataList.length > 0) {
              postpaidBillEnquiryOnSuccessMethod(postPaidBillInquiryData,
                  isFromSelectedItem: params.isFromSelectedItem, index: params.index, isFromApiCall: true);
            }
            if (params.isFromSelectedItem) {
              showErrorMessagePopUp(
                  index: params.index, data: event.data?.content?.postPaidBillInquiryData ?? []);
            }
          }
        });
      },
    );
  }

  showErrorMessagePopUp({required int index, required List<PostPaidBillInquiryData> data}) {
    var showError = data
            .where((element) => (element.billingNo ?? '').isEmpty || (element.serviceType ?? '').isEmpty)
            .length >
        0;

    if (showError) {
      showToastWithError(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.NETWORK, cause: Exception()));
    }
  }

  void postpaidBillEnquiryOnSuccessMethod(List<PostPaidBillInquiryData>? inquiryData,
      {required bool isFromSelectedItem, required int index, required bool isFromApiCall}) {
    selectedPostPaidBillsList = [];
    _postPaidBillEnquiryResponse.safeAdd(Resource.success(
        data:
            PostPaidBillInquiry(content: PostPaidBillInquiryListData(postPaidBillInquiryData: inquiryData))));

    for (int j = 0; j < payPostPaidBillsDataList.length; j++) {
      GetPostpaidBillerListModelData item = payPostPaidBillsDataList[j];
      var inquiryItem = inquiryData?.where(
          (element) => item.billingNo == element.billingNo && item.serviceType == element.serviceType);

      if (inquiryItem != null && (inquiryItem).length > 0) {
        var inquiryElement = inquiryItem.first;

        if (payPostPaidBillsDataList[j].isAmountUpdatedFromApi == false) {
          payPostPaidBillsDataList[j].actualdueAmountFromApi = inquiryElement.dueAmount;
          payPostPaidBillsDataList[j].isAmountUpdatedFromApi = true;
        }
        payPostPaidBillsDataList[j].fees = inquiryElement.feesAmt;
        payPostPaidBillsDataList[j].dueAmount = inquiryElement.dueAmount;
        payPostPaidBillsDataList[j].isPartial = inquiryElement.isPartial;
        payPostPaidBillsDataList[j].minValue = inquiryElement.minValue;
        payPostPaidBillsDataList[j].maxValue = inquiryElement.maxValue;
        payPostPaidBillsDataList[j].expDateStatus = inquiryElement.success ?? false;
        payPostPaidBillsDataList[j].expDateMessage = inquiryElement.message ?? "false";
        if (payPostPaidBillsDataList[j].expDateStatus == false) {
          payPostPaidBillsDataList[j].showErrorIfEverythingOkButCannotBePaid = true;
          payPostPaidBillsDataList[j].isChecked = false;
        }

        if (double.parse(payPostPaidBillsDataList[j].dueAmount ?? "0") > 0 &&
            double.parse(payPostPaidBillsDataList[j].fees ?? "0") > 0 &&
            double.parse(payPostPaidBillsDataList[j].dueAmount ?? "0") ==
                double.parse(payPostPaidBillsDataList[j].fees ?? "0")) {
          if (isFromSelectedItem &&
              payPostPaidBillsDataList[j].billingNo == payPostPaidBillsDataList[index].billingNo) {
            payPostPaidBillsDataList[j].isChecked = (payPostPaidBillsDataList[j].isChecked ?? false);
            payPostPaidBillsDataList[j].showErrorIfEverythingOkButCannotBePaid = true;
          } else {
            if (!isFromSelectedItem) {
              payPostPaidBillsDataList[j].isChecked = false;
              payPostPaidBillsDataList[j].showErrorIfEverythingOkButCannotBePaid = true;
            }
          }
        }

        if (payPostPaidBillsDataList[j].isPartial == true &&
            double.parse(payPostPaidBillsDataList[j].dueAmount ?? "0") <= 0.0 &&
            double.parse(payPostPaidBillsDataList[j].maxValue ?? "0") > 0.0) {
          if (isFromSelectedItem &&
              payPostPaidBillsDataList[j].billingNo == payPostPaidBillsDataList[index].billingNo) {
            payPostPaidBillsDataList[j].isChecked = (payPostPaidBillsDataList[j].isChecked ?? false);
            payPostPaidBillsDataList[j].showErrorIfEverythingOkButCannotBePaid = true;
          } else {
            if (!isFromSelectedItem) {
              payPostPaidBillsDataList[j].isChecked = false;
              payPostPaidBillsDataList[j].showErrorIfEverythingOkButCannotBePaid = true;
            }
          }
        }

        selectedPostPaidBillsList.add(item);
      } else {
        if (isFromSelectedItem &&
            payPostPaidBillsDataList[index].billingNo == payPostPaidBillsDataList[j].billingNo) {
          payPostPaidBillsDataList[j].noDataFoundForBill = true;
        }
      }
    }

    /// Single bill Validation
    if (arguments.paidBillsPayTypeOptionEnum != PostPaidBillsPayTypeOptionEnum.PAYALLBILLS) {
      if (isFromApiCall) {
        if (postPaidBillInquiryDataForOneItem.length == 1) {
          ///For case where status is false
          if (postPaidBillInquiryDataForOneItem[0].success == false) {
            if (postPaidBillInquiryDataForOneItem[0].message != null &&
                postPaidBillInquiryDataForOneItem[0].message.toString().isNotEmpty) {
              if (postPaidBillInquiryDataForOneItem[0].message == "err-379") {
                showToastWithError(AppError(
                    cause: Exception(),
                    error: ErrorInfo(message: ''),
                    type: ErrorType.EXPIRY_DATE_SAVED_BILL_CHECK_MESSAGE));
              } else if (postPaidBillInquiryDataForOneItem[0].message == "err-381") {
                showToastWithError(AppError(
                    cause: Exception(),
                    error: ErrorInfo(message: ''),
                    type: ErrorType.OPEN_DATE_ISSUE_MESSAGE));
              } else if (postPaidBillInquiryDataForOneItem[0].message == "err-383") {
                showToastWithError(AppError(
                    cause: Exception(),
                    error: ErrorInfo(message: ''),
                    type: ErrorType.CLOSE_DATE_SAVED_BILL_CHECK_MESSAGE));
              } else {
                if (double.parse(postPaidBillInquiryDataForOneItem[0].dueAmount ?? "0") <= 0.0) {
                  showToastWithError(
                      AppError(error: ErrorInfo(message: ''), type: ErrorType.NETWORK, cause: Exception()));
                }
              }
            }
          }

          ///For case where status is true
          if (postPaidBillInquiryDataForOneItem[0].success == true) {
            ///Case 1: No data returned from api
            if (postPaidBillInquiryDataForOneItem[0].billingNo == null ||
                postPaidBillInquiryDataForOneItem[0].billingNo!.isEmpty ||
                postPaidBillInquiryDataForOneItem[0].serviceType == null ||
                postPaidBillInquiryDataForOneItem[0].serviceType!.isEmpty) {
              if (postPaidBillInquiryDataForOneItem.length == 1) {
                if (double.parse(postPaidBillInquiryDataForOneItem[0].dueAmount ?? "0") <= 0.0) {
                  showToastWithError(
                      AppError(error: ErrorInfo(message: ''), type: ErrorType.NETWORK, cause: Exception()));
                }
              }
            }

            ///Case 2: due amount and fees is equal
            if (double.parse(postPaidBillInquiryDataForOneItem[0].dueAmount ?? "0") > 0 &&
                double.parse(postPaidBillInquiryDataForOneItem[0].feesAmt ?? "0") > 0 &&
                double.parse(postPaidBillInquiryDataForOneItem[0].dueAmount ?? "0") ==
                    double.parse(postPaidBillInquiryDataForOneItem[0].feesAmt ?? "0")) {
              if (postPaidBillInquiryDataForOneItem[0].isPartial == false) {
                showToastWithError(AppError(
                    cause: Exception(),
                    error: ErrorInfo(message: ''),
                    type: ErrorType.THERE_ARE_NO_DUE_BILLS));
              } else {
                showToastWithError(AppError(
                    cause: Exception(),
                    error: ErrorInfo(message: ''),
                    type: ErrorType.THERE_ARE_NO_DUE_BILLS_BUT_CAN_MAKE_PARTIAL_PAYMENTS));
              }
            }
          }

          ///Case 3: due amount is less than 0
          if (postPaidBillInquiryDataForOneItem[0].success == true &&
              double.parse(postPaidBillInquiryDataForOneItem[0].dueAmount ?? "0") <= 0.0) {
            if (postPaidBillInquiryDataForOneItem[0].isPartial == false) {
              showToastWithError(AppError(
                  cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.THERE_ARE_NO_DUE_BILLS));
            } else {
              showToastWithError(AppError(
                  cause: Exception(),
                  error: ErrorInfo(message: ''),
                  type: ErrorType.THERE_ARE_NO_DUE_BILLS_BUT_CAN_MAKE_PARTIAL_PAYMENTS));
            }
          }
        }
      }
    }

    _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);

    addAllBillAmt(payPostPaidBillsDataList);
  }

  /// ---------------- remove customer billing -------------------------------- ///

  PublishSubject<RemoveCustomerBillingUseCaseParams> _removeCustomerBillingRequest = PublishSubject();

  BehaviorSubject<Resource<bool>> _removeCustomerBillingResponse = BehaviorSubject();

  Stream<Resource<bool>> get removeCustomerBillingStream => _removeCustomerBillingResponse.stream;

  void removeCustomerBillingListener() {
    _removeCustomerBillingRequest.listen(
      (params) {
        RequestManager(params, createCall: () => removeCustomerBillingUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _removeCustomerBillingResponse.safeAdd(event);
        });
      },
    );
  }

  void removeCustomerBilling(String? billerCode, String? billingNo, String? serviceType) {
    _removeCustomerBillingRequest.safeAdd(
      RemoveCustomerBillingUseCaseParams(
          billerCode: billerCode, billingNo: billingNo, serviceType: serviceType),
    );
  }

  void searchPostPaidBillerList(String? searchText) {
    if (fList.isNotEmpty) {
      fList.clear();
    }
    List<GetPostpaidBillerListModelData>? getPostpaidBillerList = mList;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < getPostpaidBillerList.length; i++) {
        GetPostpaidBillerListModelData item = getPostpaidBillerList[i];

        /// nickname filter
        if (item.nickName != null && item.nickName!.isNotEmpty) {
          if (item.nickName!.toLowerCase().contains(searchText.toLowerCase())) {
            fList.add(item);
          }
        }

        /// billerName filter
        if (item.billerNameEN != null && item.billerNameEN!.isNotEmpty ||
            item.billerNameAR != null && item.billerNameAR!.isNotEmpty) {
          if (item.billerNameEN!.toLowerCase().contains(searchText.toLowerCase()) ||
              item.billerNameAR!.toLowerCase().contains(searchText.toLowerCase())) {
            fList.add(item);
          }
        }
      }
      fList = fList.toSet().toList();
      _itemSelectedSubject.safeAdd(fList);
      addAllBillAmt(fList);
    } else {
      _itemSelectedSubject.safeAdd(mList);
      addAllBillAmt(mList);
    }
  }

  @override
  void dispose() {
    _removeCustomerBillingRequest.close();
    _removeCustomerBillingResponse.close();
    _postPaidBillEnquiryRequest.close();
    _postPaidBillEnquiryResponse.close();
    _itemSelectedSubject.close();
    _postpaidBillerRequest.close();
    _postpaidBillerResponse.close();
    super.dispose();
  }
}
