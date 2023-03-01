import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/profile_settings/get_customer_doc_id/get_customer_doc_id_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCustomerDocIdUseCase
    extends BaseUseCase<NetworkError, GetCustomerDocIdUseCaseParams, GetCustomerDocIdResponse> {
  final AccountSettingsRepository _accountSettingsRepository;

  GetCustomerDocIdUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, GetCustomerDocIdResponse>> execute(
      {required GetCustomerDocIdUseCaseParams params}) {
    return _accountSettingsRepository.getCustomerDocId();
  }
}

class GetCustomerDocIdUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
