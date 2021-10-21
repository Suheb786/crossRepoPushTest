import 'dart:typed_data';
import 'package:domain/model/enter_address/home_address.dart';
import 'package:domain/usecase/user/home_address_dialog_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/map_marker_utils.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class HomeAddressDialogViewModel extends BasePageViewModel {
  final HomeAddressDialogUseCase _homeAddressDialogUseCase;

  GoogleMapController? mapController;

  TextEditingController addressController = TextEditingController();

  var pinPointMarker;

  LatLng currentLocation = LatLng(25.2013361, 55.2721801);

  ///current Address request subject
  PublishSubject<HomeAddressDialogUseCaseParams> _currentAddressRequestSubject =
      PublishSubject();

  ///current Address response subject
  PublishSubject<Resource<HomeAddress>> _currentAddressResponseSubject =
      PublishSubject();

  /// current User Address response stream holder
  Stream<Resource<HomeAddress>> get currentAddressValidatorStream =>
      _currentAddressResponseSubject.stream;

  void getAddress(LatLng latLng) {
    print("latitude: ${latLng.latitude}");
    _currentAddressRequestSubject.safeAdd(HomeAddressDialogUseCaseParams(
        latitude: latLng.latitude, longitude: latLng.longitude));
  }

  ///current User location response subject
  PublishSubject<LatLng> _currentUserLocationValidatorSubject =
      PublishSubject();

  /// current User location response stream holder
  Stream<LatLng> get currentUserLocationValidatorStream =>
      _currentUserLocationValidatorSubject.stream;

  void setUseCurrentLocation(LatLng latLng) {
    _currentUserLocationValidatorSubject.safeAdd(latLng);
    getAddress(latLng);
  }

  void setPinPointMarker() async {
    final Uint8List markerIcon =
        await MapMarkerUtils.getCustomMarker(AssetUtils.marker, 80);
    pinPointMarker = markerIcon;
    notifyListeners();
  }

  HomeAddressDialogViewModel(this._homeAddressDialogUseCase) {
    _currentAddressRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _homeAddressDialogUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS) {
          _currentAddressResponseSubject.safeAdd(event);
          print("data : ${event.data!.completeAddress ?? "name"}");
        }
      });
    });
    getAddress(LatLng(currentLocation.latitude, currentLocation.longitude));
  }

  @override
  void dispose() {
    _currentAddressResponseSubject.close();
    _currentUserLocationValidatorSubject.close();
    _currentAddressRequestSubject.close();
    super.dispose();
  }
}
