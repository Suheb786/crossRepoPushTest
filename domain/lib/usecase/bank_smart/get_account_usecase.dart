import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAccountUseCase extends BaseUseCase<NetworkError, GetAccountUseCaseParams, GetAccountResponse> {
  final BankSmartRepository _bankSmartRepository;

  GetAccountUseCase(this._bankSmartRepository);

  @override
  Future<Either<NetworkError, GetAccountResponse>> execute({required GetAccountUseCaseParams params}) {
    return _bankSmartRepository.getAccount(getToken: true);
  }
}

class GetAccountUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
