import 'package:data/entity/remote/accountsettings/get_customer_doc_id_response_entity.dart';
import 'package:data/entity/remote/accountsettings/get_customer_document_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_changed_success_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_details_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class AccountSettingsRemoteDs {
  Future<HttpResponse<ProfileDetailsResponseEntity>> getAccountDetails();

  Future<HttpResponse<ResponseEntity>> updateProfileImage({required String filePath});

  Future<HttpResponse<ResponseEntity>> changeEmail({required String email});

  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeEmail({required String otp});

  Future<HttpResponse<ResponseEntity>> changeMobile({required String mobile, required String mobileCode});

  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeMobile(
      {required String otp, required String mobileNo, required String mobileCode});

  Future<HttpResponse<ResponseEntity>> changePassword(
      {required String oldPassword, required String newPassword, required String confirmNewPassword});

  Future<HttpResponse<ResponseEntity>> deleteProfileImage();

  Future<HttpResponse<GetCustomerDocIdResponseEntity>> getCustomerDocId();

  Future<HttpResponse<GetCustomerDocumentResponseEntity>> getCustomerDocument({String docId});
}
