import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RejectionReasonInwardUseCase
    extends BaseUseCase<NetworkError, RejectionReasonInwardUseCaseParams, List<RejectionReasonInward>> {
  final CliqRepository _cliqRepository;

  RejectionReasonInwardUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, List<RejectionReasonInward>>> execute(
      {required RejectionReasonInwardUseCaseParams params}) {
    return _cliqRepository.getRejectionReasons();
  }
}

class RejectionReasonInwardUseCaseParams extends Params {
  RejectionReasonInwardUseCaseParams();

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
