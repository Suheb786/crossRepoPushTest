class GetCardApplicationsContent {
  final String? cardId;
  final num? loanValueId;
  final bool? processLoanStep;
  final String? processLoanDate;
  final bool? issueCardOnNI;
  final String? issueCardDate;
  final bool? finalStep;
  final int? contactLessError;
  final int? linkCardError;
  final int? crifError;
  final int? manageSOError;
  final int? aramexError;

  GetCardApplicationsContent(
      {this.cardId: "",
      this.loanValueId: 0,
      this.processLoanStep: false,
      this.processLoanDate: "",
      this.issueCardOnNI: false,
      this.issueCardDate: "",
      this.finalStep: false,
      this.aramexError: 0,
      this.manageSOError: 0,
      this.crifError: 0,
      this.linkCardError: 0,
      this.contactLessError: 0});
}
