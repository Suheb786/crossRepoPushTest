import 'package:dartz/dartz.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/enter_address/home_address_dialog_repository.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeAddressDialogRepositoryImpl with HomeAddressDialogRepository {
  @override
  Future<Either<LocalError, bool>> homeAddress({required BuildContext context}) {
    return Future.value(Right(true));
  }
}