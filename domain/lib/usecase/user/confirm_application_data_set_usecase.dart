import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ConfirmApplicationDataSetUseCase extends BaseUseCase<NetworkError,
    ConfirmApplicationDataSetUseCaseParams, String> {
  final UserRepository _repository;

  ConfirmApplicationDataSetUseCase(this._repository);

  @override
  Future<Either<NetworkError, String>> execute(
      {required ConfirmApplicationDataSetUseCaseParams params}) {
    return _repository.confirmApplicationDataSet(
        countryResidenceInfo: params.countryResidenceInfo,
        profileStatusInfo: params.profileStatusInfo,
        jobDetailInfo: params.jobDetailInfo,
        fatcaCrsInfo: params.fatcaCrsInfo,
        accountPurposeInfo: params.accountPurposeInfo);
  }
}

class ConfirmApplicationDataSetUseCaseParams extends Params {
  final CountryResidenceInfo countryResidenceInfo;
  final ProfileStatusInfo profileStatusInfo;
  final JobDetailInfo jobDetailInfo;
  final FatcaCrsInfo fatcaCrsInfo;
  final AccountPurposeInfo accountPurposeInfo;

  ConfirmApplicationDataSetUseCaseParams(
      {required this.countryResidenceInfo,
      required this.profileStatusInfo,
      required this.jobDetailInfo,
      required this.fatcaCrsInfo,
      required this.accountPurposeInfo});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
