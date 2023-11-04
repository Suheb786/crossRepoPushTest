class ProcessJourney {
  final String reason;
  final bool isAllowPooling;
  final String idWiseError;
  final bool journeyInProcess;

  ProcessJourney(
      {required this.reason,
      required this.isAllowPooling,
      required this.idWiseError,
      required this.journeyInProcess});
}
