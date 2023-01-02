import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/dynamic_link/dynamic_link_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class CreateDynamicLinkUseCase extends BaseUseCase<BaseError, CreateDynamicLinkUseCaseParams, String> {
  final DynamicLinkRepository _dynamicLinkRepository;

  CreateDynamicLinkUseCase(this._dynamicLinkRepository);

  @override
  Future<Either<BaseError, String>> execute({required CreateDynamicLinkUseCaseParams params}) {
    return _dynamicLinkRepository.createDynamicLink(
        accountTitle: params.accountTitle,
        accountNo: params.accountNo,
        requestAmt: params.requestAmt,
        dateTime: params.dateTime,
        requestId: params.requestId);
  }
}

class CreateDynamicLinkUseCaseParams extends Params {
  final String accountTitle;
  final String accountNo;
  final String requestAmt;
  final String dateTime;
  final String requestId;

  CreateDynamicLinkUseCaseParams(
      {required this.accountTitle,
      required this.accountNo,
      required this.requestAmt,
      required this.dateTime,
      required this.requestId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
