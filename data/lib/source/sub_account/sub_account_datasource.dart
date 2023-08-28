import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/usecase/sub_account/add_account_usecase.dart';
import 'package:domain/usecase/sub_account/deactivate_sub_account_usecase.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';
import 'package:retrofit/dio.dart';

abstract class SubAccountDataSource {
  Future<HttpResponse<ResponseEntity>> deActivateSubAccount({required CloseSubAccountUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> updateNickNameSubAccount(
      {required UpdateNickNameSubAccountUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> accountToAccountTransfer(
      {required AccountToAccountTransferUseCaseParams params});
}
