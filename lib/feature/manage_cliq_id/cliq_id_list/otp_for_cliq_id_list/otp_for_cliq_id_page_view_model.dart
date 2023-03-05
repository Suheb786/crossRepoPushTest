import 'package:domain/usecase/manage_cliq/add_link_account_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/add_link_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/change_default_account_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/confirm_change_default_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/enter_otp_for_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'otp_for_cliq_id_page.dart';

class OtpForCliqIdListPageViewModel extends BasePageViewModel {
  final EnterOtpForCliqIdValidationUseCase _enterOtpForCliqIdValidationUseCase;

  final OtpForCliqIdListPageArguments arguments;
  final SuspendCliqIdUseCase _suspendCliqIdUseCase;
  final UnlinkAccountFromCliqUseCase _unlinkAccountFromCliqUseCase;
  final ReActivateCliqIdUseCase _reActivateCliqIdUseCase;
  final DeleteCliqIdUseCase _deleteCliqIdUseCase;
  final ConfirmChangeDefaultAccountUseCase _confirmChangeDefaultAccountUseCase;

  final SuspendCliqIdOtpUseCase _suspendCliqIdOtpUseCase;
  final ReActivateCliqIdOtpUseCase _reActivateCliqIdOtpUseCase;
  final DeleteCliqIdOtpUseCase _deleteCliqIdOtpUseCase;
  final UnlinkAccountFromCliqOtpUseCase _unlinkAccountFromCliqOtpUseCase;
  final ChangeDefaultAccountOtpUseCase _changeDefaultAccountOtpUseCase;
  final AddLInkAccountOtpUseCase _addLinkAccountOtpUseCase;

  final AddLInkAccountUseCase _addLInkAccountUseCase;

