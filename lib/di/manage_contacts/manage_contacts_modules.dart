import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/manage_contacts/manage_contacts_usecase_provider.dart';
import 'package:neo_bank/di/usecase/payment/payment_usecase_provider.dart';
import 'package:neo_bank/di/usecase/upload_document/upload_document_usecase_provider.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_beneficiary_otp/add_beneficiary_otp_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_beneficiary_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/add_beneficiary/add_contacts_form/add_beneficiary_form_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contact_details/beneficiary_contact_details_page.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contact_details/beneficiary_contact_details_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_contacts_list/beneficiary_contacts_list_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/beneficiary_transaction_history_list/beneficiary_transaction_history_list_page_view_model.dart';

final beneficiaryContactListPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<BeneficiaryContactListPageViewModel>(
  (ref) => BeneficiaryContactListPageViewModel(ref.read(beneficiaryContactUseCaseProvider),
      ref.read(searchContactUseCaseProvider), ref.read(beneficiaryMarkFavoriteUseCase)),
);

final addBeneficiaryViewModelProvider =
    ChangeNotifierProvider.autoDispose<AddBeneficiaryPageViewModel>((ref) => AddBeneficiaryPageViewModel());

final addBeneficiaryFormPageViewModel = ChangeNotifierProvider.autoDispose<AddBeneficiaryFormPageViewModel>(
    (ref) => AddBeneficiaryFormPageViewModel(
        ref.read(addBeneficiaryOTPuseCaseProvider),
        ref.read(getPurposeUseCaseProvider),
        ref.read(checkSendMoneyUseCaseProvider),
        ref.read(getAccountByAliasUseCaseProvider)));

final addBeneficiaryotpPageViewModel = ChangeNotifierProvider.autoDispose<AddBeneficiaryotpPageViewModel>(
    (ref) => AddBeneficiaryotpPageViewModel(
        ref.read(addBeneficiaryUseCaseProvider), ref.read(resendOTPAddBeneficiaryUseCaseProvider)));

final beneficiaryContactAddedPageViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<BeneficiaryContactDetailsPageViewModel, BeneficiaryContactDetailArguments>((ref, args) =>
        BeneficiaryContactDetailsPageViewModel(
            ref.read(uploadDocumentUseCaseProvider),
            ref.read(deleteBeneficiaryUseCaseProvider),
            ref.read(updateBeneficiaryUseCaseProvider),
            ref.read(uploadBeneficiaryProfileImageUseCaseProvider),
            ref.read(removeBeneficiaryProfileImageUseCaseProvider),
            args));

final beneficiaryTransactionHistoryListPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<BeneficiaryTransactionHistoryListPageViewModel>(
  (ref) => BeneficiaryTransactionHistoryListPageViewModel(ref.read(getBeneficiaryUseCaseProvider)),
);
