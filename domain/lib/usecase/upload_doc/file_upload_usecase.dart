import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class FileUploadUseCase extends BaseUseCase<NetworkError,
    FileUploadUseCaseParams,
    FileUploadResponse> {
  final UploadDocumentRepository _repository;

  FileUploadUseCase(this._repository);

  @override
  Future<Either<NetworkError, FileUploadResponse>> execute(
      {FileUploadUseCaseParams? params}) {
    return _repository.uploadDocument(path: params!.path);
  }
}

class FileUploadUseCaseParams extends Params {
  final String path;

  FileUploadUseCaseParams({required this.path});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
