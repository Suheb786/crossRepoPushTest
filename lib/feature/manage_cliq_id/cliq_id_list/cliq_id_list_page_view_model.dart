import 'package:domain/usecase/cliq/delete_cliq_id_usecase.dart';
import 'package:domain/usecase/cliq/get_alias_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CliqIdListPageViewModel extends BasePageViewModel {
  final GetAliasUsecase _getAliasUsecase;
  final DeleteCliqIdUseCase _deleteCliqIdUseCase;

  //*----------------Get Alias--------------///

  PublishSubject<GetAliasUseCaseParams> _getAliasRequest = PublishSubject();
  PublishSubject<Resource<bool>> _getAliasResponse = PublishSubject();

  Stream<Resource<bool>> get getAliasStream => _getAliasResponse.stream;

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

  CliqIdListPageViewModel(this._getAliasUsecase, this._deleteCliqIdUseCase) {
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
  }
}
