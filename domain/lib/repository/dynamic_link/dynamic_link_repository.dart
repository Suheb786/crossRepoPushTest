import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';

abstract class DynamicLinkRepository {
  /// init sdk
  Future<Either<BaseError, String>> createDynamicLink({
    required String accountTitle,
    required String accountNo,
    required String requestAmt,
    required String dateTime,
    required String requestId,
  });

  /// log events
  Future<Either<BaseError, Uri>> initDynamicLinks();

  Future<Either<BaseError, String>> referDynamicLink({
    required String userPromoCode,
  });
}
