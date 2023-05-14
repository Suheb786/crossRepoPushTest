import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:domain/constants/enum/cliq_alias_type_enum.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/usecase/manage_cliq/change_default_account_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_alias_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_otp_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/model/cliq/suspend_cliq_id/suspend_cliq_id_otp.dart';
import 'package:domain/model/cliq/delete_cliq_id/delete_cliq_id_otp.dart';
import 'package:domain/model/cliq/re_activate_cliq_id/re_activate_cliq_id_otp.dart';
import 'package:domain/model/cliq/unlink_cliq_id/unlink_cliq_id_otp.dart';
import 'package:domain/model/cliq/change_default_account/change_default_account_otp.dart';

class CliqIdListPageViewModel extends BasePageViewModel {
  String accountId = '';
  String aliasId = '';
  String aliasName = '';

  final SuspendCliqIdOtpUseCase _suspendCliqIdOtpUseCase;
  final ReActivateCliqIdOtpUseCase _reActivateCliqIdOtpUseCase;
  final DeleteCliqIdOtpUseCase _deleteCliqIdOtpUseCase;
  final UnlinkAccountFromCliqOtpUseCase _unlinkAccountFromCliqOtpUseCase;
  final ChangeDefaultAccountOtpUseCase _changeDefaultAccountOtpUseCase;
  final GetAliasUsecase _getAliasUsecase;

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

    getAlias(true);
  }

  //*----------------Get Alias--------------///

  PublishSubject<GetAliasUseCaseParams> _getAliasRequest = PublishSubject();

  PublishSubject<Resource<GetAlias>> _getAliasResponse = PublishSubject();

  Stream<Resource<GetAlias>> get getAliasStream => _getAliasResponse.stream;

  void getAlias(bool getToken) {
    _getAliasRequest.safeAdd(GetAliasUseCaseParams(getToken: getToken));
  }

  //*----------------Change Default Cliq Id otp--------------///

  PublishSubject<ChangeDefaultAccountOtpUseCaseParams> _changeDefaultCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<ChangeDefaultAccountOtp>> _changeDefaultCliqIdOtpResponse = PublishSubject();

  Stream<Resource<ChangeDefaultAccountOtp>> get changeDefaultCliqIdOtpStream =>
      _changeDefaultCliqIdOtpResponse.stream;

  void confirmChangeDefaultCliqIdOtp({required String acc, required String aliasId}) {
    _changeDefaultCliqIdOtpRequest.safeAdd(ChangeDefaultAccountOtpUseCaseParams(aliasId: aliasId, acc: acc));
  }

  //*----------------Delete Cliq Id Otp--------------///

  PublishSubject<DeleteCliqIdOtpUseCaseParams> _deleteCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<DeleteCliqIdOtp>> _deleteCliqIdOtpResponse = PublishSubject();

  Stream<Resource<DeleteCliqIdOtp>> get deleteCliqIdOtpStream => _deleteCliqIdOtpResponse.stream;

  void deleteCliqIdOtp(bool getToken, String aliasId) {
    _deleteCliqIdOtpRequest.safeAdd(DeleteCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------reactivate Cliq ID Otp--------------///

  PublishSubject<ReActivateCliqIdOtpUseCaseParams> _reactivateCliqIDOtpRequest = PublishSubject();

  PublishSubject<Resource<ReActivateCliqIdOtp>> _reactivateCliqIDOtpResponse = PublishSubject();

  Stream<Resource<ReActivateCliqIdOtp>> get reactivateCliqIDOtpStream => _reactivateCliqIDOtpResponse.stream;

  void reactivatetCliqIDOtp({required bool getToken, required String aliasId}) {
    _reactivateCliqIDOtpRequest
        .safeAdd(ReActivateCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------Suspand Cliq ID Otp--------------///

  PublishSubject<SuspendCliqIdOtpUseCaseParams> _suspandCliqIDOtpRequest = PublishSubject();

  PublishSubject<Resource<SuspendCliqIdOtp>> _suspandCliqIDOtpResponse = PublishSubject();

  Stream<Resource<SuspendCliqIdOtp>> get suspandCliqIdOtpStream => _suspandCliqIDOtpResponse.stream;

  void suspandCliqIDOtp({required bool getToken, required String aliasId}) {
    _suspandCliqIDOtpRequest.safeAdd(SuspendCliqIdOtpUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------unlick Cliq Id otp--------------///

  Stream<Resource<UnlinkCliqIdOtp>> get unlinkCliqIdOtpStream => _unlinkCliqIdOtpResponse.stream;

  PublishSubject<UnlinkAccountFromCliqOtpParams> _unlinkCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<UnlinkCliqIdOtp>> _unlinkCliqIdOtpResponse = PublishSubject();

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

  @override
  void dispose() {
    _getAliasRequest.close();
    _getAliasResponse.close();
    _suspandCliqIDOtpRequest.close();
    _suspandCliqIDOtpResponse.close();
    _reactivateCliqIDOtpRequest.close();
    _reactivateCliqIDOtpResponse.close();
    _deleteCliqIdOtpRequest.close();
    _deleteCliqIdOtpResponse.close();
    _unlinkCliqIdOtpRequest.close();
    _unlinkCliqIdOtpResponse.close();
    _changeDefaultCliqIdOtpRequest.close();
    _changeDefaultCliqIdOtpResponse.close();
    super.dispose();
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
    }
  }
}
