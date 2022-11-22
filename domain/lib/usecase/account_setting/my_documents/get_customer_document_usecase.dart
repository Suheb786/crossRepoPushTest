import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/profile_settings/get_customer_doc/get_customer_document_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCustomerDocumentUseCase
    extends BaseUseCase<NetworkError, GetCustomerDocumentUseCaseParams, GetCustomerDocumentResponse> {
  final AccountSettingsRepository _accountSettingsRepository;

  GetCustomerDocumentUseCase(this._accountSettingsRepository);

  @override
  Future<Either<NetworkError, GetCustomerDocumentResponse>> execute(
      {required GetCustomerDocumentUseCaseParams params}) {
    return _accountSettingsRepository.getCustomerDocument(docId: params.docId);
  }
}

class GetCustomerDocumentUseCaseParams extends Params {
  final String docId;

  GetCustomerDocumentUseCaseParams({required this.docId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
