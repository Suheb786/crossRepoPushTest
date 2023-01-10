import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/usecase/manage_cliq/add_link_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/confirm_change_default_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_alias_usecase.dart';
import 'package:domain/usecase/manage_cliq/re_activate_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/suspend_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/unlink_account_from_cliq_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CliqIdListPageViewModel extends BasePageViewModel {
  ///-----------------------[ Named-Constructors ]-----------------------///

  CliqIdListPageViewModel(
    this._getAliasUsecase,
    this._deleteCliqIdUseCase,
    this._unlinkAccountFromCliqUseCase,
    this._changeDefaultAccountUseCase,
    this._suspendCliqIdUseCase,
    this._reActivateCliqIdUseCase,
  ) {
    _getAliasRequest.listen((value) {
      RequestManager(value, createCall: () => _getAliasUsecase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _getAliasResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _suspandCliqIDRequest.listen((value) {
      RequestManager(value, createCall: () => _suspendCliqIdUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _suspandCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _reactivateCliqIDRequest.listen((value) {
      RequestManager(value, createCall: () => _reActivateCliqIdUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _reactivateCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _deleteCliqIdRequest.listen((value) {
      RequestManager(value, createCall: () => _deleteCliqIdUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _deleteCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    //Todo call deleteCliqId();

    _unlinkCliqIdRequest.listen((value) {
      RequestManager(value, createCall: () => _unlinkAccountFromCliqUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _unlinkCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    //Todo call unlinkCliqId();

    _changeDefaultCliqIDRequest.listen((value) {
      RequestManager(value, createCall: () => _changeDefaultAccountUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _changeDefaultCliqIDResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getAlias(true);
  }

  ///-----------------------[ Private-Instance-Variables ]-----------------------///

  //*----------------Change Default Cliq Id--------------///
  final ConfirmChangeDefaultAccountUseCase _changeDefaultAccountUseCase;
  PublishSubject<ChangeDefaultAccountParams> _changeDefaultCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _changeDefaultCliqIDResponse = PublishSubject();

  //*----------------Delete Cliq Id--------------///

  PublishSubject<DeleteCliqIdUseCaseParams> _deleteCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _deleteCliqIdResponse = PublishSubject();
  final DeleteCliqIdUseCase _deleteCliqIdUseCase;

  //*----------------Get Alias--------------///

  PublishSubject<GetAliasUseCaseParams> _getAliasRequest = PublishSubject();

  PublishSubject<Resource<GetAlias>> _getAliasResponse = PublishSubject();
  final GetAliasUsecase _getAliasUsecase;

  //*----------------reactivate Cliq ID--------------///

  final ReActivateCliqIdUseCase _reActivateCliqIdUseCase;
  PublishSubject<ReActivateCliqIdUseCaseParams> _reactivateCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _reactivateCliqIDResponse = PublishSubject();

  //*----------------Suspand Cliq ID--------------///

  PublishSubject<SuspendCliqIdUseCaseParams> _suspandCliqIDRequest = PublishSubject();

  PublishSubject<Resource<bool>> _suspandCliqIDResponse = PublishSubject();
  final SuspendCliqIdUseCase _suspendCliqIdUseCase;

  //*----------------unlick Cliq Id--------------///

  final UnlinkAccountFromCliqUseCase _unlinkAccountFromCliqUseCase;

  PublishSubject<UnlinkAccountFromCliqParams> _unlinkCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _unlinkCliqIdResponse = PublishSubject();

  ///-----------------------[ Public-Other-Methods ]-----------------------///

  Stream<Resource<GetAlias>> get getAliasStream => _getAliasResponse.stream;

  void getAlias(bool getToken) {
    _getAliasRequest.safeAdd(GetAliasUseCaseParams(getToken: getToken));
  }

  Stream<Resource<bool>> get suspandCliqIDStream => _suspandCliqIDResponse.stream;

  void suspandCliqID({required bool getToken, required String aliasId}) {
    _suspandCliqIDRequest.safeAdd(SuspendCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  Stream<Resource<bool>> get reactivateCliqIDStream => _reactivateCliqIDResponse.stream;

  void reactivatetCliqID({required bool getToken, required String aliasId}) {
    _reactivateCliqIDRequest.safeAdd(ReActivateCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  Stream<Resource<bool>> get deleteCliqIdStream => _deleteCliqIdResponse.stream;

  void deleteCliqId(bool getToken, String aliasId) {
    _deleteCliqIdRequest.safeAdd(DeleteCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  Stream<Resource<bool>> get changeDefaultCliqIdStream => _changeDefaultCliqIDResponse.stream;

  void confirmChangeDefaultCliqId({required String acc, required String aliasId}) {
    _changeDefaultCliqIDRequest.safeAdd(
      ChangeDefaultAccountParams(aliasId: aliasId, acc: acc),
    );
  }

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
}
