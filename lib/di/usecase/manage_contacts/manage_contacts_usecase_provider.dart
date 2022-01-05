import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/manage_contacts/add_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/get_contacts_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/upload_beneficiary_profile_image_usecase.dart';
import 'package:domain/usecase/manage_contacts/verify_beneficiary_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[AddBeneficiaryUseCase] provider
final checkKycStatusUseCaseProvider =
    Provider.autoDispose<AddBeneficiaryUseCase>(
  (ref) => AddBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[DeleteBeneficiaryUseCase] provider
final deleteBeneficiaryUseCaseProvider =
    Provider.autoDispose<DeleteBeneficiaryUseCase>(
  (ref) => DeleteBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[GetContactsUseCase] provider
final getContactsUseCaseProvider = Provider.autoDispose<GetContactsUseCase>(
  (ref) => GetContactsUseCase(ref.read(manageContactRepositoryProvider)),
);

///[UpdateBeneficiaryUseCase] provider
final updateBeneficiaryUseCaseProvider =
    Provider.autoDispose<UpdateBeneficiaryUseCase>(
  (ref) => UpdateBeneficiaryUseCase(ref.read(manageContactRepositoryProvider)),
);

///[UploadBeneficiaryProfileImageUseCase] provider
final uploadBeneficiaryProfileImageUseCaseProvider =
    Provider.autoDispose<UploadBeneficiaryProfileImageUseCase>(
  (ref) => UploadBeneficiaryProfileImageUseCase(
      ref.read(manageContactRepositoryProvider)),
);

///[VerifyBeneficiaryOtpUseCase] provider
final verifyBeneficiaryOtpUseCaseProvider =
    Provider.autoDispose<VerifyBeneficiaryOtpUseCase>(
  (ref) =>
      VerifyBeneficiaryOtpUseCase(ref.read(manageContactRepositoryProvider)),
);
