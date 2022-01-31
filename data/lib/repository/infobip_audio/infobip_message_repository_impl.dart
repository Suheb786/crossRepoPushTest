import 'package:dartz/dartz.dart';
import 'package:data/di/local_module.dart';
import 'package:data/infobip_audio/infobip_message_service.dart';
import 'package:data/source/infobip_audio/infobip_message_datasource.dart';
import 'package:data/source/infobip_audio/local/infobip_message_local_datasource_implementation.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:infobip_mobilemessaging/models/UserData.dart';

class InfobipMessageRepositoryImpl extends InfobipMessageRepository {
  final InfobipMessageLocalDs _infobipMessageDs;
  final UserRepository _repository;

  InfobipMessageRepositoryImpl(this._infobipMessageDs, this._repository);

  @override
  Future<Either<NetworkError, bool>> initInfobipMessage() async {
    var infobipMessageResult = await _infobipMessageDs.initInfobipMessage();
    if (!infobipMessageResult) {
      return Left(
        NetworkError(httpError: 1501, cause: Exception(), message: ''),
      );
    } else {
      return Right(true);
    }
  }

  @override
  Future<Either<NetworkError, bool>> showChat() async {
    var infobipMessageResult = await _infobipMessageDs.showChat();
    if (!infobipMessageResult) {
      return Left(
          NetworkError(httpError: 1501, cause: Exception(), message: ''));
    } else {
      return Right(true);
    }
  }

  @override
  Future<Either<NetworkError, bool>> saveUser() async {
    return (await _repository.getCurrentUser()).fold(
        (l) => Left(
            NetworkError(httpError: 1502, cause: Exception(), message: '')),
        (user) async {
      var saveUserResult = await _infobipMessageDs.saveUser(UserData(
          firstName: user.firstName!,
          lastName: user.lastName!,
          emails: [user.email.toString()],
          phones: [user.mobile.toString()]));
      if (!saveUserResult) {
        return Left(
            NetworkError(httpError: 1501, cause: Exception(), message: ''));
      } else {
        return Right(true);
      }
    });
  }
}
