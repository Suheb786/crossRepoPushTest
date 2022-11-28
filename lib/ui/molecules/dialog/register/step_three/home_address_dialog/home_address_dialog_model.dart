import 'dart:typed_data';

import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/enter_address/home_address.dart';
import 'package:domain/usecase/user/home_address_dialog_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
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

  LatLng currentLocation = LatLng(31.8360368, 35.6674278);

  ///current Address request subject
  PublishSubject<HomeAddressDialogUseCaseParams> _currentAddressRequestSubject = PublishSubject();

  ///current Address response subject
  PublishSubject<Resource<HomeAddress>> _currentAddressResponseSubject = PublishSubject();

  /// current User Address response stream holder
  Stream<Resource<HomeAddress>> get currentAddressValidatorStream => _currentAddressResponseSubject.stream;

  void getAddress(LatLng latLng) {
    _currentAddressRequestSubject
        .safeAdd(HomeAddressDialogUseCaseParams(latitude: latLng.latitude, longitude: latLng.longitude));
  }

  ///current User location response subject
  PublishSubject<LatLng> _currentUserLocationValidatorSubject = PublishSubject();

  /// current User location response stream holder
  Stream<LatLng> get currentUserLocationValidatorStream => _currentUserLocationValidatorSubject.stream;

  /// get current location
  determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToastWithError(AppError(
          type: ErrorType.LOCATION_SERVICE_NOT_ENABLED,
          error: ErrorInfo(
            message: '',
          ),
          cause: Exception()));
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        showToastWithError(AppError(
            type: ErrorType.LOCATION_SERVICE_NOT_ENABLED,
            error: ErrorInfo(
              message: '',
            ),
            cause: Exception()));
      } else if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        await setCurrentUserLocation();
      }
    } else {
      await setCurrentUserLocation();
    }
  }

  Future setCurrentUserLocation() async {
    var userCurrentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _currentUserLocationValidatorSubject
        .add(LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude));
    getAddress(LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude));
  }

  void setUseCurrentSelectedLocation(LatLng latLng) {
    _currentUserLocationValidatorSubject.safeAdd(latLng);
    getAddress(latLng);
  }

  void setPinPointMarker() async {
    final Uint8List markerIcon = await MapMarkerUtils.getCustomMarker(AssetUtils.marker, 80);
    pinPointMarker = markerIcon;
    notifyListeners();
  }

  HomeAddressDialogViewModel(this._homeAddressDialogUseCase) {
    _currentAddressRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _homeAddressDialogUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS) {
          _currentAddressResponseSubject.safeAdd(event);
        }
      });
    });
    determineCurrentPosition();
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
