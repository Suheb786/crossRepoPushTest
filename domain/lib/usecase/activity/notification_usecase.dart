import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/activity/activity_response.dart';
import 'package:domain/repository/activity/activity_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class NotificationUseCase extends BaseUseCase<NetworkError,
    NotificationUseCaseParams, ActivityResponse> {
  final ActivityRepository _repository;

  NotificationUseCase(this._repository);

  @override
  Future<Either<NetworkError, ActivityResponse>> execute(
      {required NotificationUseCaseParams params}) {
    return Future.value(
        _repository.getActivity(params.noOfDays!, params.isDebit!));
  }
}

class NotificationUseCaseParams extends Params {
  final num? noOfDays;
  final String? isDebit;

  NotificationUseCaseParams({this.noOfDays: 90, this.isDebit: "true"});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
