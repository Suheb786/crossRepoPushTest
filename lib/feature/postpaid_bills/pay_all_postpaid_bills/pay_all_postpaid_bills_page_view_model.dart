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

  void selectedItem(int index) {
    if (payPostPaidBillsDataList.isNotEmpty) {
      if (payPostPaidBillsDataList[index].isChecked == true) {
        payPostPaidBillsDataList[index].isChecked = false;
        totalBillAmt =
            totalBillAmt - double.parse(payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0.0");
        // selectedPostPaidBillsList.removeWhere((element) =>
        //     element.billingNo == payPostPaidBillsDataList[index].billingNo &&
        //     element.serviceType == payPostPaidBillsDataList[index].serviceType);

        // postPaidRequestListJson.removeWhere((element) =>
        //     element.billingNumber == payPostPaidBillsDataList[index].billingNo &&
        //     element.serviceType == payPostPaidBillsDataList[index].serviceType &&
        //     (double.parse(payPostPaidBillsDataList[index].dueAmount ?? "0") <= 0.0));
        // selectedPostPaidBillsList = selectedPostPaidBillsList.toSet().toList();
        postPaidRequestListJson = postPaidRequestListJson.toSet().toList();
        _totalBillAmtDueSubject.safeAdd(totalBillAmt);
        _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
        debugPrint('multiple selected $totalBillAmt');
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
        debugPrint("payPOstPaidBillDataList.billingNo:${payPostPaidBillsDataList[index].billingNo}");
        selectedPostPaidBillsList.add(payPostPaidBillsDataList[index]);
        selectedPostPaidBillsList = selectedPostPaidBillsList.toSet().toList();
        postPaidRequestListJson = postPaidRequestListJson.toSet().toList();

        totalBillAmt =
            totalBillAmt + double.parse(payPostPaidBillsDataList[index].actualdueAmountFromApi ?? "0.0");
        debugPrint("selectedIndex123:$index");
        selectedIndex = index;
        _totalBillAmtDueSubject.safeAdd(totalBillAmt);
        _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
        if (payPostPaidBillsDataList[index].dueAmount != null &&
                payPostPaidBillsDataList[index].dueAmount!.isNotEmpty ||
            payPostPaidBillsDataList[index].dueAmount != null &&
                payPostPaidBillsDataList[index].dueAmount == "0") {
          if (postPaidBillInquiryData == null || postPaidBillInquiryData!.isEmpty) {
            postPaidBillInquiry(postPaidRequestListJson);
          } else {
            if (payPostPaidBillsDataList[index].isAmountUpdatedFromApi == false) {
              postPaidBillInquiry(postPaidRequestListJson);
            } else {
              postpaidBillEnquiryOnSuccessMethod(postPaidBillInquiryData, isFromSelectedItem: true);
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
      postPaidBillInquiry(postPaidRequestListJson);
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

////search list
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

            // _searchPostpaidBillerResponse.safeAdd(
            //     Resource.success(data: event.data?.getPostpaidBillerListContent?.getPostpaidBillerListData));
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

  void postPaidBillInquiry(List<PostpaidBillInquiry> postpaidBillInquiry) {
    ///LOG EVENT TO FIREBASE
    FireBaseLogUtil.fireBaseLog("post_paid_saved_bill_enquiry", {"post_paid_saved_bill_enquiry_call": true});
    _postPaidBillEnquiryRequest
        .safeAdd(PostPaidBillInquiryUseCaseParams(postpaidBillInquiries: postpaidBillInquiry));
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
              postpaidBillEnquiryOnSuccessMethod(postPaidBillInquiryData);
            }
          }
        });
      },
    );
  }

  void postpaidBillEnquiryOnSuccessMethod(List<PostPaidBillInquiryData>? inquiryData,
      {bool? isFromSelectedItem}) {
    selectedPostPaidBillsList = [];
    _postPaidBillEnquiryResponse.safeAdd(Resource.success(
        data:
            PostPaidBillInquiry(content: PostPaidBillInquiryListData(postPaidBillInquiryData: inquiryData))));
    var postPaidBillInquiryDataLength = inquiryData?.length ?? 0;
    for (int i = 0; i < postPaidBillInquiryDataLength; i++) {
      PostPaidBillInquiryData inquiryElement = inquiryData![i];
      for (int j = 0; j < payPostPaidBillsDataList.length; j++) {
        GetPostpaidBillerListModelData item = payPostPaidBillsDataList[j];
        if (item.billingNo == inquiryElement.billingNo && item.serviceType == inquiryElement.serviceType) {
          if (payPostPaidBillsDataList[j].isAmountUpdatedFromApi == false) {
            payPostPaidBillsDataList[j].actualdueAmountFromApi = inquiryElement.dueAmount;
          }
          payPostPaidBillsDataList[j].fees = inquiryElement.feesAmt;
          payPostPaidBillsDataList[j].isAmountUpdatedFromApi = true;
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
          if (double.parse(payPostPaidBillsDataList[j].dueAmount ?? "0") <= 0.0) {
            payPostPaidBillsDataList[j].showErrorIfEverythingOkButCannotBePaid = true;
            payPostPaidBillsDataList[j].isChecked = false;
            payPostPaidBillsDataList[j].expDateStatus = true;
          }
          if (isFromSelectedItem == true) {
            if (payPostPaidBillsDataList[selectedIndex].isPartial == true &&
                double.parse(payPostPaidBillsDataList[selectedIndex].dueAmount ?? "0") <= 0.0 &&
                double.parse(payPostPaidBillsDataList[selectedIndex].maxValue ?? "0") <= 0.0) {
              payPostPaidBillsDataList[selectedIndex].showErrorIfEverythingOkButCannotBePaid = true;
              payPostPaidBillsDataList[selectedIndex].isChecked = false;
              //   payPostPaidBillsDataList[j].expDateStatus = true;
            } else {
              payPostPaidBillsDataList[selectedIndex].showErrorIfEverythingOkButCannotBePaid = false;
              payPostPaidBillsDataList[selectedIndex].isChecked = true;
              //  payPostPaidBillsDataList[j].expDateStatus = false;
            }
          }

          selectedPostPaidBillsList.add(item);
        }
      }

      if (arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS) {
        if (postPaidBillInquiryData != null && postPaidBillInquiryData!.isNotEmpty) {
          if (inquiryElement.billingNo == null ||
              inquiryElement.billingNo!.isEmpty ||
              inquiryElement.serviceType == null ||
              inquiryElement.serviceType!.isEmpty) {
            for (var item in payPostPaidBillsDataList) {
              if (item.isAmountUpdatedFromApi == false) {
                item.expDateStatus = false;
                item.expDateMessage = postPaidBillInquiryData![0].message ?? "false";
                item.isAmountUpdatedFromApi = true;
              }
            }
          }
        }
      }
    }
    if (arguments.paidBillsPayTypeOptionEnum != PostPaidBillsPayTypeOptionEnum.PAYALLBILLS) {
      if (postPaidBillInquiryDataForOneItem.length == 1) {
        ///postPaidBillInquiryData?[0].success == false
        if (postPaidBillInquiryDataForOneItem[0].success == false) {
          if (postPaidBillInquiryDataForOneItem[0].message != null &&
              postPaidBillInquiryDataForOneItem[0].message!.toString().isNotEmpty) {
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

        ///postPaidBillInquiryData?[0].success == true
        if (postPaidBillInquiryDataForOneItem[0].success == true) {
          if (postPaidBillInquiryDataForOneItem[0].billingNo == null ||
              postPaidBillInquiryDataForOneItem[0].billingNo!.isEmpty ||
              postPaidBillInquiryDataForOneItem[0].serviceType == null ||
              postPaidBillInquiryDataForOneItem[0].serviceType!.isEmpty) {
            if (selectedIndex > -1 &&
                payPostPaidBillsDataList[selectedIndex].isAmountUpdatedFromApi == false) {
              payPostPaidBillsDataList[selectedIndex].isChecked = false;
              payPostPaidBillsDataList[selectedIndex].expDateStatus = false;
              payPostPaidBillsDataList[selectedIndex].expDateMessage =
                  postPaidBillInquiryDataForOneItem[0].message ?? "false";
              payPostPaidBillsDataList[selectedIndex].isAmountUpdatedFromApi = true;
              if (postPaidBillInquiryDataForOneItem.length == 1) {
                if (double.parse(postPaidBillInquiryDataForOneItem[0].dueAmount ?? "0") <= 0.0) {
                  showToastWithError(
                      AppError(error: ErrorInfo(message: ''), type: ErrorType.NETWORK, cause: Exception()));
                }
              }
            }
          }
        }

        if (payPostPaidBillsDataList[selectedIndex].showErrorIfEverythingOkButCannotBePaid) {
          payPostPaidBillsDataList[selectedIndex].showErrorIfEverythingOkButCannotBePaid = false;
          if (double.parse(payPostPaidBillsDataList[selectedIndex].dueAmount ?? "0") <= 0.0) {
            if (payPostPaidBillsDataList[selectedIndex].isPartial == false) {
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

    // mList = payPostPaidBillsDataList;
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
