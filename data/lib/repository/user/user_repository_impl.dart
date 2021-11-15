import 'package:dartz/dartz.dart';
import 'package:data/db/floor/utils/safe_db_call.dart';
import 'package:data/entity/local/user_db_entity.dart';
import 'package:data/network/api_interceptor.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/repository/user/user_repository.dart';

/// user repository management class
class UserRepositoryImpl extends UserRepository {
  final UserRemoteDS _remoteDS;
  final UserLocalDS _localDS;
  final Dio _dio;

  UserRepositoryImpl(
    this._remoteDS,
    this._localDS,
    this._dio,
  ) {
    _dio.interceptors.add(ApiInterceptor(this, _dio));
  }

  @override
  Future<Either<DatabaseError, Stream<User>>> listenCurrentUser() async {
    final result = await safeDbCall(
      _localDS.listenCurrentUser(),
    );
    return result.fold(
      (l) {
        print("left error is ${l.cause}");
        return Left(l);
      },
      (r) {
        return Right(
          r.map(
            (currentUser) => currentUser!.transform(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<DatabaseError, User>> getCurrentUser() async {
    final result = await safeDbCall(
      _localDS.getCurrentUser(),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(r!.transform()),
    );
  }

  @override
  Future<Either<DatabaseError, bool>> logoutUser() async {
    final logoutUser = await safeDbCall(_localDS.removeUser());
    return logoutUser.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<DatabaseError, User>> saveUser(User tokenUser) async {
    final result = await safeDbCall(
      _localDS.saveCurrentUser(UserDBEntity().restore(tokenUser)),
    );
    return result.fold(
      (l) => Left(l),
      (r) => Right(tokenUser),
    );
  }
}
