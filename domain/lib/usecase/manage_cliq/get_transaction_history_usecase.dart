// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/usecase/base/params.dart';

class GetTransactionHistoryUseCaseParams extends Params {
  final String? FilterDays;
  final String? TransactionType;
  final String? TotalRecords;
  final bool? GetToken;
  GetTransactionHistoryUseCaseParams({
    required this.FilterDays,
    required this.TransactionType,
    required this.TotalRecords,
    required this.GetToken,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
