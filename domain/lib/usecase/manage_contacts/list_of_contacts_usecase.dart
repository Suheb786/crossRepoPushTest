import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ListOfContactUseCase extends BaseUseCase<NetworkError, ListOfContactUseCaseParams, bool> {
  final ManageContactRepository _repository;

  ListOfContactUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required ListOfContactUseCaseParams params}) {
    return _repository.listOfContacts(isFromMobile: params.isFromMobile);
  }
}

class ListOfContactUseCaseParams extends Params {
  final bool isFromMobile;

  ListOfContactUseCaseParams(
    this.isFromMobile,
  );

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
