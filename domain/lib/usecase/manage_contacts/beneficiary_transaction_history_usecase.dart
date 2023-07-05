import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history_response.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../repository/manage_contact/manage_contact_repository.dart';

class BeneficiaryTransactionHistoryUseCase extends BaseUseCase<BaseError,
    BeneficiaryTransactionHistoryUseCaseParams, BeneficiaryTransactionHistoryResponse> {
  final ManageContactRepository _manageContactRepository;

  BeneficiaryTransactionHistoryUseCase(this._manageContactRepository);

  @override
  Future<Either<BaseError, BeneficiaryTransactionHistoryResponse>> execute(
      {required BeneficiaryTransactionHistoryUseCaseParams params}) {
    return _manageContactRepository.beneficiaryTransactionHistory(
        filterDays: params.filterDays,
        pageNo: params.pageNo,
        beneficiaryId: params.beneficiaryId,
        transactionType: params.transactionType,
        totalRecords: params.totalRecords,
        searchText: params.searchText);
  }
}

class BeneficiaryTransactionHistoryUseCaseParams extends Params {
  final num filterDays;
  final int pageNo;
  final String beneficiaryId;
  final String transactionType;
  final String totalRecords;
  final String searchText;

  BeneficiaryTransactionHistoryUseCaseParams({
    required this.filterDays,
    required this.pageNo,
    required this.beneficiaryId,
    required this.transactionType,
    required this.totalRecords,
    required this.searchText,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
