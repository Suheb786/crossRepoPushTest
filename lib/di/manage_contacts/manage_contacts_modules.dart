import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/manage_contacts/manage_contacts_usecase_provider.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/otp_for_manage_contact/otp_for_manage_contact_page_view_model.dart';

final manageContactsListViewModelProvider =
    ChangeNotifierProvider.autoDispose<ManageContactListPageViewModel>(
  (ref) => ManageContactListPageViewModel(ref.read(getBeneficiaryUseCaseProvider)),
);

///manage contact details
final manageContactDetailsViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<ManageContactDetailsPageViewModel, Beneficiary>(
  (ref, args) => ManageContactDetailsPageViewModel(
      ref.read(uploadDocumentUseCaseProvider),
      args,
      ref.read(updateBeneficiaryUseCaseProvider),
      ref.read(deleteBeneficiaryUseCaseProvider),
      ref.read(uploadBeneficiaryProfileImageUseCaseProvider),
      ref.read(getPurposeUseCaseProvider)),
);

final otpForManageContactPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<OtpForManageContactPageViewModel>(
  (ref) => OtpForManageContactPageViewModel(ref.read(manageContactOtpValidationUseCaseProvider)),
);
