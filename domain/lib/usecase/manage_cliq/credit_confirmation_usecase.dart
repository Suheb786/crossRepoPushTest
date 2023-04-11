import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/credit_confirmation/credit_confirmation.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreditConfirmationUseCase
    extends BaseUseCase<NetworkError, CreditConfirmationUseCaseParam, CreditConfirmation> {
  final CliqRepository _cliqRepository;
  final UserRepository _userRepository;

  CreditConfirmationUseCase(this._cliqRepository, this._userRepository);

  @override
  Future<Either<NetworkError, CreditConfirmation>> execute(
      {required CreditConfirmationUseCaseParam params}) async {
    final result = await _userRepository.getCurrentUser();
    result.fold((l) => Left(NetworkError(httpError: 400, cause: Exception(), message: 'No custID')), (r) {
      params.custID = r.cifNumber ?? '';
    });

    return _cliqRepository.getCreditConfirmation(custID: params.custID, msgId: params.msgId);
  }
}

class CreditConfirmationUseCaseParam extends Params {
  final String msgId;
  String custID;

  CreditConfirmationUseCaseParam({
    required this.msgId,
    this.custID = '',
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
