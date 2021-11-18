import 'package:domain/model/user/content.dart';

class Response {
  final int? code;
  final String? message;
  final String? token;
  final Content? content;
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
