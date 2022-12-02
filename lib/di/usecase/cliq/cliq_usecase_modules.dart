import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/cliq/create_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/edit_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/qr_cliq_code_usecase.dart';
import 'package:domain/usecase/cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/send_money_to_cliq_ibn_usecase.dart';
import 'package:domain/usecase/cliq/send_qr_cliq_payment_usecase.dart';
import 'package:domain/usecase/cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/update_rtp_cliq_request_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/cliq/get_alias_usecase.dart';
import 'package:domain/usecase/cliq/get_cliq_account_by_alias_usecase.dart';
import 'package:domain/usecase/cliq/add_link_account_usecase.dart';
import 'package:domain/usecase/cliq/change_default_account_usecase.dart';
import 'package:domain/usecase/cliq/unlink_account_from_cliq_usecase.dart';
import 'package:domain/usecase/cliq/request_account_usecase.dart';
import 'package:domain/usecase/cliq/request_money_activity_usecase.dart';

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

///[suspendCliqIdUseCase] provider
final suspendCliqIdUseCaseProvider = Provider.autoDispose<SuspendCliqIdUseCase>(
  (ref) => SuspendCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[getAliasUseCase] provider
final getAliasUseCaseProvider = Provider.autoDispose<GetAliasUsecase>(
  (ref) => GetAliasUsecase(ref.read(cliqRepositoryProvider)),
);

///[getCliqAccountByAliasUseCase] provider
final getCliqAccountByAliasUseCaseProvider =
    Provider.autoDispose<GetCliqAccountByAliasUseCase>(
  (ref) => GetCliqAccountByAliasUseCase(ref.read(cliqRepositoryProvider)),
);

///[createCliqIdUseCase] provider
final createCliqIdUseCaseProvider = Provider.autoDispose<CreateCliqIdUseCase>(
  (ref) => CreateCliqIdUseCase(ref.read(cliqRepositoryProvider)),
);

///[addLinkAccountUseCase] provider
final addLinkAccountUseCaseProvider =
    Provider.autoDispose<AddLInkAccountUseCase>(
  (ref) => AddLInkAccountUseCase(ref.read(cliqRepositoryProvider)),
);

///[changeDefaultAccountUseCase] provider
final changeDefaultAccountUseCaseProvider =
    Provider.autoDispose<ChangeDefaultAccountUseCase>(
  (ref) => ChangeDefaultAccountUseCase(ref.read(cliqRepositoryProvider)),
);

///[UnLinkAccountFromCliqUseCase] provider
final unLinkAccountFromCliqUseCaseProvider =
    Provider.autoDispose<UnlinkAccountFromCliqUseCase>(
  (ref) => UnlinkAccountFromCliqUseCase(ref.read(cliqRepositoryProvider)),
);

///[RequestMoneyUseCase] provider
final requestMoneyUseCaseProvider = Provider.autoDispose<RequestMoneyUseCase>(
  (ref) => RequestMoneyUseCase(ref.read(cliqRepositoryProvider)),
);

///[RequestMoneyActivityUseCase] provider
final requestMoneyActivityUseCaseProvider =
    Provider.autoDispose<RequestMoneyActivityUseCase>(
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

///[SendMoneyToCliqIbnUsecase] provider
final sendMoneyToCliqIbnUsecaseProvider = Provider.autoDispose<SendMoneyToCliqIbnUsecase>(
  (ref) => SendMoneyToCliqIbnUsecase(ref.read(cliqRepositoryProvider)),
);

///[QrClipCodeUsecase] provider
final qrClipCodeUsecaseProvider = Provider.autoDispose<QrClipCodeUsecase>(
  (ref) => QrClipCodeUsecase(ref.read(cliqRepositoryProvider)),
);
