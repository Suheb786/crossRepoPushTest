import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/get_bill_categories/get_bill_categories.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetBillCategoriesUseCase
    extends BaseUseCase<NetworkError, GetBillCategoriesUseCaseParams, GetBillCategories> {
  final BillPaymentRepository _repository;

  GetBillCategoriesUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetBillCategories>> execute({required GetBillCategoriesUseCaseParams params}) {
    return _repository.getBillCategories(type: params.type);
  }
}

class GetBillCategoriesUseCaseParams extends Params {
  final String type;

  GetBillCategoriesUseCaseParams({required this.type});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
