import 'package:data/entity/local/user_db_entity.dart';

abstract class UserRemoteDS {
  Future<String> checkUserName({String email});

  Future<String> loginUser({required String email, required String password});
}

abstract class UserLocalDS {
  Future<Stream<UserDBEntity?>> listenCurrentUser();

  Future<UserDBEntity?> getCurrentUser();

  Future<bool> removeUser();

  Future<bool> saveCurrentUser(UserDBEntity userDBEntity);
}
