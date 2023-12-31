import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/cliq_list_action_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class LinkBankAccountCliqIdValidationUseCase
    extends BaseUseCase<BaseError, LinkBankAccountCliqIdValidationUseCaseParams, bool> {
  @override
  Future<Either<BaseError, bool>> execute(
      {required LinkBankAccountCliqIdValidationUseCaseParams params}) async {
    return Future.value(Right(true));
  }
}

class LinkBankAccountCliqIdValidationUseCaseParams extends Params {
  final bool isSelected;
  final Account? selectedAccount;
  final CliqListActionTypeEnum cliqListActionTypeEnum;

  LinkBankAccountCliqIdValidationUseCaseParams(
      {required this.isSelected, required this.selectedAccount, required this.cliqListActionTypeEnum});

  @override
  Either<AppError, bool> verify() {
    switch (cliqListActionTypeEnum) {
      case CliqListActionTypeEnum.LINKACCOUNT:
        if ((selectedAccount?.accountNo ?? '').isEmpty) {
          return Left(AppError(
              error: ErrorInfo(message: ''), type: ErrorType.PLEASE_ADD_LINK_ACCOUNT, cause: Exception()));
        } else if (isSelected == false) {
          return Left(AppError(
              error: ErrorInfo(message: ''),
              type: ErrorType.AGREE_TO_THE_TERM_AND_CONDITION,
              cause: Exception()));
        }
        break;
      default:
        if (isSelected == false) {
          return Left(AppError(
              error: ErrorInfo(message: ''),
              type: ErrorType.AGREE_TO_THE_TERM_AND_CONDITION,
              cause: Exception()));
        }
    }
    return Right(true);
  }
}
