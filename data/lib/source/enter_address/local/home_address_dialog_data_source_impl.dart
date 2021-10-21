import 'package:data/source/enter_address/home_address_dialog_ds.dart';
import 'package:domain/model/enter_address/home_address.dart';
import 'package:geocoding/geocoding.dart';

class HomeAddressDialogDSImpl with HomeAddressDialogDS {
  @override
  Future<HomeAddress> getHomeAddress(
      {double? latitude, double? longitude}) async {
    HomeAddress homeAddress = HomeAddress();
    final address = await placemarkFromCoordinates(latitude!, longitude!);
    if (address.isNotEmpty) {
      HomeAddress addressResult = HomeAddress(
          dropOffAreaText: '${address.first.name ?? ""}',
          completeAddress:
              "${address.first.subLocality != null ? '${address.first.subLocality}, ' : ""}"
              "${address.first.locality != null ? '${address.first.locality} ' : ""} ");
      homeAddress = addressResult;
    }
    return homeAddress;
  }
}
