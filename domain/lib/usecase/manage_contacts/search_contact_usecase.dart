import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/beneficiary_search_contact.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SearchContactUseCase
    extends BaseUseCase<NetworkError, SearchContactUseCaseParams, BeneficiarySearchContact> {
  final ManageContactRepository _repository;

  SearchContactUseCase(this._repository);

  @override
  Future<Either<NetworkError, BeneficiarySearchContact>> execute(
      {required SearchContactUseCaseParams params}) {
    return _repository.searchContact(
        searchText: params.searchText, isFromMobile: params.isFromMobile, beneType: params.beneType);
  }
}

class SearchContactUseCaseParams extends Params {
  final String searchText;
  final String beneType;

  final bool isFromMobile;

  SearchContactUseCaseParams({
    required this.searchText,
    required this.beneType,
    required this.isFromMobile,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
