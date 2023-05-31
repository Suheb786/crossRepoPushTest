import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class UpdateFavoriteUseCase extends BaseUseCase<NetworkError, UpdateFavoriteUseCaseParams, bool> {
  final ManageContactRepository _repository;

  UpdateFavoriteUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required UpdateFavoriteUseCaseParams params}) {
    return _repository.updateFavorite(
        beneficiaryDetailId: params.beneficiaryDetailId,
        isSendMoneyFav: params.isSendMoneyFav,
        isRequestMoneyFav: params.isRequestMoneyFav,
        userId: params.userId,
        isFromMobile: params.isFromMobile);
  }
}

class UpdateFavoriteUseCaseParams extends Params {
  final String beneficiaryDetailId;
  final bool isSendMoneyFav;
  final bool isRequestMoneyFav;
  final String userId;
  final bool isFromMobile;

  UpdateFavoriteUseCaseParams({
    required this.beneficiaryDetailId,
    required this.isSendMoneyFav,
    required this.isRequestMoneyFav,
    required this.userId,
    required this.isFromMobile,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
