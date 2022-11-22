import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/activity/activity_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/activity/activity_response.dart';
import 'package:domain/repository/activity/activity_repository.dart';

class ActivityRepositoryImpl extends ActivityRepository {
  final ActivityRemoteDs activityRemoteDs;

  ActivityRepositoryImpl(this.activityRemoteDs);

  @override
  Future<Either<NetworkError, ActivityResponse>> getActivity(num noOfDys, String isDebit) async {
    final result = await safeApiCall(
      activityRemoteDs.getActivity(noOfDys, isDebit),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
