import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/dio.dart';

abstract class CliqDataSource {
  Future<HttpResponse<ResponseEntity>> editCliqID({
    required bool isAlias,
    required String aliasId,
    required String aliasValue,
    required String OtpCode,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> suspendCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> reActivateCliqId({
    required String aliasId,
    required bool getToken,
  });

  Future<HttpResponse<ResponseEntity>> deleteCliqId({
    required String aliasId,
    required bool getToken,
  });
}
