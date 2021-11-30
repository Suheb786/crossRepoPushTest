import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreateAccountUseCase extends BaseUseCase<NetworkError,
    CreateAccountUseCaseParams, CreateAccountResponse> {
  final BankSmartRepository _bankSmartRepository;

  CreateAccountUseCase(this._bankSmartRepository);

  @override
  Future<Either<NetworkError, CreateAccountResponse>> execute(
      {required CreateAccountUseCaseParams params}) {
    return _bankSmartRepository.createAccount(
        getToken: true,
        customerInformation: params.customerInformation,
        accountDetails: params.accountDetails);
  }
}

class CreateAccountUseCaseParams extends Params {
  final CustomerInformation customerInformation;
  final CustomerAccountDetails accountDetails;

  CreateAccountUseCaseParams(
      {required this.customerInformation, required this.accountDetails});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
