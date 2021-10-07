import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/country/country.dart';
import 'package:flutter/widgets.dart';

mixin CountryRepository {
  Future<Either<LocalError, List<Country>>> fetchCountries(
      {required BuildContext context});
}
