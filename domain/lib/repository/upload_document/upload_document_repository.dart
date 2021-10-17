import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/error/base_error.dart';

abstract class UploadDocumentRepository {
  Future<Either<BaseError, String>> pickUploadDocument({DocumentTypeEnum type});
}