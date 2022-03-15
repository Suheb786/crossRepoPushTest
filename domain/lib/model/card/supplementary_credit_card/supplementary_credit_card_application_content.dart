class SupplementaryCreditCardApplicationContent {
  final String? createdDate;
  final String? primaryCardId;
  final String? supCardId;
  final bool? step1;
  final String? issueCardDate;
  final bool? step2;
  final bool? step3;
  final int? contactLessError;
  final int? aramexError;

  SupplementaryCreditCardApplicationContent(
      {this.createdDate,
      this.primaryCardId,
      this.supCardId,
      this.step1,
      this.issueCardDate,
      this.step2,
      this.step3,
      this.contactLessError,
      this.aramexError});
}
