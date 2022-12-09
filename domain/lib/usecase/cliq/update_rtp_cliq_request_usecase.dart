import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UpdateRtpCliqRequestUsecase extends BaseUseCase<NetworkError, UpdateRtpCliqRequestUsecaseParams, bool> {
  final CliqRepository _cliqRepository;

  UpdateRtpCliqRequestUsecase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required UpdateRtpCliqRequestUsecaseParams params}) {
    return _cliqRepository.updateRTPCliqRequest(
        msgId: params.msgId,
        rejectReason: params.rejectReason,
        rejectAddInfo: params.rejectAddInfo,
        dbtrBic: params.dbtrBic,
        dbtrAcct: params.dbtrAcct,
        dbtrName: params.dbtrName,
        dbtrIsIndvl: params.dbtrIsIndvl,
        cdtrBic: params.cdtrBic,
        cdtrAcct: params.cdtrAcct,
        cdtrName: params.cdtrName,
        cdtrIsIndvl: params.cdtrIsIndvl,
        rmtInf: params.rmtInf,
        ctgyPurp: params.ctgyPurp,
        amount: params.amount,
        curr: params.curr,
        rtpStatus: params.rtpStatus,
        otPcode: params.otPcode,
        cdtrPstlAdr: params.cdtrPstlAdr,
        dbtrPstlAdr: params.dbtrPstlAdr,
        getToken: params.getToken);
  }
}

class UpdateRtpCliqRequestUsecaseParams extends Params {
  final String msgId;
  final String rejectReason;
  final String rejectAddInfo;
  final String dbtrBic;
  final String dbtrAcct;
  final String dbtrName;
  final String dbtrIsIndvl;
  final String cdtrBic;
  final String cdtrAcct;
  final String cdtrName;
  final String cdtrIsIndvl;
  final String rmtInf;
  final String ctgyPurp;
  final String amount;
  final String curr;
  final bool rtpStatus;
  final String otPcode;
  final String cdtrPstlAdr;
  final String dbtrPstlAdr;
  final bool getToken;

  UpdateRtpCliqRequestUsecaseParams({
    required this.msgId,
    required this.rejectReason,
    required this.rejectAddInfo,
    required this.dbtrBic,
    required this.dbtrAcct,
    required this.dbtrName,
    required this.dbtrIsIndvl,
    required this.cdtrBic,
    required this.cdtrAcct,
    required this.cdtrName,
    required this.cdtrIsIndvl,
    required this.rmtInf,
    required this.ctgyPurp,
    required this.amount,
    required this.curr,
    required this.rtpStatus,
    required this.otPcode,
    required this.cdtrPstlAdr,
    required this.dbtrPstlAdr,
    required this.getToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
