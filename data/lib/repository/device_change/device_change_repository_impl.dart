import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/device_change/device_change_flow_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/change_device/change_device_repository.dart';

class DeviceChangeRepositoryImpl extends ChangeDeviceRepository {
  final ChangeDeviceRemoteDS _changeDeviceRemoteDS;

  DeviceChangeRepositoryImpl(this._changeDeviceRemoteDS);

  @override
  Future<Either<NetworkError, bool>> resendOtpDeviceChange() async {
    final result = await safeApiCall(
      _changeDeviceRemoteDS.resendOtpDeviceChange(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> sendOtpToken() async {
    final result = await safeApiCall(
      _changeDeviceRemoteDS.sendOtpToken(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> sendOtpTokenEmail() async {
    final result = await safeApiCall(
      _changeDeviceRemoteDS.sendOtpTokenEmail(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> verifyChangeDeviceOtp(
      {required String otp, required String firebaseToken}) async {
    final result = await safeApiCall(
      _changeDeviceRemoteDS.verifyChangeDeviceOtp(
          otp: otp, firebaseToken: firebaseToken),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
