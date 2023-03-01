import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:domain/constants/enum/cliq_alias_type_enum.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/usecase/manage_cliq/confirm_change_default_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_alias_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/change_default_account_otp_usecase.dart';

class CliqIdListPageViewModel extends BasePageViewModel {
  final SuspendCliqIdOtpUseCase _suspendCliqIdOtpUseCase;
  final ReActivateCliqIdOtpUseCase _reActivateCliqIdOtpUseCase;
  final DeleteCliqIdOtpUseCase _deleteCliqIdOtpUseCase;
  final UnlinkAccountFromCliqOtpUseCase _unlinkAccountFromCliqOtpUseCase;
  final ChangeDefaultAccountOtpUseCase _changeDefaultAccountOtpUseCase;

  ///-----------------------[ Named-Constructors ]-----------------------///

  CliqIdListPageViewModel(
    this._getAliasUsecase,
    this._deleteCliqIdOtpUseCase,
    this._unlinkAccountFromCliqOtpUseCase,
    this._changeDefaultAccountOtpUseCase,
    this._suspendCliqIdOtpUseCase,
    this._reActivateCliqIdOtpUseCase,
  ) {
    _getAliasRequest.listen((value) {
      RequestManager(value, createCall: () => _getAliasUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAliasResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _suspandCliqIDOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _suspendCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _suspandCliqIDOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    /* _suspandCliqIDRequest.listen((value) {
      RequestManager(value, createCall: () => _suspendCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _suspandCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          suspendedCliq = '';
          showToastWithError(event.appError!);
        }
      });
    });*/

    _reactivateCliqIDOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _reActivateCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reactivateCliqIDOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    // _reactivateCliqIDRequest.listen((value) {
    //   RequestManager(value, createCall: () => _reActivateCliqIdUseCase.execute(params: value))
    //       .asFlow()
    //       .listen((event) {
    //     updateLoader();
    //     _reactivateCliqIDResponse.safeAdd(event);
    //     if (event.status == Status.ERROR) {
    //       activatedCliq = '';
    //       showToastWithError(event.appError!);
    //     }
    //   });
    // });

    _deleteCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _deleteCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _deleteCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          //  deletedCliq = '';
          showToastWithError(event.appError!);
        }
      });
    });

    // _deleteCliqIdRequest.listen((value) {
    //   RequestManager(value, createCall: () => _deleteCliqIdUseCase.execute(params: value))
    //       .asFlow()
    //       .listen((event) {
    //     updateLoader();
    //     _deleteCliqIdResponse.safeAdd(event);
    //     if (event.status == Status.ERROR) {
    //       deletedCliq = '';
    //       showToastWithError(event.appError!);
    //     }
    //   });
    // });

    _unlinkCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _unlinkAccountFromCliqOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _unlinkCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    // _unlinkCliqIdRequest.listen((value) {
    //   RequestManager(value, createCall: () => _unlinkAccountFromCliqUseCase.execute(params: value))
    //       .asFlow()
    //       .listen((event) {
    //     updateLoader();
    //     _unlinkCliqIdResponse.safeAdd(event);
    //     if (event.status == Status.ERROR) {
    //       showToastWithError(event.appError!);
    //     }
    //   });
    // });

    _changeDefaultCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _changeDefaultAccountOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changeDefaultCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    // _changeDefaultCliqIDRequest.listen((value) {
    //   RequestManager(value, createCall: () => _changeDefaultAccountUseCase.execute(params: value))
    //       .asFlow()
    //       .listen((event) {
    //     updateLoader();
    //     _changeDefaultCliqIDResponse.safeAdd(event);
    //     if (event.status == Status.ERROR) {
    //       showToastWithError(event.appError!);
    //     }
    //   });
    // });

    getAlias(true);
  }

  String suspendedCliq = "";
  String deletedCliq = "";
  String activatedCliq = "";

  ///-----------------------[ Private-Instance-Variables ]-----------------------///

  //*----------------Change Default Cliq Id--------------///

  PublishSubject<ChangeDefaultAccountParams> _changeDefaultCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _changeDefaultCliqIDResponse = PublishSubject();

  //*----------------Change Default Cliq Id otp--------------///

  PublishSubject<ChangeDefaultAccountOtpUseCaseParams> _changeDefaultCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _changeDefaultCliqIdOtpResponse = PublishSubject();

  Stream<Resource<bool>> get changeDefaultCliqIdOtpStream => _changeDefaultCliqIdOtpResponse.stream;

  void confirmChangeDefaultCliqIdOtp({required String acc, required String aliasId}) {
    _changeDefaultCliqIdOtpRequest.safeAdd(ChangeDefaultAccountOtpUseCaseParams(aliasId: aliasId, acc: acc));
  }

  //*----------------Delete Cliq Id--------------///

  PublishSubject<DeleteCliqIdUseCaseParams> _deleteCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _deleteCliqIdResponse = PublishSubject();

  //*----------------Delete Cliq Id Otp--------------///

  PublishSubject<DeleteCliqIdOtpUseCaseParams> _deleteCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _deleteCliqIdOtpResponse = PublishSubject();

  Stream<Resource<bool>> get deleteCliqIdOtpStream => _deleteCliqIdOtpResponse.stream;

  void deleteCliqIdOtp(bool getToken, String aliasId) {
    _deleteCliqIdOtpRequest.safeAdd(DeleteCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------Get Alias--------------///

  PublishSubject<GetAliasUseCaseParams> _getAliasRequest = PublishSubject();

  PublishSubject<Resource<GetAlias>> _getAliasResponse = PublishSubject();
  final GetAliasUsecase _getAliasUsecase;

  //*----------------reactivate Cliq ID--------------///

  PublishSubject<ReActivateCliqIdUseCaseParams> _reactivateCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _reactivateCliqIDResponse = PublishSubject();

  //*----------------reactivate Cliq ID Otp--------------///

  PublishSubject<ReActivateCliqIdOtpUseCaseParams> _reactivateCliqIDOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _reactivateCliqIDOtpResponse = PublishSubject();

  Stream<Resource<bool>> get reactivateCliqIDOtpStream => _reactivateCliqIDOtpResponse.stream;

  void reactivatetCliqIDOtp({required bool getToken, required String aliasId}) {
    _reactivateCliqIDOtpRequest
        .safeAdd(ReActivateCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------Suspand Cliq ID--------------///

  PublishSubject<SuspendCliqIdUseCaseParams> _suspandCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _suspandCliqIDResponse = PublishSubject();

//  final SuspendCliqIdUseCase _suspendCliqIdUseCase;

  //*----------------Suspand Cliq ID Otp--------------///

  PublishSubject<SuspendCliqIdOtpUseCaseParams> _suspandCliqIDOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _suspandCliqIDOtpResponse = PublishSubject();

  Stream<Resource<bool>> get suspandCliqIdOtpStream => _suspandCliqIDOtpResponse.stream;

  void suspandCliqIDOtp({required bool getToken, required String aliasId}) {
    _suspandCliqIDOtpRequest.safeAdd(SuspendCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------unlick Cliq Id--------------///

  //final UnlinkAccountFromCliqUseCase _unlinkAccountFromCliqUseCase;

  PublishSubject<UnlinkAccountFromCliqParams> _unlinkCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _unlinkCliqIdResponse = PublishSubject();

  //*----------------unlick Cliq Id otp--------------///

  Stream<Resource<bool>> get unlinkCliqIdOtpStream => _unlinkCliqIdOtpResponse.stream;

  PublishSubject<UnlinkAccountFromCliqOtpParams> _unlinkCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _unlinkCliqIdOtpResponse = PublishSubject();
  String accountId = '';

  unlinkCliqIdOtp({
    required bool getToken,
    required String aliasId,
    required String accountId,
  }) {
    _unlinkCliqIdOtpRequest.safeAdd(UnlinkAccountFromCliqOtpParams(
      aliasId: aliasId,
      accountId: accountId,
      getToken: getToken,
    ));
  }

  ///-----------------------[ Public-Other-Methods ]-----------------------///

  Stream<Resource<GetAlias>> get getAliasStream => _getAliasResponse.stream;

  void getAlias(bool getToken) {
    _getAliasRequest.safeAdd(GetAliasUseCaseParams(getToken: getToken));
  }

  Stream<Resource<bool>> get suspandCliqIDStream => _suspandCliqIDResponse.stream;

  void suspandCliqID({required bool getToken, required String otpCode, required String aliasId}) {
    _suspandCliqIDRequest
        .safeAdd(SuspendCliqIdUseCaseParams(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
  }

  Stream<Resource<bool>> get reactivateCliqIDStream => _reactivateCliqIDResponse.stream;

  void reactivatetCliqID({required bool getToken, required String aliasId, required String otpCode}) {
    _reactivateCliqIDRequest
        .safeAdd(ReActivateCliqIdUseCaseParams(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
  }

  // Stream<Resource<bool>> get deleteCliqIdStream => _deleteCliqIdResponse.stream;

  void deleteCliqId(bool getToken, String aliasId, String otpCode) {
    _deleteCliqIdRequest
        .safeAdd(DeleteCliqIdUseCaseParams(aliasId: aliasId, otpCode: otpCode, getToken: getToken));
  }

  Stream<Resource<bool>> get changeDefaultCliqIdStream => _changeDefaultCliqIDResponse.stream;

  void confirmChangeDefaultCliqId({required String acc, required String aliasId, required String otpCode}) {
    _changeDefaultCliqIDRequest.safeAdd(
      ChangeDefaultAccountParams(aliasId: aliasId, acc: acc, otpCode: otpCode),
    );
  }

  Stream<Resource<bool>> get unlinkCliqIdStream => _unlinkCliqIdResponse.stream;

  String getStatus(CliqAliasIdStatusEnum? statusType, BuildContext context) {
    switch (statusType) {
      case CliqAliasIdStatusEnum.ACTIVE:
        return S.of(context).active;
      case CliqAliasIdStatusEnum.SUSPEND:
        return S.of(context).suspended;
      default:
        return "";
    }
  }

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
}

extension CliqAliasTypeStringExt on CliqAliasTypeEnum {
  String fromCliqAliasString() {
    switch (this) {
      case CliqAliasTypeEnum.ALIAS:
        return S.current.alias;
      case CliqAliasTypeEnum.MOBL:
        return S.current.mobileNumber;

      default:
        return S.current.alias;
        ;
    }
  }
}
