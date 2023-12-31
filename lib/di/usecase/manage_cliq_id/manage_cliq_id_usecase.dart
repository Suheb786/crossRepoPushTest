import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/manage_cliq/add_link_account_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/add_link_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/add_new_mobile_number_cliq_usecase.dart';
import 'package:domain/usecase/manage_cliq/approve_RTP_request_usecase.dart';
import 'package:domain/usecase/manage_cliq/approve_rtp_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/change_default_account_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/cliq_id_type_selection_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/confirm_change_default_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/create_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/create_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_alias_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_mobile_no_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/enter_otp_for_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/enter_otp_for_mobile_number_cliq_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_account_by_customerID_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_alias_usecase.dart';
import 'package:domain/usecase/manage_cliq/link_bank_account_cliq_id_validate_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/rejection_reason_inward_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_to_pay_result_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_to_pay_result_usecase.dart';
import 'package:domain/usecase/manage_cliq/return_RTP_request_usecase.dart';
import 'package:domain/usecase/manage_cliq/return_rtp_request_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/submit_outward_payment_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CliqIdTypeSelectionUseCase] provider
final cliqIdTypSelectioneUseCaseProvider = Provider.autoDispose<CliqIdTypeSelectionValidationUseCase>(
  (ref) => CliqIdTypeSelectionValidationUseCase(),
);

///[EnterOtpForCliqIdUseCase] provider
final enterOtpForCliqIdUseCaseProvider = Provider.autoDispose<EnterOtpForCliqIdValidationUseCase>(
  (ref) => EnterOtpForCliqIdValidationUseCase(),
);

///[AddNewMobileNumberCliqUseCase] provider
final addNewMobileNumberCliqUseCaseProvider = Provider.autoDispose<AddNewMobileNumberCliqUseCase>(
  (ref) => AddNewMobileNumberCliqUseCase(),
);

///[EnterOtpForMobileNumberCliqUseCaseParams] provider
final enterOtpForMobileNumberCliqUseCaseProvider = Provider.autoDispose<EnterOtpForMobileNumberCliqUseCase>(
  (ref) => EnterOtpForMobileNumberCliqUseCase(),
);

