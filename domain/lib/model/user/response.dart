class Response {
  final int? code;
  final String? message;
  final String? token;
  final dynamic content;
  final String? exceptionMessage;
  final String? id;

  Response(
      {this.code,
      this.content,
      this.exceptionMessage,
      this.message,
      this.token,
      this.id});
}
