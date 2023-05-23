import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/manage_contacts/manage_contacts_usecase_provider.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contact_IBAN_otp/add_contact_IBAN_otp_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contacts_IBAN_form/add_contacts_IBAN_form_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contacts_IBAN_page_view_model.dart';
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

final addContactIBANViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddContactsIBANManageContactsPageViewModel>(
        (ref) => AddContactsIBANManageContactsPageViewModel());

final addContactIBANformPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddContactsIBANformPageViewModel>(
        (ref) => AddContactsIBANformPageViewModel(ref.read(addContactIBANuseCaseProvider)));

final addcontactIBANotpPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddContactIBANotpPageViewModel>(
        (ref) => AddContactIBANotpPageViewModel(ref.read(addContactIbanOTPuseCaseProvider)));

final editContactAddedPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<BeneficiaryContactDetailsPageViewModel, Beneficiary>(
        (ref, args) => BeneficiaryContactDetailsPageViewModel(ref.read(uploadDocumentUseCaseProvider), args));

final editContactotpPageViewModelProvider = ChangeNotifierProvider.autoDispose<EditUserContactotpViewModel>(
    (ref) => EditUserContactotpViewModel(ref.read(editContactIbanOTPuseCaseProvider)));
final otpForManageContactPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<DeleteContactOTPPageViewModel>(
  (ref) => DeleteContactOTPPageViewModel(ref.read(manageContactOtpValidationUseCaseProvider)),
);
