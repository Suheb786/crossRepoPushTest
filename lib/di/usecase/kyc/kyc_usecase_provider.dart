import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/kyc/check_kyc_status_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[CheckKYCStatusUseCase] provider
final checkKycStatusUseCaseProvider =
    Provider.autoDispose<CheckKYCStatusUseCase>(
  (ref) => CheckKYCStatusUseCase(ref.read(kycRepositoryProvider)),
);
