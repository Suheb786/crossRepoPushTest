import 'package:domain/usecase/cliq/add_link_account_usecase.dart';
import 'package:domain/usecase/cliq/confirm_change_default_account_usecase.dart';
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
  final ConfirmChangeDefaultAccountUseCase _changeDefaultAccountUseCase;
  final SuspendCliqIdUseCase _suspendCliqIdUseCase;
  final ReActivateCliqIdUseCase _reActivateCliqIdUseCase;
  final AddLInkAccountUseCase _addLInkAccountUseCase;

  //*----------------Get Alias--------------///

  PublishSubject<GetAliasUseCaseParams> _getAliasRequest = PublishSubject();
  PublishSubject<Resource<GetAlias>> _getAliasResponse = PublishSubject();

  Stream<Resource<GetAlias>> get getAliasStream => _getAliasResponse.stream;

  void getAlias(bool getToken) {
    _getAliasRequest.safeAdd(GetAliasUseCaseParams(getToken: getToken));
  }

  void aliasString() {}

  //*----------------Suspand Cliq ID--------------///

  PublishSubject<SuspendCliqIdUseCaseParams> _suspandCliqIDRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _suspandCliqIDResponse = PublishSubject();

  Stream<Resource<bool>> get suspandCliqIDStream =>
      _suspandCliqIDResponse.stream;

  void suspandCliqID({required bool getToken, required String aliasId}) {
    _suspandCliqIDRequest.safeAdd(
        SuspendCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  //*----------------reactivate Cliq ID--------------///

  PublishSubject<ReActivateCliqIdUseCaseParams> _reactivateCliqIDRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _reactivateCliqIDResponse = PublishSubject();

  Stream<Resource<bool>> get requestCliqIDStream =>
      _reactivateCliqIDResponse.stream;

  void reactivatetCliqID({required bool getToken, required String aliasId}) {
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

  void confirmChangeDefaultCliqId({
    required bool GetToken,
  }) {
    _changeDefaultCliqIDRequest.safeAdd(
      ChangeDefaultAccountParams(GetToken: GetToken),
    );
  }

//*----------------link Cliq Id--------------///
  PublishSubject<AddLinkAccountUseCaseParams> _linkCliqIdRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _linkCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get linkCliqIdStream => _linkCliqIdResponse.stream;

  void linkCliqId({
    required bool getToken,
    required String aliasId,
    required String accountId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
  }) {
    _unlinkCliqIdRequest.safeAdd(AddLinkAccountUseCaseParams(
        aliasId, linkType, accountNumber, isAlias, aliasValue, getToken));
  }

  //*----------------unlick Cliq Id--------------///
  PublishSubject<UnlinkAccountFromCliqParams> _unlinkCliqIdRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _unlinkCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get unlinkCliqIdStream => _unlinkCliqIdResponse.stream;

  unlinkCliqId({
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
      this._reActivateCliqIdUseCase,
      this._addLInkAccountUseCase) {
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

    _linkCliqIdRequest.listen((value) {
      RequestManager(value,
              createCall: () => _addLInkAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _linkCliqIdResponse.safeAdd(event);
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
