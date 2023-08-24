import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/base_page_view_model.dart';
import '../../../../utils/request_manager.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';
import 'open_sub_account_success_page.dart';

class OpenSubAccountSuccessPageViewModel extends BasePageViewModel {
  final OpenSubAccountSuccessPageArgument argument;

  OpenSubAccountSuccessPageViewModel(this.argument);
}
