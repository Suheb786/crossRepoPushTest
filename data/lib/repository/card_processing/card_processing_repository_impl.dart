import 'package:dartz/dartz.dart';
import 'package:data/source/card_processing/card_processing_data_source.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/card_processing/card_processing_repository.dart';

class CardProcessingRepositoryImpl with CardProcessingRepository {
  final CardProcessingLocalDs _cardProcessingLocalDS;

  CardProcessingRepositoryImpl(this._cardProcessingLocalDS);

  @override
  Future<Either<LocalError, String>> decryptCard(
      {required String cardNo}) async {
    final value = _cardProcessingLocalDS.decryptCard(cardNo: cardNo);

    if (value.trim().isNotEmpty) {
      return Right(value);
    }

    return Left(LocalError(
        message: "No Data Found",
        cause: Exception("No Data Found"),
        localError: 1212));
  }

  @override
  Future<Either<LocalError, String>> generateBlockPin(
      {required String cardNo}) async {
    final value = _cardProcessingLocalDS.generateBlockPin(cardNo: cardNo);

    if (value.trim().isNotEmpty) {
      return Right(value);
    }

    return Left(LocalError(
        message: "No Data Found",
        cause: Exception("No Data Found"),
        localError: 1212));
  }
}