///[EditCliqIdUseCase] provider
final editCliqIdUseCaseProvider = Provider.autoDispose<EditCliqIdUseCase>(
  (ref) => EditCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[DeleteCliqIdUseCase] provider
final deleteCliqIdUseCaseProvider = Provider.autoDispose<DeleteCliqIdUseCase>(
  (ref) => DeleteCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[DeleteCliqIdOtpUseCase] provider
final deleteCliqIdOtpUseCaseProvider = Provider.autoDispose<DeleteCliqIdOtpUseCase>(
  (ref) => DeleteCliqIdOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[ReActivateCliqIdUseCase] provider
final reActivateCliqIdUseCaseProvider = Provider.autoDispose<ReActivateCliqIdUseCase>(
  (ref) => ReActivateCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[ReActivateCliqIdOtpUseCase] provider
final reActivateCliqIdOtpUseCaseProvider = Provider.autoDispose<ReActivateCliqIdOtpUseCase>(
  (ref) => ReActivateCliqIdOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[GetAccountByCustomerIDUsecase] provider
final getAccountByCustomerID = Provider.autoDispose<GetAccountByCustomerIDUseCase>(
  (ref) => GetAccountByCustomerIDUseCase(ref.read(cliqRepositoryProvider)),
);

///[suspendCliqIdUseCase] provider
final suspendCliqIdUseCaseProvider = Provider.autoDispose<SuspendCliqIdUseCase>(
  (ref) => SuspendCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[SuspendCliqIdOtpUseCase] provider
final suspendCliqIdOtpUseCaseProvider = Provider.autoDispose<SuspendCliqIdOtpUseCase>(
  (ref) => SuspendCliqIdOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[getAliasUseCase] provider
final getAliasUseCaseProvider = Provider.autoDispose<GetAliasUsecase>(
  (ref) => GetAliasUsecase(ref.read(cliqRepositoryProvider)),
);

///[ConfirmCreateCliqIdUseCase] provider
final confirmCreateCliqIdUseCaseProvider = Provider.autoDispose<ConfirmCreateCliqIdUseCase>(
  (ref) => ConfirmCreateCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[AddLinkAccountUseCase] provider
final addLinkAccountUseCaseProvider = Provider.autoDispose<AddLInkAccountUseCase>(
  (ref) => AddLInkAccountUseCase(ref.read(cliqRepositoryProvider)),
);

///[AddLInkAccountOtpUseCase] provider
final addLInkAccountOtpUseCaseProvider = Provider.autoDispose<AddLInkAccountOtpUseCase>(
  (ref) => AddLInkAccountOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[ChangeDefaultAccountOtpUsecase] provider
final changeDefaultAccountOtp = Provider.autoDispose<ChangeDefaultAccountOtpUseCase>(
  (ref) => ChangeDefaultAccountOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[confirmChangeDefaultAccountUseCase] provider
final confirmChangeDefaultAccountUseCaseProvider = Provider.autoDispose<ConfirmChangeDefaultAccountUseCase>(
  (ref) => ConfirmChangeDefaultAccountUseCase(ref.read(cliqRepositoryProvider)),
);

///[UnLinkAccountFromCliqUseCase] provider
final unLinkAccountFromCliqUseCaseProvider = Provider.autoDispose<UnlinkAccountFromCliqUseCase>(
  (ref) => UnlinkAccountFromCliqUseCase(ref.read(cliqRepositoryProvider)),
);

///[UnlinkAccountFromCliqOtpUseCase] provider
final unlinkAccountFromCliqOtpUseCaseProvider = Provider.autoDispose<UnlinkAccountFromCliqOtpUseCase>(
  (ref) => UnlinkAccountFromCliqOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[RequestToPayResultUsecase] provider
final requestToPayResultUseCaseProvider = Provider.autoDispose<RequestToPayResultUseCase>(
  (ref) => RequestToPayResultUseCase(ref.read(cliqRepositoryProvider)),
);

///[RequestMoneyActivityUseCase] provider
final requestMoneyActivityUseCaseProvider = Provider.autoDispose<RequestMoneyActivityUseCase>(
  (ref) => RequestMoneyActivityUseCase(ref.read(cliqRepositoryProvider)),
);

///[ApproveRTPRequestUseCase] provider
final approveRTPRequestUseCaseProivder = Provider.autoDispose<ApproveRTPRequestUseCase>(
  (ref) => ApproveRTPRequestUseCase(ref.read(cliqRepositoryProvider)),
);

///[SubmitOutwardPaymentUseCase] provider
final submitOutwardPayment = Provider.autoDispose<SubmitOutwardPaymentUseCase>(
  (ref) => SubmitOutwardPaymentUseCase(ref.read(cliqRepositoryProvider)),
);

///[CreateCliqIdUseCase] provider
final createCliqIdOtpUseCaseProvider = Provider.autoDispose<CreateCliqIdOtpUseCase>(
  (ref) => CreateCliqIdOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[LinkBankAccountCliqIdValidationUseCase] provider
final linkBankAccountCliqIdValidationUseCaseProvider =
    Provider.autoDispose<LinkBankAccountCliqIdValidationUseCase>(
  (ref) => LinkBankAccountCliqIdValidationUseCase(),
);

final editAliasValidationUseCaseProvider = Provider.autoDispose<EditAliasValidationUseCase>(
  (ref) => EditAliasValidationUseCase(),
);

final editCliqOtpUseCaseProvider = Provider.autoDispose<EditCliqOtpUseCase>(
  (ref) => EditCliqOtpUseCase(ref.read(cliqRepositoryProvider)),
);

final editCliqMobileNoValidationUseCaseProvider = Provider.autoDispose<EditCliqMobileNoValidationUseCase>(
  (ref) => EditCliqMobileNoValidationUseCase(),
);

///[RejectionReasonInwardUseCase] provider
final rejectionReasonInwardUseCaseProvider = Provider.autoDispose<RejectionReasonInwardUseCase>(
  (ref) => RejectionReasonInwardUseCase(ref.read(cliqRepositoryProvider)),
);

///[ApproveRTPOtpUseCase] provider
final approveRTPOtpUseCaseProivder = Provider.autoDispose<ApproveRTPOtpUseCase>(
  (ref) => ApproveRTPOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[RequestToPayResultOtpUseCase] provider
final requestToPayResultOtpUseCaseProivder = Provider.autoDispose<RequestToPayResultOtpUseCase>(
  (ref) => RequestToPayResultOtpUseCase(ref.read(cliqRepositoryProvider)),
);

///[returnRTPrequestOTPUseCase] provider
final returnRTPrequestOTPUseCaseProivder = Provider.autoDispose<ReturnRTPrequestOTPUsecase>(
  (ref) => ReturnRTPrequestOTPUsecase(ref.read(cliqRepositoryProvider)),
);

///[returnRTPrequestUseCase] provider
final returnRTPrequestUseCaseProivder = Provider.autoDispose<ReturnRTPrequestUsecase>(
  (ref) => ReturnRTPrequestUsecase(ref.read(cliqRepositoryProvider)),
);
