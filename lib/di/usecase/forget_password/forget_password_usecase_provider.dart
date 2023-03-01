import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/forget_password/check_forget_password_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkForgetPasswordUseCaseProvider = Provider.autoDispose<CheckForgetPasswordUseCase>(
  (ref) => CheckForgetPasswordUseCase(ref.read(forgetPasswordRepositoryProvider)),
);
