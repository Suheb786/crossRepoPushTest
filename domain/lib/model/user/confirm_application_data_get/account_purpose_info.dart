class AccountPurposeInfo {
  final int? id;
  final String? userId;
  final String? purpose;
  final bool? isCashDeposit;
  final bool? isTransfer;
  final bool? isBillPayment;
  final bool? isOther;
  final double? monthlyTransaction;
  final double? anualTransaction;
  final DateTime? createdOn;
  final bool? isActive;

  AccountPurposeInfo({
    this.id,
    this.userId,
    this.purpose,
    this.isCashDeposit,
    this.isTransfer,
    this.isBillPayment,
    this.isOther,
    this.monthlyTransaction,
    this.anualTransaction,
    this.createdOn,
    this.isActive,
  });
}
