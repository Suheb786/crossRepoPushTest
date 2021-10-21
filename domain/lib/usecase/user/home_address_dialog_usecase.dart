import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/enter_address/home_address.dart';
import 'package:domain/repository/enter_address/home_address_dialog_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class HomeAddressDialogUseCase extends BaseUseCase<LocalError,
    HomeAddressDialogUseCaseParams, HomeAddress> {
  final HomeAddressDialogRepository _homeAddressDialogRepository;

  HomeAddressDialogUseCase(this._homeAddressDialogRepository);

  @override
  Future<Either<LocalError, HomeAddress>> execute(
      {required HomeAddressDialogUseCaseParams params}) {
    return _homeAddressDialogRepository.getHomeAddress(
        latitude: params.latitude, longitude: params.longitude);
  }
}

class HomeAddressDialogUseCaseParams extends Params {
  final double latitude;
  final double longitude;

  HomeAddressDialogUseCaseParams(
      {required this.latitude, required this.longitude});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
