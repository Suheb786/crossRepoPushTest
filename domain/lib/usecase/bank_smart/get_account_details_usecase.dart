import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAccountDetailsUseCase
    extends BaseUseCase<NetworkError, GetAccountDetailsUseCaseParams, String> {
  final BankSmartRepository _bankSmartRepository;

  GetAccountDetailsUseCase(this._bankSmartRepository);

  @override
  Future<Either<NetworkError, String>> execute(
      {required GetAccountDetailsUseCaseParams params}) {
    return _bankSmartRepository.getAccountDetails(getToken: params.getToken!);
  }
}

class GetAccountDetailsUseCaseParams extends Params {
  final bool? getToken;

  GetAccountDetailsUseCaseParams({this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
