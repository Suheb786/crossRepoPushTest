import 'package:domain/usecase/cliq/change_default_account_usecase.dart';
import 'package:domain/usecase/cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/get_alias_usecase.dart';
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

  //*----------------Get Alias--------------///

  PublishSubject<GetAliasUseCaseParams> _getAliasRequest = PublishSubject();
  PublishSubject<Resource<GetAlias>> _getAliasResponse = PublishSubject();

  Stream<Resource<GetAlias>> get getAliasStream => _getAliasResponse.stream;

  void getAlias(bool getToken) {
    _getAliasRequest.safeAdd(GetAliasUseCaseParams(getToken: getToken));
  }

  ///----------------Get Alias--------------///

  //*----------------Delete Cliq Id--------------///
  PublishSubject<DeleteCliqIdUseCaseParams> _deleteCliqIdRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _deleteCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get deleteCliqIdStream => _deleteCliqIdResponse.stream;

  void deleteCliqId(bool getToken, String aliasId) {
    _deleteCliqIdRequest.safeAdd(
        DeleteCliqIdUseCaseParams(aliasId: aliasId, getToken: getToken));
  }

  ///----------------Delete Cliq Id--------------///
  ///
  ///  //*----------------Change Default Cliq Id--------------///
  PublishSubject<ChangeDefaultAccountParams> _changeDefaultCliqIDRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _changeDefaultCliqIDResponse =
      PublishSubject();

  Stream<Resource<bool>> get changeDefaultCliqIdStream =>
      _changeDefaultCliqIDResponse.stream;

  void changeDefaultCliqId(bool getToken, String aliasId, String linkType,
      String otpCode, String identifier) {
    _changeDefaultCliqIDRequest.safeAdd(
      ChangeDefaultAccountParams(
          linkType: linkType,
          otpCode: otpCode,
          identifier: identifier,
          aliasId: aliasId,
          getToken: getToken),
    );
  }

  ///----------------Delete Cliq Id--------------///
  //*----------------unlick Cliq Id--------------///
  PublishSubject<UnlinkAccountFromCliqParams> _unlinkCliqIdRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _unlinkCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get unlinkCliqIdStream => _unlinkCliqIdResponse.stream;

  void unlinkCliqId(
    bool getToken,
    String aliasId,
    String accountId,
  ) {
    _unlinkCliqIdRequest.safeAdd(UnlinkAccountFromCliqParams(
      aliasId: aliasId,
      accountId: accountId,
      getToken: getToken,
    ));
  }

  ///----------------Delete Cliq Id--------------///

  CliqIdListPageViewModel(this._getAliasUsecase, this._deleteCliqIdUseCase,
      this._unlinkAccountFromCliqUseCase, this._changeDefaultAccountUseCase) {
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
