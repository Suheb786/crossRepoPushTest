import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class BeneficiaryMarkFavoriteUseCase
    extends BaseUseCase<NetworkError, BeneficiaryMarkFavoriteUseCaseParams, bool> {
  final ManageContactRepository _repository;

  BeneficiaryMarkFavoriteUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required BeneficiaryMarkFavoriteUseCaseParams params}) {
    return _repository.beneficiaryMarkFavorite(
        beneficiaryDetailId: params.beneficiaryDetailId,
        isFavorite: params.isFavorite,
        userId: params.userId,
        isFromMobile: params.isFromMobile,
        beneType: params.beneType);
  }
}

class BeneficiaryMarkFavoriteUseCaseParams extends Params {
  final String beneficiaryDetailId;
  final bool isFavorite;
  final String userId;
  final bool isFromMobile;
  final String beneType;

  BeneficiaryMarkFavoriteUseCaseParams({
    required this.beneficiaryDetailId,
    required this.isFavorite,
    required this.userId,
    required this.isFromMobile,
    required this.beneType,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
