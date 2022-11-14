import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity_response.dart';
import 'package:retrofit/dio.dart';
import 'package:domain/usecase/bill_payments/post_paid_bills/get_postpaid_biller_list_usecase.dart';

abstract class BillPaymentRemoteDS {
  Future<HttpResponse<GetPostpaidBillerListEntityResponse>>
      getPostpaidBillerList(
          {required GetPostpaidBillerListUseCaseParams params});
}
