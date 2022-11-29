abstract class DynamicLinkDataSource {
  /// create dynamic link
  Future<String> createDynamicLink({
    required String accountTitle,
    required String accountNo,
    required String requestAmt,
    required String dateTime,
  });

  /// listen for dynamic link
  Future<Uri> initDynamicLinks();
}