  OtpForCliqIdListPageViewModel(
      this._enterOtpForCliqIdValidationUseCase,
      this.arguments,
      this._suspendCliqIdUseCase,
      this._unlinkAccountFromCliqUseCase,
      this._reActivateCliqIdUseCase,
      this._deleteCliqIdUseCase,
      this._confirmChangeDefaultAccountUseCase,
      this._suspendCliqIdOtpUseCase,
      this._reActivateCliqIdOtpUseCase,
      this._deleteCliqIdOtpUseCase,
      this._unlinkAccountFromCliqOtpUseCase,
      this._changeDefaultAccountOtpUseCase,
      this._addLInkAccountUseCase,
      this._addLinkAccountOtpUseCase) {
    ///validation request
    _enterOtpForCliqIdValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _enterOtpForCliqIdValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enterOtpForCliqIdValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });

    _suspandCliqIDRequest.listen((value) {
      RequestManager(value, createCall: () => _suspendCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _suspandCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _reactivateCliqIDRequest.listen((value) {
      RequestManager(value, createCall: () => _reActivateCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reactivateCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _deleteCliqIdRequest.listen((value) {
      RequestManager(value, createCall: () => _deleteCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _deleteCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _unlinkCliqIdRequest.listen((value) {
      RequestManager(value, createCall: () => _unlinkAccountFromCliqUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _unlinkCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _changeDefaultCliqIDRequest.listen((value) {
      RequestManager(value, createCall: () => _confirmChangeDefaultAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changeDefaultCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    ///-------------------------------------api calling for resend otp--------------------------------------

    _suspandCliqIDOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _suspendCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _suspandCliqIDOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    _reactivateCliqIDOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _reActivateCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reactivateCliqIDOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    _deleteCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _deleteCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _deleteCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    _unlinkCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _unlinkAccountFromCliqOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _unlinkCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    _changeDefaultCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _changeDefaultAccountOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changeDefaultCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    _linkCliqIdRequest.listen((value) {
      RequestManager(value, createCall: () => _addLInkAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _linkCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _linkCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _addLinkAccountOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _linkCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    // _editCliqIdOtpRequest.listen((value) {
    //   RequestManager(value, createCall: () => _editCliqOtpUseCase.execute(params: value))
    //       .asFlow()
    //       .listen((event) {
    //     updateLoader();
    //     _editCliqIdOtpResponse.safeAdd(event);
    //     if (event.status == Status.ERROR) {
    //       showErrorState();
    //       showToastWithError(event.appError!);
    //     } else if (event.status == Status.SUCCESS) {
    //       updateTime();
    //     }
    //   });
    // });
  }

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  ///validation otp request

  void validateOtp() {
    _enterOtpForCliqIdValidationRequest
        .safeAdd(EnterOtpForCliqIdValidationUseCaseParams(otp: _otpSubject.value));
  }

  /// validation for i/p and btn
  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _otpSubject.safeAdd(value);
      _showButtonSubject.safeAdd(false);
    }
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  ///------------------------------------------variable--------------------------------------

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  TextEditingController otpController = TextEditingController();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///========================================== otp request validation==============================///
  PublishSubject<EnterOtpForCliqIdValidationUseCaseParams> _enterOtpForCliqIdValidationRequest =
  PublishSubject();

  PublishSubject<Resource<bool>> _enterOtpForCliqIdValidationResponse = PublishSubject();

  Stream<Resource<bool>> get enterOtpForCliqIdValidationStream => _enterOtpForCliqIdValidationResponse.stream;

  //*----------------Delete Cliq Id--------------///

  PublishSubject<DeleteCliqIdUseCaseParams> _deleteCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _deleteCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get deleteCliqIdStream => _deleteCliqIdResponse.stream;

  void deleteCliqId(bool getToken, String aliasId, String otpCode) {
    _deleteCliqIdRequest
        .safeAdd(DeleteCliqIdUseCaseParams(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
  }

  //*----------------reactivate Cliq ID--------------///

  PublishSubject<ReActivateCliqIdUseCaseParams> _reactivateCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _reactivateCliqIDResponse = PublishSubject();

  Stream<Resource<bool>> get reactivateCliqIDStream => _reactivateCliqIDResponse.stream;

  void reactivatetCliqID({required bool getToken, required String aliasId, required String otpCode}) {
    _reactivateCliqIDRequest
        .safeAdd(ReActivateCliqIdUseCaseParams(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
  }

  //*----------------Change Default Cliq Id--------------///

  PublishSubject<ChangeDefaultAccountParams> _changeDefaultCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _changeDefaultCliqIDResponse = PublishSubject();

  Stream<Resource<bool>> get changeDefaultCliqIdStream => _changeDefaultCliqIDResponse.stream;

  void confirmChangeDefaultCliqId({required String acc, required String aliasId, required String otpCode}) {
    _changeDefaultCliqIDRequest.safeAdd(
      ChangeDefaultAccountParams(aliasId: aliasId, acc: acc, otpCode: otpCode),
    );
  }

  //*----------------Suspand Cliq ID--------------///

  PublishSubject<SuspendCliqIdUseCaseParams> _suspandCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _suspandCliqIDResponse = PublishSubject();

  Stream<Resource<bool>> get suspandCliqIDStream => _suspandCliqIDResponse.stream;

  void suspandCliqID({required bool getToken, required String otpCode, required String aliasId}) {
    _suspandCliqIDRequest
        .safeAdd(SuspendCliqIdUseCaseParams(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
  }

  //*----------------unlick Cliq Id--------------///

  PublishSubject<UnlinkAccountFromCliqParams> _unlinkCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _unlinkCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get unlinkCliqIdStream => _unlinkCliqIdResponse.stream;

  unlinkCliqId({
    required bool getToken,
    required String aliasId,
    required String accountId,
    required String otpCode,
  }) {
    _unlinkCliqIdRequest.safeAdd(UnlinkAccountFromCliqParams(
      aliasId: aliasId,
      accountId: accountId,
      otpCode: otpCode,
      getToken: getToken,
    ));
  }

  ///--------------------------------Link Account-----------------------------------

  PublishSubject<AddLinkAccountUseCaseParams> _linkCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _linkCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get linkCliqIdStream => _linkCliqIdResponse.stream;

  void linkCliqId({
    required bool getToken,
    required String aliasId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
    required String otpCode,
  }) {
    _linkCliqIdRequest.safeAdd(AddLinkAccountUseCaseParams(
        linkType: linkType,
        getToken: getToken,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasId: aliasId,
        aliasValue: aliasValue,
        otpCode: otpCode));
  }

  ///==============================Resend Otp Apis===================================================///

  //*----------------Change Default Cliq Id otp--------------///

  PublishSubject<ChangeDefaultAccountOtpUseCaseParams> _changeDefaultCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _changeDefaultCliqIdOtpResponse = PublishSubject();

  Stream<Resource<bool>> get changeDefaultCliqIdOtpStream => _changeDefaultCliqIdOtpResponse.stream;

  void confirmChangeDefaultCliqIdOtp({required String acc, required String aliasId}) {
    otpController.clear();

    _changeDefaultCliqIdOtpRequest.safeAdd(ChangeDefaultAccountOtpUseCaseParams(aliasId: aliasId, acc: acc));
  }

  //*----------------Delete Cliq Id Otp--------------///

  PublishSubject<DeleteCliqIdOtpUseCaseParams> _deleteCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _deleteCliqIdOtpResponse = PublishSubject();

  Stream<Resource<bool>> get deleteCliqIdOtpStream => _deleteCliqIdOtpResponse.stream;

  void deleteCliqIdOtp(bool getToken, String aliasId) {
    otpController.clear();
    _deleteCliqIdOtpRequest.safeAdd(DeleteCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------reactivate Cliq ID Otp--------------///

  PublishSubject<ReActivateCliqIdOtpUseCaseParams> _reactivateCliqIDOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _reactivateCliqIDOtpResponse = PublishSubject();

  Stream<Resource<bool>> get reactivateCliqIDOtpStream => _reactivateCliqIDOtpResponse.stream;

  void reactivatetCliqIDOtp({required bool getToken, required String aliasId}) {
    otpController.clear();
    _reactivateCliqIDOtpRequest
        .safeAdd(ReActivateCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------Suspand Cliq ID Otp--------------///

  PublishSubject<SuspendCliqIdOtpUseCaseParams> _suspandCliqIDOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _suspandCliqIDOtpResponse = PublishSubject();

  Stream<Resource<bool>> get suspandCliqIdOtpStream => _suspandCliqIDOtpResponse.stream;

  void suspandCliqIDOtp({required bool getToken, required String aliasId}) {
    otpController.clear();

    _suspandCliqIDOtpRequest.safeAdd(SuspendCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------unlick Cliq Id otp--------------///

  Stream<Resource<bool>> get unlinkCliqIdOtpStream => _unlinkCliqIdOtpResponse.stream;

  PublishSubject<UnlinkAccountFromCliqOtpParams> _unlinkCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _unlinkCliqIdOtpResponse = PublishSubject();

  unlinkCliqIdOtp({
    required bool getToken,
    required String aliasId,
    required String accountId,
  }) {
    otpController.clear();
    _unlinkCliqIdOtpRequest.safeAdd(UnlinkAccountFromCliqOtpParams(
      aliasId: aliasId,
      accountId: accountId,
      getToken: getToken,
    ));
  }

  ///-------------------------------- Link Account Otp ------------------------------------

  PublishSubject<AddLInkAccountOtpUseCaseParams> _linkCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _linkCliqIdOtpResponse = PublishSubject();

  Stream<Resource<bool>> get linkCliqIdOtpStream => _linkCliqIdOtpResponse.stream;

  void linkCliqIdOtp({
    required bool getToken,
    required String aliasId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
  }) {
    otpController.clear();
    _linkCliqIdOtpRequest.safeAdd(AddLInkAccountOtpUseCaseParams(
      linkType: linkType,
      getToken: getToken,
      accountNumber: accountNumber,
      isAlias: isAlias,
      aliasId: aliasId,
      aliasValue: aliasValue,
    ));
  }

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    _enterOtpForCliqIdValidationRequest.close();
    _enterOtpForCliqIdValidationResponse.close();
    _deleteCliqIdRequest.close();
    _deleteCliqIdResponse.close();
    _reactivateCliqIDRequest.close();
    _reactivateCliqIDResponse.close();
    _changeDefaultCliqIDRequest.close();
    _changeDefaultCliqIDResponse.close();
    _suspandCliqIDRequest.close();
    _suspandCliqIDResponse.close();
    _unlinkCliqIdRequest.close();
    _unlinkCliqIdResponse.close();
    _changeDefaultCliqIdOtpRequest.close();
    _changeDefaultCliqIdOtpResponse.close();
    _deleteCliqIdOtpRequest.close();
    _deleteCliqIdOtpResponse.close();
    _reactivateCliqIDOtpRequest.close();
    _reactivateCliqIDOtpResponse.close();
    _suspandCliqIDOtpRequest.close();
    _suspandCliqIDOtpResponse.close();
    _unlinkCliqIdOtpRequest.close();
    _unlinkCliqIdOtpResponse.close();

    super.dispose();
  }
}
