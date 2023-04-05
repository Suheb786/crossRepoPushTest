import 'package:domain/model/payment/get_rejection_reason/reject_reasons_response.dart';

class GetRejectionReasonResponseModel {
  final List<ReturnReasonsPayment> rejectReasons;

  GetRejectionReasonResponseModel({required this.rejectReasons});
}
