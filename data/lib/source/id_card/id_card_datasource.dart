import 'package:data/entity/remote/ahwal/ahwal_detail_response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class IdCardRemoteDS {
  Future<HttpResponse<AhwalDetailResponseEntity>> getAhwalDetails(
      {String idNo});
}

abstract class IdCardLocalDS {}
