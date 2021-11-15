import 'package:data/network/api_service.dart';
import 'package:data/source/user/user_data_sources.dart';

class UserRemoteDSImpl extends UserRemoteDS {
  final ApiService _apiService;

  UserRemoteDSImpl(this._apiService);
}
