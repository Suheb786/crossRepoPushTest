import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/error/network_error.dart';

abstract class HelpCenterRepository {
  Future<Either<NetworkError, bool>> initInfobip(
      Function(InfobipCallStatusEnum) callback);

  Future<Either<NetworkError, String>> obtainToken(
      Map<String, String> parameter);

  Future<Either<NetworkError, bool>> establishCall();

  Future<Either<NetworkError, bool>> muteUnMute();

  Future<Either<NetworkError, bool>> toggleSpeaker();

  Future<Either<NetworkError, bool>> callHangUp();

  Future<Either<NetworkError, int>> getCallDuration();
}
