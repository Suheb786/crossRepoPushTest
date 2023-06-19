import 'package:dartz/dartz.dart';
import 'package:data/source/infobip_audio/infobip_message_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/help_center/infobip_message_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:infobip_mobilemessaging/models/user_data.dart';

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
      return Left(NetworkError(httpError: 1501, cause: Exception(), message: ''));
    } else {
      return Right(true);
    }
  }

  @override
  Future<Either<NetworkError, bool>> saveUser() async {
    return (await _repository.getCurrentUser())
        .fold((l) => Left(NetworkError(httpError: 1502, cause: Exception(), message: '')), (user) async {
      debugPrint("USER CIF NUMBER " + user.cifNumber.toString());
      debugPrint("EMAIL " + user.email.toString());
      debugPrint("MOBILE NUMBER " + user.mobileCode.toString() + user.mobile.toString());
      var saveUserResult = await _infobipMessageDs.saveUser(UserData(
          firstName: user.firstName!,
          lastName: user.lastName!,
          externalUserId: user.cifNumber,
          emails: [
            user.email.toString()
          ],
          customAttributes: {
            "accountNumber": user.accountNumber.toString()
          },
          phones: [
            (user.mobileCode!.contains("00")
                    ? user.mobileCode!.replaceAll("00", "").toString()
                    : user.mobileCode!.toString()) +
                user.mobile.toString()
          ]));
      if (!saveUserResult) {
        return Left(NetworkError(httpError: 1501, cause: Exception(), message: ''));
      } else {
        return Right(true);
      }
    });
  }

  @override
  Future<Either<NetworkError, bool>> depersonalizeUser() async {
    var depersonalizeUserResult = await _infobipMessageDs.depersonalizeUser();
    if (!depersonalizeUserResult) {
      return Left(NetworkError(httpError: 1501, cause: Exception(), message: ''));
    } else {
      return Right(true);
    }
  }
}
