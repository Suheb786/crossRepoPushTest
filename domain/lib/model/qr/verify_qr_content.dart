class VerifyQRContent {
  final String toAccount;
  final String accountHolderName;
  final String requestId;
  final String amount;

  VerifyQRContent(
      {required this.accountHolderName,
      required this.requestId,
      required this.amount,
      required this.toAccount});
}
