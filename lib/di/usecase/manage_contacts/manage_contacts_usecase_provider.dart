import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/manage_contacts/add_beneficiary_OTP_usecase.dart';
import 'package:domain/usecase/manage_contacts/add_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/beneficiary_contacts_usecase.dart';
import 'package:domain/usecase/manage_contacts/beneficiary_mark_favorite_usecase.dart';
import 'package:domain/usecase/manage_contacts/contact_detail_usecase.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/get_contacts_usecase.dart';
import 'package:domain/usecase/manage_contacts/manage_contact_otp_validation_usecase.dart';
import 'package:domain/usecase/manage_contacts/remove_benificiary_profile_usecase.dart';
import 'package:domain/usecase/manage_contacts/resend_OTP_add_beneficiaryusecase.dart';
import 'package:domain/usecase/manage_contacts/search_contact_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/upload_beneficiary_profile_image_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[AddBeneficiaryUseCase] provider
final checkKycStatusUseCaseProvider = Provider.autoDispose<AddBeneficiaryUseCase>(
  (ref) => AddBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[DeleteBeneficiaryUseCase] provider
final deleteBeneficiaryUseCaseProvider = Provider.autoDispose<DeleteBeneficiaryUseCase>(
  (ref) => DeleteBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[GetContactsUseCase] provider
final getContactsUseCaseProvider = Provider.autoDispose<GetContactsUseCase>(
  (ref) => GetContactsUseCase(),
);

///[UpdateBeneficiaryUseCase] provider
final updateBeneficiaryUseCaseProvider = Provider.autoDispose<UpdateBeneficiaryUseCase>(
  (ref) => UpdateBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[UploadBeneficiaryProfileImageUseCase] provider
final uploadBeneficiaryProfileImageUseCaseProvider =
    Provider.autoDispose<UploadBeneficiaryProfileImageUseCase>(
  (ref) => UploadBeneficiaryProfileImageUseCase(ref.read(manageContactRepositoryProvider)),
);

///[RemoveBeneficiaryProfileImageUseCase] provider
final removeBeneficiaryProfileImageUseCaseProvider =
    Provider.autoDispose<RemoveBeneficiaryProfileImageUseCase>(
  (ref) => RemoveBeneficiaryProfileImageUseCase(ref.read(manageContactRepositoryProvider)),
);

///[addContactIBANuseCase] provider
final addBeneficiaryUseCaseProvider = Provider.autoDispose<AddBeneficiaryUseCase>(
  (ref) => AddBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[resendOTPAddBeneficiary] provider
final resendOTPAddBeneficiaryUseCaseProvider = Provider.autoDispose<ResendOTPAddBeneficiaryUseCase>(
  (ref) => ResendOTPAddBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[addContactIbanOTPuseCase] provider
final addBeneficiaryOTPuseCaseProvider = Provider.autoDispose<AddBeneficiaryOTPUseCase>(
  (ref) => AddBeneficiaryOTPUseCase(ref.read(manageContactRepositoryProvider)),
);

///[DeleteContactOtpValidationUsecase] provider
final manageContactOtpValidationUseCaseProvider = Provider.autoDispose<DeleteContactOtpValidationUsecase>(
  (ref) => DeleteContactOtpValidationUsecase(),
);

///[ContactDetailUseCase] provider
final contactDetailUseCaseProvider = Provider.autoDispose<ContactDetailUseCase>(
  (ref) => ContactDetailUseCase(ref.read(manageContactRepositoryProvider)),
);

///[BeneficiaryContactUseCaseProvider] provider
final beneficiaryContactUseCaseProvider = Provider.autoDispose<BeneficiaryContactUseCase>(
  (ref) => BeneficiaryContactUseCase(ref.read(manageContactRepositoryProvider)),
);

///[SearchContactUseCase] provider
final searchContactUseCaseProvider = Provider.autoDispose<SearchContactUseCase>(
  (ref) => SearchContactUseCase(ref.read(manageContactRepositoryProvider)),
);

///[BeneficiaryMarkFavoriteUseCase] provider
final beneficiaryMarkFavoriteUseCase = Provider.autoDispose<BeneficiaryMarkFavoriteUseCase>(
  (ref) => BeneficiaryMarkFavoriteUseCase(ref.read(manageContactRepositoryProvider)),
);
