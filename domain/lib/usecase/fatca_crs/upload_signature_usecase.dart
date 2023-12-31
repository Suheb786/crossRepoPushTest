import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadSignatureUseCase
    extends BaseUseCase<NetworkError, UploadSignatureUseCaseParams, UploadSignatureResponse> {
  final FatcaCrsRepository _repository;

  UploadSignatureUseCase(this._repository);

  @override
  Future<Either<NetworkError, UploadSignatureResponse>> execute(
      {required UploadSignatureUseCaseParams params}) {
    return _repository.uploadSignature(image: params.signature);
  }
}

class UploadSignatureUseCaseParams extends Params {
  final String signature;

  UploadSignatureUseCaseParams({
    required this.signature,
  });

  @override
  Either<AppError, bool> verify() {
    if (signature.isEmpty) {
      return Left(
          AppError(error: ErrorInfo(message: ''), type: ErrorType.INVALID_SIGNATURE, cause: Exception()));
    }
    return Right(true);
  }
}
