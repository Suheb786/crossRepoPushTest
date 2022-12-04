import 'package:domain/model/cliq/getAlias/account_list.dart';

class AliasList {
  final String? aliasID;
  final String? aliasName;
  final String? aliasType;
  final String? status;
  final List<AccountList>? accounts;

  AliasList({
    required this.aliasID,
    required this.aliasName,
    required this.aliasType,
    required this.status,
    required this.accounts,
  });
}
