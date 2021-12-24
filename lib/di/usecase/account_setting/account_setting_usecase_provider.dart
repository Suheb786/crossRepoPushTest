import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/account_setting/change_email_address/add_new_email_address_usecase.dart';
import 'package:domain/usecase/account_setting/change_email_address/validate_otp_for_new_email_address_usecase.dart';
import 'package:domain/usecase/account_setting/change_mobile_number/add_new_mobile_number_usecase.dart';
import 'package:domain/usecase/account_setting/change_mobile_number/validate_otp_for_new_mobile_number_usecase.dart';
import 'package:domain/usecase/account_setting/change_password/enter_new_password_usecase.dart';
import 'package:domain/usecase/account_setting/get_profile_info/get_profile_info_usecase.dart';
import 'package:domain/usecase/account_setting/my_documents/my_documents_usecase.dart';
import 'package:domain/usecase/account_setting/upload_profile_image/upload_profile_image_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[AddNewEmailAddressUseCase] provider
final addNewEmailAddressUseCaseProvider =
    Provider.autoDispose<AddNewEmailAddressUseCase>(
  (ref) =>
      AddNewEmailAddressUseCase(ref.read(accountSettingRepositoryProvider)),
);

///[ValidateOtpForNewEmailAddressUseCase] provider
final validateOtpNewEmailAddressUseCaseProvider =
    Provider.autoDispose<ValidateOtpForNewEmailAddressUseCase>(
  (ref) => ValidateOtpForNewEmailAddressUseCase(
      ref.read(accountSettingRepositoryProvider), ref.read(userRepoProvider)),
);

///[AddNewMobileNumberUseCase] provider
final addNewNumberUseCaseProvider =
    Provider.autoDispose<AddNewMobileNumberUseCase>(
  (ref) =>
      AddNewMobileNumberUseCase(ref.read(accountSettingRepositoryProvider)),
);

///[ValidateOtpForNewMobileNumberUseCase] provider
final validateOtpNewMobileNumberUseCaseProvider =
    Provider.autoDispose<ValidateOtpForNewMobileNumberUseCase>(
  (ref) => ValidateOtpForNewMobileNumberUseCase(
      ref.read(accountSettingRepositoryProvider), ref.read(userRepoProvider)),
);

///[EnterNewPasswordUseCase] provider
final enterNewPasswordUseCaseProvider =
    Provider.autoDispose<EnterNewPasswordUseCase>(
  (ref) => EnterNewPasswordUseCase(ref.read(accountSettingRepositoryProvider)),
);

///[MyDocumentsUseCase] provider
final myDocumentUseCaseProvider = Provider.autoDispose<MyDocumentsUseCase>(
  (ref) => MyDocumentsUseCase(),
);

///[GetProfileInfoUseCase] provider
final getProfileInfoUseCaseProvider =
    Provider.autoDispose<GetProfileInfoUseCase>(
  (ref) => GetProfileInfoUseCase(ref.read(accountSettingRepositoryProvider)),
);

///[UploadProfileImageUseCase] provider
final uploadProfileImageUseCaseProvider =
    Provider.autoDispose<UploadProfileImageUseCase>(
  (ref) =>
      UploadProfileImageUseCase(ref.read(accountSettingRepositoryProvider)),
);
