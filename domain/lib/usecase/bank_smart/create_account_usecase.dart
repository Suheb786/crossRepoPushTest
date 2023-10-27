import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreateAccountUseCase extends BaseUseCase<BaseError, CreateAccountUseCaseParams, CreateAccountResponse> {
  final BankSmartRepository _bankSmartRepository;
  final UserRepository _userRepository;

  CreateAccountUseCase(this._bankSmartRepository, this._userRepository);

  @override
  Future<Either<BaseError, CreateAccountResponse>> execute(
      {required CreateAccountUseCaseParams params}) async {
    return Future.value(
      (await _bankSmartRepository.createAccount(
              cif: params.cif,
              getToken: true,
              isSubAccount: params.isSubAccount,
              customerInformation: params.customerInformation,
              accountDetails: params.accountDetails))
          .fold((l) => Left(l), (response) async {
        return (await _userRepository.getCurrentUser()).fold((l) => Left(l), (currentUser) async {
          currentUser.firstName = params.customerInformation.firstName ?? '';
          currentUser.lastName = params.customerInformation.lastName ?? '';
          currentUser.email = params.customerInformation.email ?? '';
          return (await _userRepository.saveUser(currentUser)).fold((l) => Left(l), (user) async {
            return Right(response);
          });
        });
      }),
    );
  }
}

class CreateAccountUseCaseParams extends Params {
  final CustomerInformation customerInformation;
  final CustomerAccountDetails accountDetails;
  final String? cif;
  final bool? isSubAccount;

  CreateAccountUseCaseParams({
    required this.customerInformation,
    required this.accountDetails,
    this.cif = '',
    this.isSubAccount = false,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
