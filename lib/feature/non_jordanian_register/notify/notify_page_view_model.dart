import 'package:domain/constants/error_types.dart';
import 'package:domain/model/user/register_interest/register_interest_response.dart';
import 'package:domain/usecase/notify/notify_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class NotifyPageViewModel extends BasePageViewModel {
  final NotifyUseCase _notifyUseCase;

  ///controllers and keys
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  ///notify request holder
  PublishSubject<NotifyUseCaseParams> _notifyRequest = PublishSubject();

  ///notify response holder
  PublishSubject<Resource<RegisterInterestResponse>> _notifyResponse =
  PublishSubject();

  ///notify request stream
  Stream<Resource<RegisterInterestResponse>> get notifyStream =>
      _notifyResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  NotifyPageViewModel(this._notifyUseCase) {
    _notifyRequest.listen((value) {
      RequestManager(value,
          createCall: () => _notifyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _notifyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<RegisterInterestResponse> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void notifyDetails() {
    _notifyRequest.safeAdd(NotifyUseCaseParams(
      emailAddress: emailController.text,
    ));
  }

  void validate() {
    if (emailController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _notifyRequest.close();
    _notifyResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
