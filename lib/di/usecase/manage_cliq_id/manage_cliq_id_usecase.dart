import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/manage_cliq/add_link_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/add_new_mobile_number_cliq_usecase.dart';
import 'package:domain/usecase/manage_cliq/approve_RTP_request_usecase.dart';
import 'package:domain/usecase/manage_cliq/change_default_account_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/cliq_id_type_selection_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/confirm_change_default_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/create_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/create_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_alias_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_mobile_no_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/enter_otp_for_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/enter_otp_for_mobile_number_cliq_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_account_by_customerID_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_alias_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_cliq_account_by_alias_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_customer_by_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/link_bank_account_cliq_id_validate_usecase.dart';
import 'package:domain/usecase/manage_cliq/qr_cliq_code_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_money_activity_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_to_pay_result_usecase.dart';
import 'package:domain/usecase/manage_cliq/send_money_to_cliq_ibn_usecase.dart';
import 'package:domain/usecase/manage_cliq/send_qr_cliq_payment_usecase.dart';
import 'package:domain/usecase/manage_cliq/submit_outward_payment_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_usecase.dart';
import 'package:domain/usecase/manage_cliq/update_rtp_cliq_request_usecase.dart';
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

///[ReActivateCliqIdUseCase] provider
final reActivateCliqIdUseCaseProvider = Provider.autoDispose<ReActivateCliqIdUseCase>(
  (ref) => ReActivateCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[GetAccountByCustomerIDUsecase] provider
final getAccountByCustomerID = Provider.autoDispose<GetAccountByCustomerIDUseCase>(
  (ref) => GetAccountByCustomerIDUseCase(ref.read(cliqRepositoryProvider)),
);

///[suspendCliqIdUseCase] provider
final suspendCliqIdUseCaseProvider = Provider.autoDispose<SuspendCliqIdUseCase>(
  (ref) => SuspendCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[getAliasUseCase] provider
final getAliasUseCaseProvider = Provider.autoDispose<GetAliasUsecase>(
  (ref) => GetAliasUsecase(ref.read(cliqRepositoryProvider)),
);

///[getCliqAccountByAliasUseCase] provider
final getCliqAccountByAliasUseCaseProvider = Provider.autoDispose<GetCliqAccountByAliasUseCase>(
  (ref) => GetCliqAccountByAliasUseCase(ref.read(cliqRepositoryProvider)),
);

///[ConfirmCreateCliqIdUseCase] provider
final confirmCreateCliqIdUseCaseProvider = Provider.autoDispose<ConfirmCreateCliqIdUseCase>(
  (ref) => ConfirmCreateCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[addLinkAccountUseCase] provider
final addLinkAccountUseCaseProvider = Provider.autoDispose<AddLInkAccountUseCase>(
  (ref) => AddLInkAccountUseCase(ref.read(cliqRepositoryProvider)),
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

///[RequestMoneyUseCase] provider
final requestMoneyUseCaseProvider = Provider.autoDispose<RequestMoneyUseCase>(
  (ref) => RequestMoneyUseCase(ref.read(cliqRepositoryProvider)),
);

///[RequestToPayResultUsecase] provider
final requestToPayResult = Provider.autoDispose<RequestToPayResultUseCase>(
  (ref) => RequestToPayResultUseCase(ref.read(cliqRepositoryProvider)),
);

///[RequestMoneyActivityUseCase] provider
final requestMoneyActivityUseCaseProvider = Provider.autoDispose<RequestMoneyActivityUseCase>(
  (ref) => RequestMoneyActivityUseCase(ref.read(cliqRepositoryProvider)),
);

///[UpdateRtpCliqRequestUsecase] provider
final updateRtpCliqRequestUsecaseProvider = Provider.autoDispose<UpdateRtpCliqRequestUsecase>(
  (ref) => UpdateRtpCliqRequestUsecase(ref.read(cliqRepositoryProvider)),
);

///[SendQrCliqPaymentUsecase] provider
final sendQrCliqPaymentUsecaseProvider = Provider.autoDispose<SendQrCliqPaymentUsecase>(
  (ref) => SendQrCliqPaymentUsecase(ref.read(cliqRepositoryProvider)),
);

///[ApproveRTPRequestUseCase] provider
final approveRTPRequest = Provider.autoDispose<ApproveRTPRequestUseCase>(
  (ref) => ApproveRTPRequestUseCase(ref.read(cliqRepositoryProvider)),
);

///[SubmitOutwardPaymentUseCase] provider
final submitOutwardPayment = Provider.autoDispose<SubmitOutwardPaymentUseCase>(
  (ref) => SubmitOutwardPaymentUseCase(ref.read(cliqRepositoryProvider)),
);

///[SendMoneyToCliqIbnUsecase] provider
final sendMoneyToCliqIbnUsecaseProvider = Provider.autoDispose<SendMoneyToCliqIbnUsecase>(
  (ref) => SendMoneyToCliqIbnUsecase(ref.read(cliqRepositoryProvider)),
);

///[QrClipCodeUsecase] provider
final qrClipCodeUsecaseProvider = Provider.autoDispose<QrClipCodeUsecase>(
  (ref) => QrClipCodeUsecase(ref.read(cliqRepositoryProvider)),
);

///[GetCustomerByAccountUsecase] provider
final getCustomerByAccount = Provider.autoDispose<GetCustomerByAccountUseCase>(
  (ref) => GetCustomerByAccountUseCase(ref.read(cliqRepositoryProvider)),
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
