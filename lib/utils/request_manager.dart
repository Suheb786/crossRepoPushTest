import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:neo_bank/utils/resource.dart';

class RequestManager<T> {
  final StreamController<Resource<T>> _resource =
      StreamController<Resource<T>>();

  RequestManager(Params params,
      {required Future<Either<BaseError, T>> Function() createCall}) {
    _resource.sink.add(Resource.loading<T>(data: null));
    params.verify().fold(
      (l) async {
        _resource.sink.add(
          Resource.error<T>(error: l, data: null),
        );
        dispose();
      },
      (r) async {
        Either<BaseError, T> response = await createCall.call();
        response.fold((l) {
          _resource.sink.add(
            Resource.error<T>(
              error: l.transform(),
            ),
          );
          dispose();
        }, (r) {
          _resource.sink.add(
            Resource.success<T>(data: r),
          );
          dispose();
        });
      },
    );
  }

  Stream<Resource<T>> asFlow() => _resource.stream;

  void dispose() {
    _resource.close();
  }
}
