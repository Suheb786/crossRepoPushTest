import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity_response.dart';
import 'package:data/network/api_service.dart';
import 'package:domain/usecase/bill_payments/post_paid_bills/get_postpaid_biller_list_usecase.dart';
import 'package:retrofit/retrofit.dart';
import '../bill_payment_data_source.dart';

class BillPaymentRemoteDSImpl extends BillPaymentRemoteDS {
  final ApiService _apiService;

  BillPaymentRemoteDSImpl(this._apiService);

  @override
  Future<HttpResponse<GetPostpaidBillerListEntityResponse>>
      getPostpaidBillerList(
          {required GetPostpaidBillerListUseCaseParams params}) {
    return _apiService.getPostpaidBillerListData();
  }
}
