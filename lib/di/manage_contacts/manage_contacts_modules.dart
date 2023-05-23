import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/manage_contacts/manage_contacts_usecase_provider.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_beneficiary_otp/add_beneficiary_otp_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_beneficiary_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_contacts_form/add_beneficiary_form_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contact_details/beneficiary_contact_details_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/delete_contact_otp_for_manage_contact/delete_contact_otp_for_manage_contact_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/edit_contact_details_otp/edit_contact_details_otp_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contact_detail/manage_contact_details_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';

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

final addBeneficiaryViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddBeneficiaryPageViewModel>((ref) => AddBeneficiaryPageViewModel());

final addBeneficiaryFormPageViewModel = ChangeNotifierProvider.autoDispose<AddBeneficiaryFormPageViewModel>(
    (ref) => AddBeneficiaryFormPageViewModel(
        ref.read(addBeneficiaryUseCaseProvider), ref.read(getPurposeUseCaseProvider)));

final addBeneficiaryotpPageViewModel = ChangeNotifierProvider.autoDispose<AddBeneficiaryotpPageViewModel>(
    (ref) => AddBeneficiaryotpPageViewModel(ref.read(addBeneficiaryOTPuseCaseProvider)));

final editContactAddedPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<BeneficiaryContactDetailsPageViewModel, Beneficiary>(
        (ref, args) => BeneficiaryContactDetailsPageViewModel(ref.read(uploadDocumentUseCaseProvider), args));

final editContactotpPageViewModelProvider = ChangeNotifierProvider.autoDispose<EditUserContactotpViewModel>(
    (ref) => EditUserContactotpViewModel(ref.read(editContactIbanOTPuseCaseProvider)));

final otpForManageContactPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<DeleteContactOTPPageViewModel>(
  (ref) => DeleteContactOTPPageViewModel(ref.read(manageContactOtpValidationUseCaseProvider)),
);
