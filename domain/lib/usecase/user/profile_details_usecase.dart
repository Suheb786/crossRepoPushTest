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
  final String? spouseName;
  final String? natureOfNeeds;
  final String? relationShipPEP;
  final String? personName;
  final String? personRole;
  final bool isMarried;
  final bool isPerson;
  final bool isRelative;

  ProfileDetailsUseCaseParams({this.spouseName, this.natureOfNeeds, this.relationShipPEP, this.personName, this.personRole, required this.isMarried, required this.isPerson, required this.isRelative});

  @override
  Either<AppError, bool> verify() {
    //To do: change validation msg
    if (isMarried&&spouseName!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_NAME,
          cause: Exception()));
    } else if(isPerson&&natureOfNeeds!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_NATURE,
          cause: Exception()));
    } else if(isRelative) {
      if(relationShipPEP!.isEmpty){
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_RELATIONSHIP,
            cause: Exception()));
      }else if(personName!.isEmpty){
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_NAME,
            cause: Exception()));
      }else if(personRole!.isEmpty){
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_ROLE,
            cause: Exception()));
      }
    }
    //natureOfNeeds.isEmpty || relationShipPEP.isEmpty||personName.isEmpty||personRole.isEmpty
    return Right(true);
  }
}
