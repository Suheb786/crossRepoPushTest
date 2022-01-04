import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetPurposeUseCase extends BaseUseCase<NetworkError,
    GetPurposeUseCaseParams, PurposeResponse> {
  final PaymentRepository _repository;

  GetPurposeUseCase(this._repository);

  @override
  Future<Either<NetworkError, PurposeResponse>> execute(
      {required GetPurposeUseCaseParams params}) {
    return _repository.getPurpose(params.toAccount!, params.transferType!);
  }
}

class GetPurposeUseCaseParams extends Params {
  String? toAccount;
  String? transferType;

  GetPurposeUseCaseParams({this.toAccount, this.transferType});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
