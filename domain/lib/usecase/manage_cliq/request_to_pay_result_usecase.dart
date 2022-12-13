import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class RequestToPayResultUseCase extends BaseUseCase<NetworkError, RequestToPayResultUsecaseParams, bool> {
  final CliqRepository _cliqRepository;

  RequestToPayResultUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required RequestToPayResultUsecaseParams params}) {
    return _cliqRepository.requestToPayResult(
        CustID: params.CustID,
        OrgnlMsgId: params.OrgnlMsgId,
        RTPStatus: params.RTPStatus,
        RejectReason: params.RejectReason,
        RejectADdInfo: params.RejectADdInfo);
  }
}

class RequestToPayResultUsecaseParams extends Params {
  final String CustID;
  final String OrgnlMsgId;
  final String RTPStatus;
  final String RejectReason;
  final String RejectADdInfo;

  RequestToPayResultUsecaseParams(
      {required this.CustID,
      required this.OrgnlMsgId,
      required this.RTPStatus,
      required this.RejectReason,
      required this.RejectADdInfo});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
