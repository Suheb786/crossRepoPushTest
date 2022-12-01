import 'package:domain/error/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/cliq/cliq_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:flutter/cupertino.dart';

class CreateCliqIdUseCase
    extends BaseUseCase<NetworkError, CreateCliqIdParams, bool> {
  final CliqRepository _cliqRepository;

  CreateCliqIdUseCase(this._cliqRepository);
  @override
  Future<Either<NetworkError, bool>> execute(
      {required CreateCliqIdParams params}) {
    return _cliqRepository.createCliqId(
        accountNumber: params.accountNumber,
        isAlias: params.isAlias,
        aliasValue: params.aliasValue,
        getToken: params.getToken);
  }
}

class CreateCliqIdParams extends Params {
  final String accountNumber;
  final bool isAlias;
  final String aliasValue;
  final bool getToken;

  CreateCliqIdParams(
      {required this.accountNumber,
      required this.isAlias,
      required this.aliasValue,
      required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
