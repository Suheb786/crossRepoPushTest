class GetCardApplicationsContent {
  final String? cardId;
  final num? loanValueId;
  final bool? processLoanStep;
  final String? processLoanDate;
  final bool? issueCardOnNI;
  final String? issueCardDate;

  GetCardApplicationsContent(
      {this.cardId: "",
      this.loanValueId: 0,
      this.processLoanStep: false,
      this.processLoanDate: "",
      this.issueCardOnNI: false,
      this.issueCardDate: ""});
}
