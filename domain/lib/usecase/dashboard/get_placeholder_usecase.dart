import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:domain/repository/dashboard/dashboard_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetPlaceholderUseCase extends BaseUseCase<NetworkError,
    GetPlaceholderUseCaseParams, GetPlaceholderResponse> {
  final DashboardRepository _repository;

  GetPlaceholderUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetPlaceholderResponse>> execute(
      {required GetPlaceholderUseCaseParams params}) {
    return _repository.getPlaceholder(placeholderId: params.placeholderId);
  }
}

class GetPlaceholderUseCaseParams extends Params {
  final int placeholderId;

  GetPlaceholderUseCaseParams({this.placeholderId: 0});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
