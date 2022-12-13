import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SubmitOutwardPaymentUseCase
    extends BaseUseCase<NetworkError, SubmitOutwardPaymentUseCaseParamas, bool> {
  final CliqRepository _cliqRepository;

  SubmitOutwardPaymentUseCase(this._cliqRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required SubmitOutwardPaymentUseCaseParamas params}) {
    return _cliqRepository.submitOutwardPayment(
        custID: params.custID,
        dbtrAcct: params.dbtrAcct,
        dbtrName: params.dbtrName,
        dbtrPstlAdr: params.dbtrPstlAdr,
        dbtrRecordID: params.dbtrRecordID,
        dbtrAlias: params.dbtrAlias,
        currency: params.currency,
        amount: params.amount,
        purposE_CODE: params.purposE_CODE,
        cdtrBic: params.cdtrBic,
        cdtrName: params.cdtrName,
        cdtrAcct: params.cdtrAcct,
        cdtrPstlAdr: params.cdtrPstlAdr,
        cdtrRecordID: params.cdtrRecordID,
        cdtrAlias: params.cdtrAlias,
        rgltryRptg: params.rgltryRptg,
        CustIDTO: params.CustIDTO,
        DbtrIsIndvl: params.DbtrIsIndvl,
        CdtrIsIndvl: params.CdtrIsIndvl,
        RmtInf: params.RmtInf,
        QRFlag: params.QRFlag,
        GetToken: params.GetToken);
  }
}

class SubmitOutwardPaymentUseCaseParamas extends Params {
  final String custID;
  final String dbtrAcct;
  final String dbtrName;
  final String dbtrPstlAdr;
  final String dbtrRecordID;
  final String dbtrAlias;
  final String currency;
  final String amount;
  final String purposE_CODE;
  final String cdtrBic;
  final String cdtrName;
  final String cdtrAcct;
  final String cdtrPstlAdr;
  final String cdtrRecordID;
  final String cdtrAlias;
  final String rgltryRptg;
  final String CustIDTO;
  final String DbtrIsIndvl;
  final String CdtrIsIndvl;
  final String RmtInf;
  final String QRFlag;
  final bool GetToken;

  SubmitOutwardPaymentUseCaseParamas(
      this.custID,
      this.dbtrAcct,
      this.dbtrName,
      this.dbtrPstlAdr,
      this.dbtrRecordID,
      this.dbtrAlias,
      this.currency,
      this.amount,
      this.purposE_CODE,
      this.cdtrBic,
      this.cdtrName,
      this.cdtrAcct,
      this.cdtrPstlAdr,
      this.cdtrRecordID,
      this.cdtrAlias,
      this.rgltryRptg,
      this.CustIDTO,
      this.DbtrIsIndvl,
      this.CdtrIsIndvl,
      this.RmtInf,
      this.QRFlag,
      this.GetToken);

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
