import 'package:domain/constants/error_types.dart';
import 'package:domain/model/account/available_time_slots.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/usecase/account/get_call_time_slots_usecase.dart';
import 'package:domain/usecase/register/schedule_video_call_usecase.dart';
import 'package:domain/usecase/user/check_customer_status_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleVideoCallPageViewModel extends BasePageViewModel {
  final ScheduleVideoCallUseCase _scheduleVideoCallUseCase;
  final GetCallTimeSlotsUseCase _getAvailableTimeSlotsUseCase;
  final CheckCustomerStatusUseCase _checkCustomerStatusUseCase;

  ///controllers and keys
  final TextEditingController preferredDateController = TextEditingController();
  final GlobalKey<AppTextFieldState> preferredDateKey =
      GlobalKey(debugLabel: "preferredDate");

  final TextEditingController preferredTimeController = TextEditingController();
  final GlobalKey<AppTextFieldState> preferredTimeKey =
      GlobalKey(debugLabel: "preferredTime");

  ///update preferred Date  textfield value
  void updatePreferredDateValue(String value) {
    preferredDateController.text = value;
  }

  ///update preferred Time textfield value
  void updatePreferredTime(String value) {
    preferredTimeController.text = value;
  }

  DateTime initialDate = DateTime.now();

  ///schedule Video call request subject holder
  PublishSubject<ScheduleVideoCallUseCaseParams> _scheduleVideoCallRequest =
      PublishSubject();

  ///schedule Video call response holder
  PublishSubject<Resource<bool>> _scheduleVideoCallResponse = PublishSubject();

  ///schedule Video call stream
  Stream<Resource<bool>> get scheduleVideoCallStream =>
      _scheduleVideoCallResponse.stream;

  ///all filed validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all filed validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  /// Get available time slots request
  PublishSubject<GetCallTimeSlotsUseCaseParams> _getAvailableTimeSlotsRequest =
      PublishSubject();

  /// Get available time slots request
  PublishSubject<Resource<List<AvailableTimeSlots>>>
      _getAvailableTimeSlotsResponse = PublishSubject();

  /// Timeslots holder
  Stream<Resource<List<AvailableTimeSlots>>> get availableTimeSlots =>
      _getAvailableTimeSlotsResponse.stream;

  ///User Status subject holder
  PublishSubject<CheckCustomerStatusUseCaseParams> _checkCustomerStatusRequest =
      PublishSubject();

  ///User Status response holder
  PublishSubject<Resource<CustomerStatus>> _checkCustomerStatusResponse =
      PublishSubject();

  ///User Status stream
  Stream<Resource<CustomerStatus>> get customerStatusStream =>
      _checkCustomerStatusResponse.stream;

  bool isValid() {
    bool valid = false;
    if (preferredDateController.text.isNotEmpty &&
        preferredTimeController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  ScheduleVideoCallPageViewModel(this._scheduleVideoCallUseCase,
      this._getAvailableTimeSlotsUseCase, this._checkCustomerStatusUseCase) {
    _scheduleVideoCallRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _scheduleVideoCallUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _scheduleVideoCallResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _getAvailableTimeSlotsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getAvailableTimeSlotsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAvailableTimeSlotsResponse.add(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _checkCustomerStatusRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkCustomerStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkCustomerStatusResponse.add(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_PREFERRED_DATE:
        preferredDateKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_PREFERRED_TIME:
        preferredTimeKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void validateScheduleVideoCallDetails() {
    _scheduleVideoCallRequest.safeAdd(ScheduleVideoCallUseCaseParams(
      preferredTime: preferredTimeController.text,
      preferredDate: selectedDate,
    ));
  }

  void getCustomerStatus() {
    _checkCustomerStatusRequest.safeAdd(CheckCustomerStatusUseCaseParams());
  }

  String selectedDate = "";

  void fetchAvailableTimeSlots(String date) {
    selectedDate = date;
    _getAvailableTimeSlotsRequest
        .safeAdd(GetCallTimeSlotsUseCaseParams(callDate: date));
  }

  @override
  void dispose() {
    _scheduleVideoCallRequest.close();
    _scheduleVideoCallResponse.close();
    _allFieldValidatorSubject.close();
    _getAvailableTimeSlotsRequest.close();
    _getAvailableTimeSlotsResponse.close();
    super.dispose();
  }
}
