import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/dashboard/account_transaction_usecase.dart';
import 'package:domain/usecase/dashboard/card_detail_usecase.dart';
import 'package:domain/usecase/dashboard/card_transaction_usecase.dart';
import 'package:domain/usecase/dashboard/credit_card_delivered_usecase.dart';
import 'package:domain/usecase/dashboard/credit_card_verification_success_usecase.dart';
import 'package:domain/usecase/dashboard/debit_card_delivered_usecase.dart';
import 'package:domain/usecase/dashboard/debit_card_verification_success_usecase.dart';
import 'package:domain/usecase/dashboard/get_card_usecase.dart';
import 'package:domain/usecase/dashboard/my_account_usecase.dart';
import 'package:domain/usecase/dashboard/my_debit_card_usecase.dart';
import 'package:domain/usecase/register/student_job_income_usecase.dart';
import 'package:domain/usecase/user/account_ready_usecase.dart';
import 'package:domain/usecase/user/agent_selection_usecase.dart';
import 'package:domain/usecase/user/check_user_name_mobile_usecase.dart';
import 'package:domain/usecase/user/check_username_usecase.dart';
import 'package:domain/usecase/user/confirm_detail_usecase.dart';
import 'package:domain/usecase/user/enter_address_usecase.dart';
import 'package:domain/usecase/user/home_address_dialog_usecase.dart';
import 'package:domain/usecase/user/id_verification_info_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/product_selector_usecase.dart';
import 'package:domain/usecase/user/profile_details_usecase.dart';
import 'package:domain/usecase/user/register_prospect_usecase.dart';
import 'package:domain/usecase/user/scan_user_document_usecase.dart';
import 'package:domain/usecase/user/send_documents_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:domain/usecase/user/video_call_info_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[LoginUseCase] provider
final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(ref.read(userRepoProvider)),
);

///[ProfileDetailsUseCase] provider
final profileDetailsUseCaseProvider =
    Provider.autoDispose<ProfileDetailsUseCase>(
  (ref) => ProfileDetailsUseCase(ref.read(userRepoProvider)),
);

///[UploadDocumentsUseCase] provider
final sendDocumentsUseCaseUseCaseProvider =
    Provider.autoDispose<SendDocumentsUseCase>(
  (ref) => SendDocumentsUseCase(),
);

///[IdVerificationInfoUseCase] provider
final idVerificationInfoUseCaseProvider =
    Provider.autoDispose<IdVerificationInfoUseCase>(
  (ref) => IdVerificationInfoUseCase(),
);

///[ConfirmDetailUseCase] provider
final confirmDetailUseCaseProvider = Provider.autoDispose<ConfirmDetailUseCase>(
  (ref) => ConfirmDetailUseCase(ref.read(userRepoProvider)),
);

///[EnterAddressUseCase] provider
final enterAddressUseCaseProvider = Provider.autoDispose<EnterAddressUseCase>(
  (ref) => EnterAddressUseCase(ref.read(userRepoProvider)),
);

///[AccountReadyUseCase] provider
final accountReadyUseCaseProvider = Provider.autoDispose<AccountReadyUseCase>(
  (ref) => AccountReadyUseCase(),
);

///[HomeAddressDialogUseCase] provider
final homeAddressDialogUseCaseProvider =
    Provider.autoDispose<HomeAddressDialogUseCase>(
  (ref) => HomeAddressDialogUseCase(
    ref.read(homeAddressDialogRepositoryProvider),
  ),
);

///[ProductSelectorUseCase] provider
final productSelectorUseCaseProvider =
    Provider.autoDispose<ProductSelectorUseCase>(
  (ref) => ProductSelectorUseCase(),
);

///[VideoCallInfoUseCase] provider
final videoCallInfoUseCaseProvider = Provider.autoDispose<VideoCallInfoUseCase>(
  (ref) => VideoCallInfoUseCase(),
);

///[AgentSelectionUseCase] provider
final agentSelectionUseCaseProvider =
    Provider.autoDispose<AgentSelectionUseCase>(
  (ref) => AgentSelectionUseCase(),
);

///[StudentJobIncomeUseCase] provider
final studentJobIncomeUseCaseProvider =
    Provider.autoDispose<StudentJobIncomeUseCase>(
  (ref) => StudentJobIncomeUseCase(),
);

///[CheckUserNameUseCase] provider
final checkUserNameUseCaseProvider = Provider.autoDispose<CheckUserNameUseCase>(
  (ref) => CheckUserNameUseCase(ref.read(userRepoProvider)),
);

///[CheckUserNameMobileUseCase] provider
final checkUserNameMobileUseCaseProvider =
    Provider.autoDispose<CheckUserNameMobileUseCase>(
  (ref) => CheckUserNameMobileUseCase(ref.read(userRepoProvider)),
);

///[RegisterProspectUseCase] provider
final registerProspectUseCaseProvider =
    Provider.autoDispose<RegisterProspectUseCase>(
  (ref) => RegisterProspectUseCase(ref.read(userRepoProvider)),
);

///[VerifyOtpUseCase] provider
final verifyMobileOtpUseCaseProvider = Provider.autoDispose<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(ref.read(userRepoProvider)),
);

///[ScanUserDocumentUseCase] provider
final scanUserDocumentUseCaseProvider = Provider<ScanUserDocumentUseCase>(
    (ref) => ScanUserDocumentUseCase(ref.read(userRepoProvider)));

///[GetCardUseCase] provider
final getCardUseCaseProvider = Provider.autoDispose<GetCardUseCase>(
  (ref) => GetCardUseCase(),
);

///[MyAccountUseCase] provider
final myAccountUseCaseProvider = Provider.autoDispose<MyAccountUseCase>(
  (ref) => MyAccountUseCase(),
);

///[<MyDebitCardUseCase>] provider
final myDebitCardUseCaseProvider = Provider.autoDispose<MyDebitCardUseCase>(
  (ref) => MyDebitCardUseCase(),
);

///[<CardDeliveredUseCase>] provider
final cardDeliveredUseCaseProvider =
    Provider.autoDispose<DebitCardDeliveredUseCase>(
  (ref) => DebitCardDeliveredUseCase(),
);

///[<DebitCardVerificationSuccessUseCase>] provider
final debitCardVerificationSuccessUseCaseProvider =
    Provider.autoDispose<DebitCardVerificationSuccessUseCase>(
  (ref) => DebitCardVerificationSuccessUseCase(),
);

///[<CardDetailUseCase>] provider
final cardDetailUseCaseProvider = Provider.autoDispose<CardDetailUseCase>(
  (ref) => CardDetailUseCase(),
);

///[<CardTransactionUseCase>] provider
final cardTransactionUseCaseProvider =
    Provider.autoDispose<CardTransactionUseCase>(
  (ref) => CardTransactionUseCase(),
);

///[<CreditCardDeliveredUseCase>] provider
final creditCardDeliveredUseCaseProvider =
    Provider.autoDispose<CreditCardDeliveredUseCase>(
  (ref) => CreditCardDeliveredUseCase(),
);

///[<CreditCardVerificationSuccessUseCase>] provider
final creditCardVerificationSuccessUseCaseProvider =
    Provider.autoDispose<CreditCardVerificationSuccessUseCase>(
  (ref) => CreditCardVerificationSuccessUseCase(),
);

///[<AccountTransactionUseCase>] provider
final accountTransactionUseCaseProvider =
    Provider.autoDispose<AccountTransactionUseCase>(
  (ref) => AccountTransactionUseCase(),
);