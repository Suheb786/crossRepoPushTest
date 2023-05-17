import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/manage_contacts/add_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/add_contact_OTP_usecase.dart';
import 'package:domain/usecase/manage_contacts/add_contact_usecase.dart';
import 'package:domain/usecase/manage_contacts/contact_detail_usecase.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/edit_contact_IBAN_otp_usecase.dart';
import 'package:domain/usecase/manage_contacts/edit_contact_IBAN_usecase.dart';
import 'package:domain/usecase/manage_contacts/get_contacts_usecase.dart';
import 'package:domain/usecase/manage_contacts/list_of_contacts_usecase.dart';
import 'package:domain/usecase/manage_contacts/manage_contact_otp_validation_usecase.dart';
import 'package:domain/usecase/manage_contacts/search_contact_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_favorite_usecase.dart';
import 'package:domain/usecase/manage_contacts/upload_beneficiary_profile_image_usecase.dart';
import 'package:domain/usecase/manage_contacts/verify_beneficiary_otp_usecase.dart';
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

///[VerifyBeneficiaryOtpUseCase] provider
final verifyBeneficiaryOtpUseCaseProvider = Provider.autoDispose<VerifyBeneficiaryOtpUseCase>(
  (ref) => VerifyBeneficiaryOtpUseCase(ref.read(manageContactRepositoryProvider)),
);

///[addContactIBANuseCase] provider
final addContactIBANuseCaseProvider = Provider.autoDispose<AddContactIBANuseCase>(
  (ref) => AddContactIBANuseCase(),
);

///[addContactIbanOTPuseCase] provider
final addContactIbanOTPuseCaseProvider = Provider.autoDispose<AddContactIbanOTPuseCase>(
  (ref) => AddContactIbanOTPuseCase(),
);

///[editContactIBANuseCase] provider
final editContactIBANformuseCaseProvider = Provider.autoDispose<EditContactIBANuseCase>(
  (ref) => EditContactIBANuseCase(),
);

///[editContactIbanOTPuseCase] provider
final editContactIbanOTPuseCaseProvider = Provider.autoDispose<EditContactOTPuseCase>(
  (ref) => EditContactOTPuseCase(),
);

///[DeleteContactOtpValidationUsecase] provider
final manageContactOtpValidationUseCaseProvider = Provider.autoDispose<DeleteContactOtpValidationUsecase>(
  (ref) => DeleteContactOtpValidationUsecase(),
);

///[ContactDetailUseCase] provider
final contactDetailUseCaseProvider = Provider.autoDispose<ContactDetailUseCase>(
  (ref) => ContactDetailUseCase(ref.read(manageContactRepositoryProvider)),
);

///[ListOfContactUseCase] provider
final listOfContactUseCaseProvider = Provider.autoDispose<ListOfContactUseCase>(
  (ref) => ListOfContactUseCase(ref.read(manageContactRepositoryProvider)),
);

///[SearchContactUseCase] provider
final searchContactUseCaseProvider = Provider.autoDispose<SearchContactUseCase>(
  (ref) => SearchContactUseCase(ref.read(manageContactRepositoryProvider)),
);

///[UpdateFavoriteUseCase] provider
final updateFavoriteUseCaseProvider = Provider.autoDispose<UpdateFavoriteUseCase>(
  (ref) => UpdateFavoriteUseCase(ref.read(manageContactRepositoryProvider)),
);
