class TransferResponse {
  TransferResponse({
    this.beneficiaryId,
    this.transferType,
    this.beneficiaryImage,
    this.toAmount,
    this.localEq,
    this.toAccount,
  });

  String? beneficiaryId;
  String? transferType;
  String? beneficiaryImage;
  num? toAmount;
  num? localEq;
  String? toAccount;
}
