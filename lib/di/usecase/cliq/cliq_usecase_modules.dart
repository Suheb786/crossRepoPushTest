import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/edit_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/qr_cliq_code_usecase.dart';
import 'package:domain/usecase/cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/send_money_to_cliq_ibn_usecase.dart';
import 'package:domain/usecase/cliq/send_qr_cliq_payment_usecase.dart';
import 'package:domain/usecase/cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/update_rtp_cliq_request_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
