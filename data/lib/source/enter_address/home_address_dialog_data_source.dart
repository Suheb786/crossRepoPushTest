import 'package:domain/model/enter_address/home_address.dart';

mixin HomeAddressDialogDataSource {
  Future<HomeAddress> getHomeAddress({double? latitude, double? longitude});
}
