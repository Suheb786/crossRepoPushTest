import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';
import 'package:flutter/widgets.dart';

mixin HomeAddressDialogRepository {
  Future<Either<LocalError, bool>> homeAddress({required BuildContext context});
}