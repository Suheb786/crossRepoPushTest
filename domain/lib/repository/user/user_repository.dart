import 'package:dartz/dartz.dart';
import 'package:domain/error/database_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/user.dart';

abstract class UserRepository {
  /// Listen current user stream
  Future<Either<DatabaseError, Stream<User>>> listenCurrentUser();

  /// Get current user
  Future<Either<DatabaseError, User>> getCurrentUser();

  /// Save logged in user
  Future<Either<DatabaseError, User>> saveUser(User tokenUser);

  /// Logout current user
  Future<Either<DatabaseError, bool>> logoutUser();

  /// Check email is available or not
  Future<Either<NetworkError, String>> checkUserName({String? email});

  /// Login user with syste
  Future<Either<NetworkError, bool>> loginUser(
      {required String email, required String password});
}
