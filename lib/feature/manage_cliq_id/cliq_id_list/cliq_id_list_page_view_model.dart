import 'package:domain/usecase/cliq/change_default_account_usecase.dart';
import 'package:domain/usecase/cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/get_alias_usecase.dart';
import 'package:domain/usecase/cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/unlink_account_from_cliq_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';

class CliqIdListPageViewModel extends BasePageViewModel {
  final GetAliasUsecase _getAliasUsecase;
  final DeleteCliqIdUseCase _deleteCliqIdUseCase;
  final UnlinkAccountFromCliqUseCase _unlinkAccountFromCliqUseCase;
  final ChangeDefaultAccountUseCase _changeDefaultAccountUseCase;
  final SuspendCliqIdUseCase _suspendCliqIdUseCase;
  final ReActivateCliqIdUseCase _reActivateCliqIdUseCase;

  //*----------------Get Alias--------------///

  PublishSubject<GetAliasUseCaseParams> _getAliasRequest = PublishSubject();
  PublishSubject<Resource<GetAlias>> _getAliasResponse = PublishSubject();

  Stream<Resource<GetAlias>> get getAliasStream => _getAliasResponse.stream;

  void getAlias(bool getToken) {
    _getAliasRequest.safeAdd(GetAliasUseCaseParams(getToken: getToken));
  }

  //*----------------Suspand Cliq ID--------------///

  PublishSubject<SuspendCliqIdUseCaseParams> _suspandCliqIDRequest =
      PublishSubject();
  PublishSubject<Resource<GetAlias>> _suspandCliqIDResponse = PublishSubject();

  Stream<Resource<GetAlias>> get suspandCliqIDStream =>
      _suspandCliqIDResponse.stream;

  void suspandCliqID({required bool getToken, required String aliasId}) {
    _suspandCliqIDRequest.safeAdd(
        SuspendCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------reactivate Cliq ID--------------///

  PublishSubject<ReActivateCliqIdUseCaseParams> _reactivateCliqIDRequest =
      PublishSubject();
  PublishSubject<Resource<GetAlias>> _reactivateCliqIDResponse =
      PublishSubject();

  Stream<Resource<GetAlias>> get requestCliqIDStream =>
      _reactivateCliqIDResponse.stream;

  void requestCliqID({required bool getToken, required String aliasId}) {
    _reactivateCliqIDRequest.safeAdd(
        ReActivateCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------Delete Cliq Id--------------///
  PublishSubject<DeleteCliqIdUseCaseParams> _deleteCliqIdRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _deleteCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get deleteCliqIdStream => _deleteCliqIdResponse.stream;

  void deleteCliqId(bool getToken, String aliasId) {
    _deleteCliqIdRequest.safeAdd(
        DeleteCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------Change Default Cliq Id--------------///
  PublishSubject<ChangeDefaultAccountParams> _changeDefaultCliqIDRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _changeDefaultCliqIDResponse =
      PublishSubject();

  Stream<Resource<bool>> get changeDefaultCliqIdStream =>
      _changeDefaultCliqIDResponse.stream;

  void changeDefaultCliqId(
      {required bool getToken,
      required String aliasId,
      required String linkType,
      required String otpCode,
      required String identifier}) {
    _changeDefaultCliqIDRequest.safeAdd(
      ChangeDefaultAccountParams(
          linkType: linkType,
          otpCode: otpCode,
          identifier: identifier,
          aliasId: aliasId,
          getToken: getToken),
    );
  }

  //*----------------unlick Cliq Id--------------///
  PublishSubject<UnlinkAccountFromCliqParams> _unlinkCliqIdRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _unlinkCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get unlinkCliqIdStream => _unlinkCliqIdResponse.stream;

  void unlinkCliqId({
    required bool getToken,
    required String aliasId,
    required String accountId,
  }) {
    _unlinkCliqIdRequest.safeAdd(UnlinkAccountFromCliqParams(
      aliasId: aliasId,
      accountId: accountId,
      getToken: getToken,
    ));
  }

  CliqIdListPageViewModel(
      this._getAliasUsecase,
      this._deleteCliqIdUseCase,
      this._unlinkAccountFromCliqUseCase,
      this._changeDefaultAccountUseCase,
      this._suspendCliqIdUseCase,
      this._reActivateCliqIdUseCase) {
    _getAliasRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getAliasUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAliasResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _suspandCliqIDRequest.listen((value) {
      RequestManager(value,
              createCall: () => _suspendCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _suspandCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _reactivateCliqIDRequest.listen((value) {
      RequestManager(value,
              createCall: () => _reActivateCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reactivateCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _deleteCliqIdRequest.listen((value) {
      RequestManager(value,
              createCall: () => _deleteCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _deleteCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    //Todo call deleteCliqId();

    _unlinkCliqIdRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _unlinkAccountFromCliqUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _unlinkCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    //Todo call unlinkCliqId();

    _changeDefaultCliqIDRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _changeDefaultAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changeDefaultCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }
}
