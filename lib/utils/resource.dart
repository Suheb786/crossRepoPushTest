import 'package:domain/error/app_error.dart';
import 'package:neo_bank/utils/status.dart';

class Resource<T> {
  final Status status;
  final T? data;
  final AppError? appError;

  Resource._({required this.status, this.data, this.appError});

  static Resource<T> success<T>({T? data}) {
    return Resource<T>._(status: Status.SUCCESS, data: data);
  }

  static Resource<T> error<T>({T? data, AppError? error}) {
    return Resource<T>._(status: Status.ERROR, data: data, appError: error);
  }

  static Resource<T> loading<T>({T? data}) {
    return Resource<T>._(
      data: data,
      status: Status.LOADING,
    );
  }

  static Resource<T> none<T>() {
    return Resource<T>._(
      data: null,
      status: Status.NONE,
    );
  }
}
