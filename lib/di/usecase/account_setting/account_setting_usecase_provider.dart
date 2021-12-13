import 'package:domain/usecase/account_setting/change_email_address/add_new_email_address_usecase.dart';
import 'package:domain/usecase/account_setting/change_email_address/validate_otp_for_new_email_address_usecase.dart';
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
