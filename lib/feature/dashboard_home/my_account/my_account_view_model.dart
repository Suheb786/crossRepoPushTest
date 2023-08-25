import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/resource.dart';
import '../../../utils/status.dart';

class MyAccountViewModel extends BasePageViewModel {
  final UpdateNickNameSubAccountUseCase _updateNickNameSubAccountUseCase;
  late Account account;

  final BehaviorSubject<bool> nameEditableNotifierSubject = BehaviorSubject();

  ///*-------------------update nick name api variable--------------------///
  PublishSubject<UpdateNickNameSubAccountUseCaseParams> _updateNickNameRequest = PublishSubject();

  BehaviorSubject<Resource<bool>> _updateNickNameResponse = BehaviorSubject();

  MyAccountViewModel(
    this._updateNickNameSubAccountUseCase,
  ) {
    _updateNickNameRequest.listen((value) {
      RequestManager(value, createCall: () => _updateNickNameSubAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateNickNameResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
  }

  Stream<Resource<bool>> get updateNickNameResponseStream => _updateNickNameResponse.stream;

  Stream<bool> get nameEditableNotifierStream => nameEditableNotifierSubject.stream;

  toggleEditSubmitIcon(value) {
    nameEditableNotifierSubject.safeAdd(value);
  }

  void updateNickName({required String SubAccountNo, required String NickName}) {
    _updateNickNameRequest.safeAdd(
      UpdateNickNameSubAccountUseCaseParams(NickName: NickName, accountNo: SubAccountNo, GetToken: true),
    );
  }

  Size deviceSize = Size(0, 0);

  @override
  void dispose() {
    super.dispose();
  }
}
