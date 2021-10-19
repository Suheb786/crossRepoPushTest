import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/repository/enter_address/home_address_dialog_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/widgets.dart';

class HomeAddressDialogUseCase
    extends BaseUseCase<LocalError, FetchCountriesUseParams, bool> {
  final HomeAddressDialogRepository _homeAddressDialogRepository;

  HomeAddressDialogUseCase(this._homeAddressDialogRepository);

  @override
  Future<Either<LocalError, bool>> execute(
      {required FetchCountriesUseParams params}) {
    return _homeAddressDialogRepository.homeAddress(context: params.context);
  }
}

class FetchCountriesUseParams extends Params {
  final BuildContext context;

  FetchCountriesUseParams({required this.context});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
