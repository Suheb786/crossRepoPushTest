class SaveProfileStatusResponseData {
  final int? code;
  final String? message;
  final String? token;
  final String? content;
  final dynamic? exceptionMessage;
  final dynamic? id;

  SaveProfileStatusResponseData(
      {this.code,
      this.content,
      this.exceptionMessage,
      this.message,
      this.token,
      this.id});
}
