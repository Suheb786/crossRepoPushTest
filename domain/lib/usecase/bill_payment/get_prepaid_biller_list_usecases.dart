import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetPrepaidBillerListUseCase extends BaseUseCase<NetworkError,
    GetPrepaidBillerListUseCaseParams, GetPrepaidBillerListModel> {
  final BillPaymentRepository _repository;

  GetPrepaidBillerListUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetPrepaidBillerListModel>> execute(
      {required GetPrepaidBillerListUseCaseParams params}) {
    return _repository.getPrepaidBillerList(params: params);
  }
}

class GetPrepaidBillerListUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
