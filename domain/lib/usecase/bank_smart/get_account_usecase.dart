import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAccountUseCase
    extends BaseUseCase<NetworkError, GetAccountUseCaseParams, String> {
  final BankSmartRepository _bankSmartRepository;

  GetAccountUseCase(this._bankSmartRepository);

  @override
  Future<Either<NetworkError, String>> execute(
      {required GetAccountUseCaseParams params}) {
    return _bankSmartRepository.getAccount(
        getToken: params.getToken!, productCode: params.productCode);
  }
}

class GetAccountUseCaseParams extends Params {
  final bool? getToken;
  final String? productCode;

  GetAccountUseCaseParams({this.getToken, this.productCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
