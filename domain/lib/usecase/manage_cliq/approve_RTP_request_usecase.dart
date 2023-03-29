import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ApproveRTPRequestUseCase extends BaseUseCase<NetworkError, ApproveRTPRequestUseCaseParam, bool> {
  final CliqRepository _cliqRepository;

  ApproveRTPRequestUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ApproveRTPRequestUseCaseParam params}) {
    return _cliqRepository.approveRTPRequest(
      custID: params.custID,
      dbtrAcct: params.dbtrAcct,
      dbtrName: params.dbtrName,
      dbtrPstlAdr: params.dbtrPstlAdr,
      dbtrRecordID: params.dbtrRecordID,
      dbtrAlias: params.dbtrAlias,
      currency: params.currency,
      amount: params.amount,
      cdtrBic: params.cdtrBic,
      cdtrName: params.cdtrName,
      cdtrAcct: params.cdtrAcct,
      cdtrPstlAdr: params.cdtrPstlAdr,
      cdtrRecordID: params.cdtrRecordID,
      cdtrAlias: params.cdtrAlias,
      rgltryRptg: params.rgltryRptg,
      payRefNo: params.payRefNo,
      OrgnlMsgId: params.OrgnlMsgId,
      CtgyPurp: params.CtgyPurp,
      rejectReason: params.rejectReason,
      rejectADdInfo: params.rejectADdInfo,
      rtpStatus: params.rtpStatus,
      GetToken: params.GetToken,
    );
  }
}

class ApproveRTPRequestUseCaseParam extends Params {
  final String custID;
  final String dbtrAcct;
  final String dbtrName;
  final String dbtrPstlAdr;
  final String dbtrRecordID;
  final String dbtrAlias;
  final String currency;
  final String amount;
  final String cdtrBic;
  final String cdtrName;
  final String cdtrAcct;
  final String cdtrPstlAdr;
  final String cdtrRecordID;
  final String cdtrAlias;
  final String rgltryRptg;
  final String payRefNo;
  final String OrgnlMsgId;
  final String CtgyPurp;
  final String rejectReason;
  final String rejectADdInfo;
  final String rtpStatus;

  final bool GetToken;

  ApproveRTPRequestUseCaseParam(
      {required this.custID,
      required this.dbtrAcct,
      required this.dbtrName,
      required this.dbtrPstlAdr,
      required this.dbtrRecordID,
      required this.dbtrAlias,
      required this.currency,
      required this.amount,
      required this.cdtrBic,
      required this.cdtrName,
      required this.cdtrAcct,
      required this.cdtrPstlAdr,
      required this.cdtrRecordID,
      required this.cdtrAlias,
      required this.rgltryRptg,
      required this.payRefNo,
      required this.OrgnlMsgId,
      required this.CtgyPurp,
      required this.rejectReason,
      required this.rtpStatus,
      required this.rejectADdInfo,
      required this.GetToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
