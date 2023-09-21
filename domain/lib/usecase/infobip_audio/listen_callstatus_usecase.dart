import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/repository/help_center/help_canter.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../constants/enum/infobip_call_status_enum.dart';

class ListenCallStatusUseCase extends BaseUseCase<BaseError, ListenCallStatusUseCaseParams, bool> {
  final HelpCenterRepository _helpCenterRepository;

  ListenCallStatusUseCase(this._helpCenterRepository);

  @override
  Future<Either<BaseError, bool>> execute({required ListenCallStatusUseCaseParams params}) {
    return _helpCenterRepository.listenCallStatus(params.callback);
  }
}

class ListenCallStatusUseCaseParams extends Params {
  final Function(InfobipCallStatusEnum) callback;

  ListenCallStatusUseCaseParams({required this.callback});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
