import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ProfileDetailsUseCase
    extends BaseUseCase<LocalError, ProfileDetailsUseCaseParams, bool> {
  ProfileDetailsUseCase();

  @override
  Future<Either<LocalError, bool>> execute(
      {required ProfileDetailsUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class ProfileDetailsUseCaseParams extends Params {
  final String spouseName;
  final String natureOfNeeds;
  final String relationShipPEP;
  final String personName;
  final String personRole;

  ProfileDetailsUseCaseParams({required this.spouseName, required this.natureOfNeeds, required this.relationShipPEP, required this.personName,required this.personRole});

  @override
  Either<AppError, bool> verify() {
    //To do: change validation msg
    if (spouseName.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_MOBILE,
          cause: Exception()));
    }
    //natureOfNeeds.isEmpty || relationShipPEP.isEmpty||personName.isEmpty||personRole.isEmpty
    return Right(true);
  }
}
