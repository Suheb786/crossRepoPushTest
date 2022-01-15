import 'package:data/entity/remote/kyc/check_kyc_status_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class KYCRemoteDS {
  Future<HttpResponse<CheckKycStatusResponseEntity>> checkKYCStatus();
}

abstract class KYCLocalDS {}
