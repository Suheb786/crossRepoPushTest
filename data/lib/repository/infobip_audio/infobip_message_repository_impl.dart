import 'package:dartz/dartz.dart';
import 'package:data/source/infobip_audio/infobip_message_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';

class InfobipMessageRepositoryImpl extends InfobipMessageRepository {
  final InfobipMessageLocalDs _infobipMessageDs;

  InfobipMessageRepositoryImpl(this._infobipMessageDs);

  @override
  Future<Either<NetworkError, bool>> initInfobipMessage() async {
    var infobipMessageResult = await _infobipMessageDs.initInfobipMessage();
    if (!infobipMessageResult) {
      return Left(
          NetworkError(httpError: 1501, cause: Exception(), message: ''));
    } else {
      return Right(true);
    }
  }
}
