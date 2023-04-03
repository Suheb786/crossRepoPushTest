// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/usecase/base/params.dart';

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
