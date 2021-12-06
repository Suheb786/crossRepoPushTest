import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UploadSignatureUseCase
    extends BaseUseCase<NetworkError, UploadSignatureUseCaseParams, bool> {
  @override
  Future<Either<NetworkError, bool>> execute(
      {required UploadSignatureUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class UploadSignatureUseCaseParams extends Params {
  final String signature;
  final bool declarationSelected;
  final bool verifyInfoDeclarationSelected;

  UploadSignatureUseCaseParams(
      {required this.signature,
      required this.declarationSelected,
      required this.verifyInfoDeclarationSelected});

  @override
  Either<AppError, bool> verify() {
    if (signature.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_SIGNATURE,
          cause: Exception()));
    }else if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_DECLARATION_SELECTION,
          cause: Exception()));
    } else if (!verifyInfoDeclarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_VERIFY_INFO_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}
