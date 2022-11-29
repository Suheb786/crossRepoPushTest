import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/id_card/ahwal_details_response.dart';

abstract class IdCardRepository {
  /// get ahwal details
  Future<Either<NetworkError, AhwalDetailResponse>> getAhwalDetails({required String idNo});
}
