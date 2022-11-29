import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bank_smart/get_account_details_response.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAccountDetailsUseCase
    extends BaseUseCase<NetworkError, GetAccountDetailsUseCaseParams, GetAccountDetailsResponse> {
  final BankSmartRepository _bankSmartRepository;

  GetAccountDetailsUseCase(this._bankSmartRepository);

  @override
  Future<Either<NetworkError, GetAccountDetailsResponse>> execute(
      {required GetAccountDetailsUseCaseParams params}) {
    return _bankSmartRepository.getAccountDetails(getToken: true);
  }
}

class GetAccountDetailsUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
