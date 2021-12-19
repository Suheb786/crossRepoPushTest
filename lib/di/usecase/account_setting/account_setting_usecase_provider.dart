import 'package:domain/usecase/account_setting/change_email_address/add_new_email_address_usecase.dart';
import 'package:domain/usecase/account_setting/change_email_address/validate_otp_for_new_email_address_usecase.dart';
import 'package:domain/usecase/account_setting/change_mobile_number/add_new_mobile_number_usecase.dart';
import 'package:domain/usecase/account_setting/change_mobile_number/validate_otp_for_new_mobile_number_usecase.dart';
import 'package:domain/usecase/account_setting/change_password/enter_new_password_usecase.dart';
import 'package:domain/usecase/account_setting/my_documents/my_documents_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[AddNewEmailAddressUseCase] provider
final addNewEmailAddressUseCaseProvider =
Provider.autoDispose<AddNewEmailAddressUseCase>(
      (ref) => AddNewEmailAddressUseCase(),
);

///[ValidateOtpForNewEmailAddressUseCase] provider
final validateOtpNewEmailAddressUseCaseProvider =
Provider.autoDispose<ValidateOtpForNewEmailAddressUseCase>(
      (ref) => ValidateOtpForNewEmailAddressUseCase(),
);

///[AddNewMobileNumberUseCase] provider
final addNewNumberUseCaseProvider =
Provider.autoDispose<AddNewMobileNumberUseCase>(
      (ref) => AddNewMobileNumberUseCase(),
);

///[ValidateOtpForNewMobileNumberUseCase] provider
final validateOtpNewMobileNumberUseCaseProvider =
Provider.autoDispose<ValidateOtpForNewMobileNumberUseCase>(
      (ref) => ValidateOtpForNewMobileNumberUseCase(),
);

///[EnterNewPasswordUseCase] provider
final enterNewPasswordUseCaseProvider =
Provider.autoDispose<EnterNewPasswordUseCase>(
      (ref) => EnterNewPasswordUseCase(),
);

///[MyDocumentsUseCase] provider
final myDocumentUseCaseProvider = Provider.autoDispose<MyDocumentsUseCase>(
      (ref) => MyDocumentsUseCase(),
);
