import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:domain/usecase/sub_account/update_nick_name_sub_account_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';

class MyAccountViewModel extends BasePageViewModel {

  late Account account;

  final BehaviorSubject<bool> nameEditableNotifierSubject = BehaviorSubject();

  Stream<bool> get nameEditableNotifierStream => nameEditableNotifierSubject.stream;

  MyAccountViewModel() {}

  toggleEditSubmitIcon(value) {
    nameEditableNotifierSubject.safeAdd(value);
  }

  Size deviceSize = Size(0, 0);

  @override
  void dispose() {
    super.dispose();
  }
}
