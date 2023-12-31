import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/account/check_agent_status_usecase.dart';
import 'package:domain/usecase/account/check_doc_status_usecase.dart';
import 'package:domain/usecase/account/check_existing_call_usecase.dart';
import 'package:domain/usecase/account/check_gender_status_usecase.dart';
import 'package:domain/usecase/account/check_other_nationality_status_usecase.dart';
import 'package:domain/usecase/account/check_videocall_status_usecase.dart';
import 'package:domain/usecase/account/get_call_status_usecase.dart';
import 'package:domain/usecase/account/get_call_time_slots_usecase.dart';
import 'package:domain/usecase/account/request_call_usecase.dart';
import 'package:domain/usecase/account/send_mobile_otp_usecase.dart';
import 'package:domain/usecase/account/verify_mobile_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/schedule_call_time_dialog/schedule_call_time_dialog_viewmodel.dart';

///[CheckVideoCallStatusUseCase] provider
final checkVideoCallStatusUseCaseProvider = Provider.autoDispose<CheckVideoCallStatusUseCase>(
    (ref) => CheckVideoCallStatusUseCase(ref.read(accountRepositoryProvider)));

///[CheckOtherNationalityStatusUseCase] provider
final checkOtherNationalityStatusUseCaseProvider = Provider.autoDispose<CheckOtherNationalityStatusUseCase>(
    (ref) => CheckOtherNationalityStatusUseCase(ref.read(accountRepositoryProvider)));

///[CheckDocStatusUseCase] provider
final checkDocStatusUseCaseProvider = Provider.autoDispose<CheckDocStatusUseCase>(
    (ref) => CheckDocStatusUseCase(ref.read(accountRepositoryProvider)));

///[CheckAgentStatusUseCase] provider
final checkAgentStatusUseCaseProvider = Provider.autoDispose<CheckAgentStatusUseCase>(
    (ref) => CheckAgentStatusUseCase(ref.read(accountRepositoryProvider)));

///[CheckExistingCallUseCase] provider
final checkExistingCallUseCaseProvider = Provider.autoDispose<CheckExistingCallUseCase>(
    (ref) => CheckExistingCallUseCase(ref.read(accountRepositoryProvider)));

///[GetCallTimeSlotsUseCase] provider
final getCallTimeSlotsUseCaseProvider = Provider.autoDispose<GetCallTimeSlotsUseCase>(
    (ref) => GetCallTimeSlotsUseCase(ref.read(accountRepositoryProvider)));

///check availble agent view model provider
final checkGenderStatusUsecaseProvider = Provider.autoDispose<CheckGenderStatusUseCase>(
    (ref) => CheckGenderStatusUseCase(ref.read(accountRepositoryProvider)));

///request call view model provider
final requestCallUsecaseProvider = Provider.autoDispose<RequestCallUseCase>(
    (ref) => RequestCallUseCase(ref.read(accountRepositoryProvider)));

///request call view model provider
final getCallStatusUsecaseProvider = Provider.autoDispose<GetCallStatusUseCase>(
    (ref) => GetCallStatusUseCase(ref.read(accountRepositoryProvider)));

///schedule call time dialog view model provider
final scheduleCallTimeDialogViwModelProvider =
    ChangeNotifierProvider.autoDispose<ScheduleCallTimeViewModel>((ref) => ScheduleCallTimeViewModel());

///[SendMobileOTPUsecase] Provider
final sendMobileOTPUsecaseProvider = Provider.autoDispose<SendMobileOTPUsecase>(
    (ref) => SendMobileOTPUsecase(ref.read(accountRepositoryProvider)));

///[OnboardingVerifyMobileOtpUsecase] Provider
final onboardingVerifyMobileOtpUsecase = Provider.autoDispose<OnboardingVerifyMobileOtpUsecase>(
    (ref) => OnboardingVerifyMobileOtpUsecase(ref.read(accountRepositoryProvider)));
