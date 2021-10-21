import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/enter_address/home_address.dart';

mixin HomeAddressDialogRepository {
  Future<Either<LocalError, HomeAddress>> getHomeAddress(
      {required double latitude, required double longitude});
}
