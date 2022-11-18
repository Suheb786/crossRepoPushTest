import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';
import 'package:domain/repository/bill_payment/bill_payment_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetBillerLookupUseCase extends BaseUseCase<NetworkError,
    GetBillerLookupUseCaseParams, GetBillerLookUpList> {
  final BillPaymentRepository billPaymentRepository;

  GetBillerLookupUseCase(this.billPaymentRepository);

  @override
  Future<Either<NetworkError, GetBillerLookUpList>> execute({
    required GetBillerLookupUseCaseParams params,
  }) {
    return billPaymentRepository.getBillerLookuplist(params: params);
  }
}

class GetBillerLookupUseCaseParams extends Params {
  String? categoryName;

  GetBillerLookupUseCaseParams({
    this.categoryName,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
