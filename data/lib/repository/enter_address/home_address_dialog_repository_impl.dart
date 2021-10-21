import 'package:dartz/dartz.dart';
import 'package:data/source/enter_address/home_address_dialog_ds.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/enter_address/home_address.dart';
import 'package:domain/repository/enter_address/home_address_dialog_repository.dart';

class HomeAddressDialogRepositoryImpl with HomeAddressDialogRepository {
  final HomeAddressDialogDS _homeAddressDialogDataSource;

  HomeAddressDialogRepositoryImpl(this._homeAddressDialogDataSource);

  @override
  Future<Either<LocalError, HomeAddress>> getHomeAddress(
      {required double latitude, required double longitude}) async {
    var addressResult = await _homeAddressDialogDataSource.getHomeAddress(
        latitude: latitude, longitude: longitude);
    return Right(addressResult);
  }
}
