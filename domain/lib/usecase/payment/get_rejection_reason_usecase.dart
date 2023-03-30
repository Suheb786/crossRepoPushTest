import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/payment/payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetRejectionReasonUseCase extends BaseUseCase<NetworkError, GetRejectionReasonUseCaseParams, bool> {
  final PaymentRepository _paymentRepository;
  GetRejectionReasonUseCase(this._paymentRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required GetRejectionReasonUseCaseParams params}) {
    return _paymentRepository.getRejectionReason(GetToken: params.GetToken);
  }
}

class GetRejectionReasonUseCaseParams extends Params {
  final bool GetToken;

  GetRejectionReasonUseCaseParams(this.GetToken);

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
