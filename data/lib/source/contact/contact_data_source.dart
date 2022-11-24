import 'package:data/entity/remote/contact/get_beneficiary_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class ContactRemoteDS {
  Future<HttpResponse<GetBeneficiaryResponseEntity>> getBeneficiaries();

  Future<HttpResponse<ResponseEntity>> addBeneficiary(
      {String nickName,
      String fullName,
      String accountNumber,
      String iBan,
      String bankName,
      String purpose,
      String purposeDetails,
      String imageFilePath});

  Future<HttpResponse<ResponseEntity>> updateBeneficiary(
      {String beneficiaryId, String nickName, String purpose, String purposeDetails});

  Future<HttpResponse<ResponseEntity>> deleteBeneficiary({String beneficiaryId});

  Future<HttpResponse<ResponseEntity>> verifyBeneficiaryOtp({
    String type,
    String otpCode,
  });

  Future<HttpResponse<ResponseEntity>> uploadBeneficiaryImage({String filePath, String beneficiaryId});
}
