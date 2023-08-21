import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetPostpaidBillerListUseCase
    extends BaseUseCase<NetworkError, GetPostpaidBillerListUseCaseParams, GetPostpaidBillerListModel> {
  final BillPaymentRepository _repository;

  GetPostpaidBillerListUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetPostpaidBillerListModel>> execute(
      {required GetPostpaidBillerListUseCaseParams params}) {
    return _repository.getPostpaidBillerList(params: params);
  }
}

class GetPostpaidBillerListUseCaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
