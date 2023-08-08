import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAccountByAliasUseCase
    extends BaseUseCase<NetworkError, GetAccountByAliasUseCaseParams, GetAccountByAliasContentResponse> {
  final PaymentRepository _repository;

  GetAccountByAliasUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetAccountByAliasContentResponse>> execute(
      {required GetAccountByAliasUseCaseParams params}) {
    return _repository.getAccountByAlias(params.value ?? '', params.currency ?? '', params.beneficiaryId);
  }
}

class GetAccountByAliasUseCaseParams extends Params {
  String? value;
  String? currency;
  String beneficiaryId;

  GetAccountByAliasUseCaseParams({this.value, this.currency = "JOD", required this.beneficiaryId});

  @override
  Either<AppError, bool> verify() {
    if (value == null || value!.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.EMPTY_IBAN_MOBILE, cause: Exception()));
    }
    return Right(true);
  }
}
