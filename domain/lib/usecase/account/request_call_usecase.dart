import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestCallUseCase extends BaseUseCase<NetworkError, RequestCallUseCaseParams, RequestCallStatus> {
  final AccountRepository _accountRepository;

  RequestCallUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, RequestCallStatus>> execute({required RequestCallUseCaseParams params}) {
    return _accountRepository.requestCall(params.type);
  }
}

class RequestCallUseCaseParams extends Params {
  String? type;

  RequestCallUseCaseParams({this.type = "ONBOARD"});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
