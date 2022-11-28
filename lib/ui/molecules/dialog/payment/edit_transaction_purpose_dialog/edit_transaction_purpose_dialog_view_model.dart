import 'package:domain/constants/enum/transaction_type.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/usecase/payment/get_purpose_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EditTransactionPurposeDialogViewModel extends BasePageViewModel {
  GetPurposeUseCase _getPurposeUseCase;
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();
  final GlobalKey<AppTextFieldState> purposeKey = GlobalKey(debugLabel: "purpose");
  final GlobalKey<AppTextFieldState> purposeDetailKey = GlobalKey(debugLabel: "purposeDetail");

  PublishSubject<GetPurposeUseCaseParams> _getPurposeRequest = PublishSubject();

  PublishSubject<Resource<PurposeResponse>> _getPurposeResponse = PublishSubject();

  Stream<Resource<PurposeResponse>> get getPurposeResponseStream => _getPurposeResponse.stream;

  Purpose? purpose;

  PurposeDetail? purposeDetail;

  List<Purpose>? purposeList = [];

  List<PurposeDetail>? purposeDetailList = [];

  Beneficiary? beneficiary;

  TransactionType? type;

  List<dynamic>? values;

  EditTransactionPurposeDialogViewModel(this._getPurposeUseCase, this.values) {
    beneficiary = values![0];
    type = values![1];
    purposeController.text = values![2];
    purposeDetailController.text = values![3];
    _getPurposeRequest.listen((value) {
      RequestManager(value, createCall: () => _getPurposeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getPurposeResponse.safeAdd(event);
        if (event.status == Status.SUCCESS) {
          purposeList!.clear();
          purposeList!.addAll(event.data!.content!.transferPurposeResponse!.purposes!);
        } else if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
    getPurpose();
  }

  void getPurpose() {
    _getPurposeRequest.safeAdd(GetPurposeUseCaseParams(
        toAccount: beneficiary!.accountNo!,
        transferType: type == TransactionType.RTP ? "RTP" : "TransferI",
        type: beneficiary!.purposeType ?? "",
        detCustomerType: beneficiary!.detCustomerType ?? ""));
  }

  void updatePurposeDetail(PurposeDetail value) {
    purposeDetailController.text = value.labelEn!;
    purposeDetail = value;
  }

  void updatePurposeDetailList(List<PurposeDetail> value) {
    purposeDetailList!.clear();
    purposeDetailController.clear();
    purposeDetailList!.addAll(value);
  }

  void updatePurpose(Purpose value) {
    purpose = value;
    purposeController.text = value.labelEn!;
  }
}
