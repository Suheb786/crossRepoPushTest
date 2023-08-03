import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetPrePaidCategoriesListUseCase
    extends BaseUseCase<NetworkError, GetPrePaidCategoriesListUseCaseParams, GetPrePaidCategoriesModel> {
  final BillPaymentRepository billPaymentRepository;

  GetPrePaidCategoriesListUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, GetPrePaidCategoriesModel>> execute({
    required GetPrePaidCategoriesListUseCaseParams params,
  }) {
    return billPaymentRepository.getPrePaidCategories(params: params);
  }
}

class GetPrePaidCategoriesListUseCaseParams extends Params {
  String? billerCode;
  String? serviceCode;

  GetPrePaidCategoriesListUseCaseParams({this.billerCode, this.serviceCode});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
