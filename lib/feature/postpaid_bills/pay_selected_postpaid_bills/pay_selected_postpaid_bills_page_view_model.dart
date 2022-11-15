import 'package:collection/collection.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaySelectedBillsPostPaidBillsPageViewModel extends BasePageViewModel {
  final PaySelectedBillsPostPaidBillsPageArguments arguments;
  List<double> totalAmt = [];

  final ScrollController payingBillController = ScrollController();
  final TextEditingController savingAccountController = TextEditingController();

  PublishSubject<double> _totalBillAmtDueSubject = PublishSubject();

  Stream<double> get totalBillAmtDueStream => _totalBillAmtDueSubject.stream;

  final PostPaidBillInquiryUseCase postPaidBillInquiryUseCase;


  PaySelectedBillsPostPaidBillsPageViewModel(this.postPaidBillInquiryUseCase,this.arguments){
    postPaidBillInquiryListener();


  }

  /// ---------------- post paid bill enquiry -------------------------------- ///
  PublishSubject<PostPaidBillInquiryUseCaseParams> _postPaidBillEnquiryRequest =
  PublishSubject();

  BehaviorSubject<Resource<PostPaidBillInquiry>> _postPaidBillEnquiryResponse =
  BehaviorSubject();

  Stream<Resource<PostPaidBillInquiry>> get postPaidBillEnquiryStream =>
      _postPaidBillEnquiryResponse.stream;

  void postPaidBillInquiry() {
    _postPaidBillEnquiryRequest.safeAdd(PostPaidBillInquiryUseCaseParams(
        postpaidBillInquiries: arguments.postPaidRequestListJson));
  }


  void postPaidBillInquiryListener(){
    _postPaidBillEnquiryRequest.listen(
          (params) {
        RequestManager(params,
            createCall: () =>
                postPaidBillInquiryUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _postPaidBillEnquiryResponse.safeAdd(event);
          if (event.status == Status.ERROR) {}
        });
      },
    );
  }


  void newAmtEnter(int index, String value) {
    totalAmt[index] = double.parse(value);
    arguments.noOfSelectedBills[index].dueAmount = value;

    _totalBillAmtDueSubject.safeAdd(totalAmt.sum);
  }

  @override
  void dispose() {
    _totalBillAmtDueSubject.close();
    super.dispose();
  }
}
