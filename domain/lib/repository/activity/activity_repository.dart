import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/activity/activity_response.dart';

abstract class ActivityRepository {
  Future<Either<NetworkError, ActivityResponse>> getActivity(num noOfDays, String isDebit);
}
