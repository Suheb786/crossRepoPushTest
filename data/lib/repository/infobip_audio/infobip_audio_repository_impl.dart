import 'package:dartz/dartz.dart';
import 'package:data/source/infobip_audio/infobip_audio_datasource.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';

class InfobipAudioRepositoryImpl extends HelpCenterRepository {
  final InfobipAudioDS _infobipAudioDS;

  InfobipAudioRepositoryImpl(this._infobipAudioDS);

  @override
  Future<Either<NetworkError, bool>> initInfobip(
      String applicationId, String appKey, String baseUrl,Function(String) callback) async {
    var infobipResult =
        await _infobipAudioDS.initInfobipAudio(applicationId, appKey, baseUrl,callback);
    if (!infobipResult) {
      return Left(NetworkError(
          httpError: 0,
          cause: Exception(),
          message: 'Error occurred while Initialization'));
    }else{
      return Right(true);
    }
  }

  @override
  Future<Either<NetworkError, String>> obtainToken(String identity, String displayName) async{
    var tokenDetails =
        await _infobipAudioDS.obtainToken(identity , displayName);
    if (tokenDetails == null) {
      return Left(NetworkError(
          httpError: 0,
          cause: Exception(),
          message: 'Error occurred while obtain token'));
    }else{
      return Right(tokenDetails);
    }
  }
}
