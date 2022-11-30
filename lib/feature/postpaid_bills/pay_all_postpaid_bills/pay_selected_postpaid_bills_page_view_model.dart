import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model_data.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/post_paid_bill_enquiry_request.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:domain/usecase/bill_payment/get_postpaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_customer_billing_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pall_all_postpaid_bills_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
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
        totalBillAmt = totalBillAmt - double.parse(payPostPaidBillsDataList[index].dueAmount ?? "0.0");
        selectedPostPaidBillsList
            .removeWhere((element) => element.billingNo == payPostPaidBillsDataList[index].billingNo);
        postPaidRequestListJson
            .removeWhere((element) => element.billingNumber == payPostPaidBillsDataList[index].billingNo);
        selectedPostPaidBillsList = selectedPostPaidBillsList.toSet().toList();
        postPaidRequestListJson = postPaidRequestListJson.toSet().toList();
        _totalBillAmtDueSubject.safeAdd(totalBillAmt);
        _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
        debugPrint('multiple selected $totalBillAmt');
      } else {
        payPostPaidBillsDataList[index].isChecked = true;

        postPaidRequestListJson.add(PostpaidBillInquiry(
          billerCode: payPostPaidBillsDataList[index].billerCode,
          serviceType: payPostPaidBillsDataList[index].serviceType,
          billingNumber: payPostPaidBillsDataList[index].billingNo,
        ));
        debugPrint(
            "payPOstPaidBillDataList.billingNo:${payPostPaidBillsDataList[index].billingNo}");
        selectedPostPaidBillsList.add(payPostPaidBillsDataList[index]);
        selectedPostPaidBillsList = selectedPostPaidBillsList.toSet().toList();
        postPaidRequestListJson = postPaidRequestListJson.toSet().toList();
        totalBillAmt = totalBillAmt +
            double.parse(payPostPaidBillsDataList[index].dueAmount ?? "0.0");
        debugPrint("selectedIndex123:$index");
        selectedIndex = index;
        _totalBillAmtDueSubject.safeAdd(totalBillAmt);
        _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
        if (payPostPaidBillsDataList[index].dueAmount != null &&
                payPostPaidBillsDataList[index].dueAmount!.isNotEmpty ||
            payPostPaidBillsDataList[index].dueAmount != null &&
                payPostPaidBillsDataList[index].dueAmount == "0") {
          postPaidBillInquiry([
            PostpaidBillInquiry(
              billerCode: payPostPaidBillsDataList[index].billerCode,
              serviceType: payPostPaidBillsDataList[index].serviceType,
              billingNumber: payPostPaidBillsDataList[index].billingNo,
            )
          ]);
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
        postPaidRequestListJson.add(PostpaidBillInquiry(
          billerCode: item.billerCode,
          serviceType: item.serviceType,
          billingNumber: item.billingNo,
        ));
        selectedPostPaidBillsList.add(item);
      }
      selectedPostPaidBillsList = selectedPostPaidBillsList.toSet().toList();
      postPaidRequestListJson = postPaidRequestListJson.toSet().toList();
      _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
      postPaidBillInquiry(postPaidRequestListJson);
    }
  }

  void addAllBillAmt() {
    totalBillAmt = 0.0;
    payPostPaidBillsDataList.forEach((element) {
      print("asjdtotalBillAmtsa:${element.dueAmount}");

      if (element.isChecked == true) {
        totalBillAmt = double.parse(element.dueAmount ?? "0.0") + totalBillAmt;
      }
    });
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
  }

  /*void removeItem(int index) {
    // _totalBillAmtDueSubject.safeAdd(totalBillAmt);
    totalBillAmt = totalBillAmt -
        double.parse(payPostPaidBillsDataList[index].dueAmount ?? "0.0");
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
    payPostPaidBillsDataList.removeAt(index);
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
    _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
  }*/

  /// ---------------- Call Api GetPostpaidBillerList -------------------------------- ///
  BehaviorSubject<GetPostpaidBillerListUseCaseParams> _postpaidBillerRequest = BehaviorSubject();
  PublishSubject<Resource<GetPostpaidBillerListModel>> _postpaidBillerResponse = PublishSubject();

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

  void postPaidBillInquiry(List<PostpaidBillInquiry> postpaidBillInquiry) {
    _postPaidBillEnquiryRequest
        .safeAdd(PostPaidBillInquiryUseCaseParams(postpaidBillInquiries: postpaidBillInquiry));
  }

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
            if (selectedIndex < 0) {
              postPaidBillInquiryData = event.data?.content?.postPaidBillInquiryData;
              totalBillAmt = 0.0;

              for (int i = 0; i < postPaidBillInquiryData!.length; i++) {
                totalBillAmt = totalBillAmt +
                    double.parse(
                        postPaidBillInquiryData![i].dueAmount.toString());
                debugPrint("totalBillAmt:${totalBillAmt}");
                PostPaidBillInquiryData inquiryElement =
                    postPaidBillInquiryData![i];
                for (int j = 0; j < payPostPaidBillsDataList.length; j++) {
                  GetPostpaidBillerListModelData item =
                      payPostPaidBillsDataList[j];
                  debugPrint("item.billingNo: ${item.billingNo}");
                  if (item.billingNo == "55" ||
                      item.billingNo == "111" /*inquiryElement.billingNo*/)
                  // if (item.billingNo == inquiryElement.billingNo)
                  {
                    payPostPaidBillsDataList[j].dueAmount =
                        inquiryElement.dueAmount;
                  }
                }
              }
            } else {
              postPaidBillInquiryData = event.data?.content?.postPaidBillInquiryData;

              payPostPaidBillsDataList[selectedIndex].dueAmount =
                  event.data?.content?.postPaidBillInquiryData?[0].dueAmount;
            }

            addAllBillAmt();
            _itemSelectedSubject.safeAdd(payPostPaidBillsDataList);
          }
        });
      },
    );
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
          if (event.status == Status.ERROR) {
            showErrorState();
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            if (event.data == true) {
              showSuccessToast('BILL UPDATED\nYour bill has been removed.');
              Future.delayed(Duration(milliseconds: 200)).then((value) => getPostpaidBiller());
            }
          }
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
