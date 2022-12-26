import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';

class CliqRepositoryImpl extends CliqRepository {
  final CliqDataSource _cliqDataSource;

  CliqRepositoryImpl(this._cliqDataSource);

  @override
  Future<Either<NetworkError, GetAlias>> getAlias({required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.getAlias(getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, RequestMoneyActivity>> requestMoneyActivity({required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.requestMoneyActivity(getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> getCliqAccountByAlias(
      {required String type,
      required String value,
      required String Currency,
      required String CustID,
      required bool GetToken}) async {
    final result = await safeApiCall(_cliqDataSource.getCliqAccountByAlias(
        CustId: CustID,
        type: type,
        Currency: Currency,
        value: value,
        GetToken: GetToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, ConfirmCreateCliqId>> confirmCreateCLidID(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required String otpCode,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.confirmCreateCLidID(
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        otpCode: otpCode,
        getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, CreateCliqOtp>> createCliqIdOtp(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.createCliqIdOtp(
        accountNumber: accountNumber, isAlias: isAlias, aliasValue: aliasValue, getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> addLinkAccount(
      {required String aliasId,
      required String linkType,
      required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.addLinkAccount(
        aliasId: aliasId,
        linkType: linkType,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> confirmChangeDefaultAccount({required bool GetToken}) async {
    final result = await safeApiCall(_cliqDataSource.confirmChangeDefaultAccount(GetToken: GetToken));

    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, EditCliq>> editCliqID(
      {required bool isAlias,
      required String aliasId,
      required String aliasValue,
      required String OtpCode,
      required bool getToken}) async {
    final result = await safeApiCall(
      _cliqDataSource.editCliqID(
          isAlias: isAlias,
          aliasId: aliasId,
          aliasValue: aliasValue,
          OtpCode: OtpCode,
          getToken: getToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> deleteCliqId({required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.deleteCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> reActivateCliqId(
      {required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.reActivateCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> suspendCliqId({required String aliasId, required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.suspendCliqId(aliasId: aliasId, getToken: getToken));
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> unLinkAccountFromCliq(
      {required String aliasId, required String accountId, required bool getToken}) async {
    final result = await safeApiCall(
        _cliqDataSource.unLinkAccountFromCliq(aliasId: aliasId, accountId: accountId, getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> requestMoney(
      {required String cliqType,
      required String iban,
      required String toAccountNo,
      required String alias,
      required String mobile,
      required String receipentName,
      required String amount,
      required String currency,
      required String rtpPurposeCode,
      required String description,
      required String beneficiaryId,
      required String toAccountHolderName,
      required String receipentAddress,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.requestMoney(
        cliqType: cliqType,
        iban: iban,
        toAccountNo: toAccountNo,
        alias: alias,
        mobile: mobile,
        receipentName: receipentName,
        amount: amount,
        currency: currency,
        rtpPurposeCode: rtpPurposeCode,
        description: description,
        beneficiaryId: beneficiaryId,
        toAccountHolderName: toAccountHolderName,
        receipentAddress: receipentAddress,
        getToken: getToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> qRCliqCode({required String code, required bool getToken}) async {
    final result = await safeApiCall(
      _cliqDataSource.qRCliqCode(code: code, getToken: getToken),
    );
    return result!.fold(
          (l) => Left(l),
          (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> sendMoneytoCliqIBAN(
      {required String otpCode,
      required String transferType,
      required String cliqType,
      required String toIban,
      required String toAccountNo,
      required String toAlias,
      required String toMobileNo,
      required String toBankCountry,
      required String swift,
      required String routingNO,
      required String recipientName,
      required String fromAccountNo,
      required String transferAmount,
      required String fromAccountCurrency,
      required String toAccountCurrency,
      required bool Charges,
      required String TransferPurposeCode,
      required String description,
      required String whenToSend,
      required String beneficiaryId,
      fromCardId,
      fromCardType,
      ownAccountTransferType,
      required String fromAccountHolderName,
      required String recipientAddress,
      required String flagAmount,
      required String flagCurrency,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.sendMoneytoCliqIBAN(
        otpCode: otpCode,
        transferType: transferType,
        cliqType: cliqType,
        toIban: toIban,
        toAccountNo: toAccountNo,
        toAlias: toAlias,
        toMobileNo: toMobileNo,
        toBankCountry: toBankCountry,
        swift: swift,
        routingNO: routingNO,
        recipientName: recipientName,
        fromAccountNo: fromAccountNo,
        transferAmount: transferAmount,
        fromAccountCurrency: fromAccountCurrency,
        toAccountCurrency: toAccountCurrency,
        Charges: Charges,
        TransferPurposeCode: TransferPurposeCode,
        description: description,
        whenToSend: whenToSend,
        beneficiaryId: beneficiaryId,
        fromAccountHolderName: fromAccountHolderName,
        recipientAddress: recipientAddress,
        flagAmount: flagAmount,
        flagCurrency: flagCurrency,
        getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> sendQRCliqPayment(
      {required String referenceLabel,
      required String merchantCategoryCode,
      required String countryCode,
      required String merchantID,
      required String merchantName,
      location,
      required String transactionAmount,
      required String city,
      required String transactionCurrency,
      required String additionalLanguageTemplate,
      verificationCode,
      required String dateTime,
      billNumber,
      mobileNumber,
      storeLabel,
      loyaltyNumber,
      customerLabel,
      terminalLabel,
      required String qrCode,
      required String crdtrBic,
      required String fromAccount,
      required String fromAccountHolderName,
      required String ValueOfConvenienceFixed,
      required String TipOrConvenienceIndicator,
      valueOfPercentageConvenience,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.sendQRCliqPayment(
        referenceLabel: referenceLabel,
        merchantCategoryCode: merchantCategoryCode,
        countryCode: countryCode,
        merchantID: merchantID,
        merchantName: merchantName,
        transactionAmount: transactionAmount,
        city: city,
        transactionCurrency: transactionCurrency,
        additionalLanguageTemplate: additionalLanguageTemplate,
        dateTime: dateTime,
        qrCode: qrCode,
        crdtrBic: crdtrBic,
        fromAccount: fromAccount,
        fromAccountHolderName: fromAccountHolderName,
        ValueOfConvenienceFixed: ValueOfConvenienceFixed,
        TipOrConvenienceIndicator: TipOrConvenienceIndicator,
        getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateRTPCliqRequest(
      {required String msgId,
      required String rejectReason,
      required String rejectAddInfo,
      required String dbtrBic,
      required String dbtrAcct,
      required String dbtrName,
      required String dbtrIsIndvl,
      required String cdtrBic,
      required String cdtrAcct,
      required String cdtrName,
      required String cdtrIsIndvl,
      required String rmtInf,
      required String ctgyPurp,
      required String amount,
      required String curr,
      required bool rtpStatus,
      required String otPcode,
      required String cdtrPstlAdr,
      required String dbtrPstlAdr,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.updateRTPCliqRequest(
        msgId: msgId,
        rejectReason: rejectReason,
        rejectAddInfo: rejectAddInfo,
        dbtrBic: dbtrBic,
        dbtrAcct: dbtrAcct,
        dbtrName: dbtrName,
        dbtrIsIndvl: dbtrIsIndvl,
        cdtrBic: cdtrBic,
        cdtrAcct: cdtrAcct,
        cdtrName: cdtrName,
        cdtrIsIndvl: cdtrIsIndvl,
        rmtInf: rmtInf,
        ctgyPurp: ctgyPurp,
        amount: amount,
        curr: curr,
        rtpStatus: rtpStatus,
        otPcode: otPcode,
        cdtrPstlAdr: cdtrPstlAdr,
        dbtrPstlAdr: dbtrPstlAdr,
        getToken: getToken));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, EditCliqOtp>> editCliqIdOtp(
      {required String aliasId,
      required bool isAlias,
      required String aliasValue,
      required bool getToken}) async {
    final result = await safeApiCall(_cliqDataSource.editCliqIdOtp(
        aliasId: aliasId, isAlias: isAlias, aliasValue: aliasValue, getToken: getToken));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }

  @override
  Future<Either<NetworkError, bool>> getCustomerByAccount(
      {required String accountCode, required String CustID, required bool GetToken}) async {
    final result = await safeApiCall(
      _cliqDataSource.getCustomerByAccount(accountCode: accountCode, CustID: CustID, GetToken: GetToken),
    );
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> requestToPayResult(
      {required String CustID,
      required String OrgnlMsgId,
      required String RTPStatus,
      required String RejectReason,
      required String RejectADdInfo}) async {
    final result = await safeApiCall(
      _cliqDataSource.requestToPayResult(
        CustID: CustID,
        OrgnlMsgId: OrgnlMsgId,
        RTPStatus: RTPStatus,
        RejectReason: RejectReason,
        RejectADdInfo: RejectADdInfo,
      ),
    );
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> getAccountByCustomerID() async {
    final result = await safeApiCall(_cliqDataSource.getAccountByCustomerID());
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> changeDefaultAccountOtp({required bool GetToken}) async {
    final result = await safeApiCall(_cliqDataSource.changeDefaultAccountOtp(GetToken: GetToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> approveRTPRequest({
    required String custID,
    required String dbtrAcct,
    required String dbtrName,
    required String dbtrPstlAdr,
    required String dbtrRecordID,
    required String dbtrAlias,
    required String currency,
    required String amount,
    required String cdtrBic,
    required String cdtrName,
    required String cdtrAcct,
    required String cdtrPstlAdr,
    required String cdtrRecordID,
    required String cdtrAlias,
    required String rgltryRptg,
    required String payRefNo,
    required String rejectReason,
    required String rejectADdInfo,
    required String rtpStatus,
    required bool GetToken,
  }) async {
    final result = await safeApiCall(_cliqDataSource.approveRTPRequest(
        custID: custID,
        dbtrAcct: dbtrAcct,
        dbtrName: dbtrName,
        dbtrPstlAdr: dbtrPstlAdr,
        dbtrRecordID: dbtrRecordID,
        dbtrAlias: dbtrAlias,
        currency: currency,
        amount: amount,
        cdtrBic: cdtrBic,
        cdtrName: cdtrName,
        cdtrAcct: cdtrAcct,
        cdtrPstlAdr: cdtrPstlAdr,
        cdtrRecordID: cdtrRecordID,
        cdtrAlias: cdtrAlias,
        rgltryRptg: rgltryRptg,
        payRefNo: payRefNo,
        rejectReason: rejectReason,
        rejectADdInfo: rejectADdInfo,
        rtpStatus: rtpStatus,
        GetToken: GetToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }

  @override
  Future<Either<NetworkError, bool>> submitOutwardPayment(
      {required String custID,
      required String dbtrAcct,
      required String dbtrName,
      required String dbtrPstlAdr,
      required String dbtrRecordID,
      required String dbtrAlias,
      required String currency,
      required String amount,
      required String purposE_CODE,
      required String cdtrBic,
      required String cdtrName,
      required String cdtrAcct,
      required String cdtrPstlAdr,
      required String cdtrRecordID,
      required String cdtrAlias,
      required String rgltryRptg,
      required String CustIDTO,
      required String DbtrIsIndvl,
      required String CdtrIsIndvl,
      required String RmtInf,
      required String QRFlag,
      required bool GetToken}) async {
    final result = await safeApiCall(_cliqDataSource.submitOutwardPayment(
        custID: custID,
        dbtrAcct: dbtrAcct,
        dbtrName: dbtrName,
        dbtrPstlAdr: dbtrPstlAdr,
        dbtrRecordID: dbtrRecordID,
        dbtrAlias: dbtrAlias,
        currency: currency,
        amount: amount,
        purposE_CODE: purposE_CODE,
        cdtrBic: cdtrBic,
        cdtrName: cdtrName,
        cdtrAcct: cdtrAcct,
        cdtrPstlAdr: cdtrPstlAdr,
        cdtrRecordID: cdtrRecordID,
        cdtrAlias: cdtrAlias,
        rgltryRptg: rgltryRptg,
        CustIDTO: CustIDTO,
        DbtrIsIndvl: DbtrIsIndvl,
        CdtrIsIndvl: CdtrIsIndvl,
        RmtInf: RmtInf,
        QRFlag: QRFlag,
        GetToken: GetToken));
    return result!.fold((l) => Left(l), (r) => Right(r.isSuccessful()));
  }
}
