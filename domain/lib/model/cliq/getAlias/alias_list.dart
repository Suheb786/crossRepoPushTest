import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:domain/model/cliq/getAlias/account_list.dart';

class AliasList {
  final String? aliasID;
  final String? aliasName;
  final String? aliasType;
  final CliqAliasIdStatusEnum? status;
  final List<AccountList>? accounts;

  AliasList({
    required this.aliasID,
    required this.aliasName,
    required this.aliasType,
    this.status = CliqAliasIdStatusEnum.NONE,
    required this.accounts,
  });
}
