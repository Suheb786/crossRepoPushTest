// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ReturnRTPrequestUsecase extends BaseUseCase<NetworkError, ReturnRTPrequestUsecaseParams, bool> {
  final CliqRepository _cliqRepository;

  ReturnRTPrequestUsecase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ReturnRTPrequestUsecaseParams params}) {
    return _cliqRepository.returnRTPrequest(
        CustID: params.CustID,
        MessageID: params.MessageID,
        DbtrAcct: params.DbtrAcct,
        DbtrName: params.DbtrName,
        CdtrAcct: params.CdtrAcct,
        CdtrName: params.CdtrName,
        Currency: params.Currency,
        Amount: params.Amount,
        RtrnReason: params.RtrnReason,
        RtrnAddInfo: params.RtrnAddInfo,
        IsDispute: params.IsDispute,
        DisputeRefNo: params.DisputeRefNo,
        OtpCode: params.OtpCode,
        GetToken: params.GetToken);
  }
}

class ReturnRTPrequestUsecaseParams extends Params {
  final String? CustID;
  final String? MessageID;
  final String? DbtrAcct;
  final String? DbtrName;
  final String? CdtrAcct;
  final String? CdtrName;
  final String? Currency;
  final double? Amount;
  final String? RtrnReason;
  final String? RtrnAddInfo;
  final bool IsDispute;
  final String? DisputeRefNo;
  final String? OtpCode;
  final bool GetToken;
  ReturnRTPrequestUsecaseParams({
    required this.CustID,
    required this.MessageID,
    required this.DbtrAcct,
    required this.DbtrName,
    required this.CdtrAcct,
    required this.CdtrName,
    required this.Currency,
    required this.Amount,
    required this.RtrnReason,
    required this.RtrnAddInfo,
    required this.IsDispute,
    required this.DisputeRefNo,
    required this.OtpCode,
    required this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
