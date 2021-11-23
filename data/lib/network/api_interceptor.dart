import 'package:data/network/api_service.dart';
import 'package:data/network/network_properties.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/user/user_repository.dart';

class ApiInterceptor extends InterceptorsWrapper {
  final UserRepository _userRepository;
  final Dio _previousDio;
  late ApiService apiService;
  String authToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzNzYxOTAzYy1lNTk4LTQwMjMtODA4OC00NzRhMjk0YzI3M2YiLCJKdGkiOiIwMzk2ZTI0NC01YWE3LTQ2N2YtYTJjYy0zNzU5YWYzYTdiN2IiLCJVbmlxdWUiOiIyZTkwMjgzMi02YTRjLTQ2ZTQtYjZlMS04OGRjOGQyMTc0ZjEiLCJleHAiOjE2Mzc2Njc4MjksImlzcyI6IjA6MDowOjEiLCJhdWQiOiIwOjA6MDoxIn0.n7BHNNnZZpNaPdQ9rSj2t0gIfmgwxrDuqFqUjPgofp4";

  ApiInterceptor(this._userRepository, this._previousDio) {
    Dio newDio = Dio(_previousDio.options);
    newDio.interceptors.add(_previousDio.interceptors.first);
    apiService = ApiService(newDio, baseUrl: NetworkProperties.BASE_URL);
  }

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //var userEither = await _userRepository.getCurrentUser();
    // User? user = userEither.fold((l) => null, (r) {
    //   return r;
    // });

    // options.headers.putIfAbsent("Authorization",
    //     () => "${user?.tokenType ?? "Bearer"} ${user?.token ?? ""}");

    options.headers.putIfAbsent("Authorization", () => "Bearer $authToken");
    print('authToken--->$authToken');

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      if (response.data != null) {
        if (((response.data as Map<String, dynamic>)['response']['token']
                as String)
            .isNotEmpty) {
          authToken = (response.data as Map<String, dynamic>)['response']
                  ['token'] ??
              '';
        }
      }

      super.onResponse(response, handler);
    }
  }

//
// @override
// void onError(DioError dioError, ErrorInterceptorHandler handler) async {
//   if (dioError.response?.statusCode == 401) {
//     RequestOptions? options = dioError.response!.requestOptions;
//
//     final currentUserEither = await _userRepository.getCurrentUser();
//     User? user = currentUserEither.fold((l) => null, (r) => r);
//
//     if (user == null) {
//       throw Exception();
//     }
//
//     /// Refresh Token
//     //   _previousDio.interceptors.requestLock.lock();
//     //   _previousDio.interceptors.responseLock.lock();
//     //
//     //   var refreshResponse = await safeApiCall(apiService.refreshToken(
//     //       "refresh_token",
//     //       NetworkProperties.SCOPE,
//     //       NetworkProperties.CLIENT_ID,
//     //       "token",
//     //       "${user.refreshToken}"));
//     //   Either<NetworkError, User> transformedResponse =
//     //       refreshResponse!.fold((l) => Left(l), (r) {
//     //     return Right(
//     //       r.data.transform(),
//     //     );
//     //   });
//     //   User newUser = transformedResponse.fold((l) => null, (r) => r);
//     //
//     //   if (newUser.token.isNotEmpty) {
//     //     user.token = newUser.token;
//     //     user.refreshToken = newUser.refreshToken;
//     //     user.expiredIn = newUser.expiredIn;
//     //     user.tokenType = newUser.tokenType;
//     //     await _userRepository.saveUser(user);
//     //     options.headers["Authorization"] =
//     //         "${user.tokenType ?? "Bearer"} ${user.token ?? ""}";
//     //     _previousDio.interceptors.requestLock.unlock();
//     //     _previousDio.interceptors.responseLock.unlock();
//     //
//     //     return _previousDio
//     //         .fetch(options)
//     //         .then((value) => handler.resolve(value), onError: (e) {
//     //       handler.reject(e);
//     //     });
//     //   } else {
//     //     _previousDio.interceptors.requestLock.unlock();
//     //     _previousDio.interceptors.responseLock.unlock();
//     //     return super.onError(dioError, handler);
//     //   }
//     // }
//     return handler.next(dioError);
//     //return super.onError(dioError, handler);
//   }
// }
}
