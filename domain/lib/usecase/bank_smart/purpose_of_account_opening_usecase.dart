import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/bank_smart/purpose_of_account_opening_response.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/bank_smart/bank_smart_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class PurposeOfAccountOpeningUseCase extends BaseUseCase<NetworkError,
    PurposeOfAccountOpeningUseCaseParams, PurposeOfAccountOpeningResponse> {
  final BankSmartRepository _bankSmartRepository;

  PurposeOfAccountOpeningUseCase(this._bankSmartRepository);

  @override
  Future<Either<NetworkError, PurposeOfAccountOpeningResponse>> execute(
      {required PurposeOfAccountOpeningUseCaseParams params}) {
    return _bankSmartRepository.addAccountPurpose(
        getToken: params.getToken!,
        purpose: params.purposeOfAccountOpening,
        annualTransaction: double.parse(params.expectedAnnualTransaction!),
        monthlyTransaction: double.parse(params.expectedMonthlyTransaction!),
        isCashDeposit: params.isCashDeposit,
        isTransfer: params.isTransfer,
        isBillPayment: params.isBillPayment,
        isOther: params.isOther);
  }
}

class PurposeOfAccountOpeningUseCaseParams extends Params {
  final bool? getToken;
  final String? purposeOfAccountOpening;
  final String? expectedMonthlyTransaction;
  final String? expectedAnnualTransaction;
  final bool? isCashDeposit;
  final bool? isTransfer;
  final bool? isBillPayment;
  final bool? isOther;
  final bool expectedTransactionSelected;

  PurposeOfAccountOpeningUseCaseParams(
      {this.getToken,
      this.purposeOfAccountOpening,
      this.expectedAnnualTransaction,
      this.expectedMonthlyTransaction,
      this.isBillPayment,
      this.isOther,
      this.isTransfer,
      this.isCashDeposit,
      required this.expectedTransactionSelected});

  @override
  Either<AppError, bool> verify() {
    if (purposeOfAccountOpening!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_PURPOSE_OF_ACCOUNT_OPENING,
          cause: Exception()));
    } else if (!expectedTransactionSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.SELECT_EXPECTED_TRANSACTION,
          cause: Exception()));
    } else if (expectedMonthlyTransaction!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EXPECTED_MONTHLY_TRANSACTION,
          cause: Exception()));
    } else if (!(num.parse(expectedMonthlyTransaction!) > 0)) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_EXPECTED_MONTHLY_TRANSACTION_VALUE,
          cause: Exception()));
    }
    // else if (expectedAnnualTransaction!.isEmpty) {
    //   return Left(AppError(
    //       error: ErrorInfo(message: ''),
    //       type: ErrorType.INVALID_EXPECTED_ANNUAL_TRANSACTION,
    //       cause: Exception()));
    // }
    return Right(true);
  }
}
