import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/id_card/id_card_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetAhwalDetailsUseCase
    extends BaseUseCase<NetworkError, GetAhwalDetailsUseCaseParams, String> {
  final IdCardRepository _repository;

  GetAhwalDetailsUseCase(this._repository);

  @override
  Future<Either<NetworkError, String>> execute(
      {required GetAhwalDetailsUseCaseParams params}) {
    return _repository.getAhwalDetails(idNo: params.idNo);
  }
}

class GetAhwalDetailsUseCaseParams extends Params {
  final String idNo;

  GetAhwalDetailsUseCaseParams({required this.idNo});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
