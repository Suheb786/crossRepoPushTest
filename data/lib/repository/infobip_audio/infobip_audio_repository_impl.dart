import 'package:dartz/dartz.dart';
import 'package:data/source/infobip_audio/infobip_audio_datasource.dart';
import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';

class InfobipAudioRepositoryImpl extends HelpCenterRepository {
  final InfobipAudioLocalDs _infobipAudioDS;

  InfobipAudioRepositoryImpl(this._infobipAudioDS);

  @override
  Future<Either<NetworkError, bool>> initInfobip(
      Function(InfobipCallStatusEnum) callback) async {
    var infobipResult = await _infobipAudioDS.initInfobipAudio(callback);
    if (!infobipResult) {
      return Left(
          NetworkError(httpError: 1501, cause: Exception(), message: ''));
    } else {
      return Right(true);
    }
  }

  @override
  Future<Either<NetworkError, String>> obtainToken(
      ObtainToken parameter) async {
    var tokenDetails = await _infobipAudioDS.obtainToken(parameter);
    if (tokenDetails == null) {
      return Left(
          NetworkError(httpError: 1502, cause: Exception(), message: ''));
    } else {
      return Right(tokenDetails);
    }
  }

  @override
  Future<Either<NetworkError, bool>> establishCall() async {
    var result = await _infobipAudioDS.establishCall();
    if (!result) {
      return Left(
          NetworkError(httpError: 1503, cause: Exception(), message: ''));
    } else {
      return Right(true);
    }
  }

  @override
  Future<Either<NetworkError, bool>> muteUnMute() async {
    var result = await _infobipAudioDS.toggleMute();
    return Right(result);
  }

  @override
  Future<Either<NetworkError, bool>> toggleSpeaker() async {
    var result = await _infobipAudioDS.toggleSpeaker();
    return Right(result);
  }

  @override
  Future<Either<NetworkError, bool>> callHangUp() async {
    var result = await _infobipAudioDS.callHangUp();
    if (!result) {
      return Left(
          NetworkError(httpError: 1500, cause: Exception(), message: ''));
    } else {
      return Right(true);
    }
  }

  @override
  Future<Either<NetworkError, int>> getCallDuration() async {
    var result = await _infobipAudioDS.getCallDuration();
    if (result == null) {
      return Left(
          NetworkError(httpError: 1504, cause: Exception(), message: ''));
    } else {
      return Right(result);
    }
  }
}
