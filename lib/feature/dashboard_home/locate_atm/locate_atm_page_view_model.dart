import 'dart:typed_data';

import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/dashboard/get_atms/get_atms_response.dart';
import 'package:domain/usecase/dashboard/get_atms_usecase.dart';
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

class LocateATMPageViewModel extends BasePageViewModel {
  final GetAtmsUseCase _getAtmsUseCase;
  GoogleMapController? mapController;

  var pinPointMarker;

  ///get atm request subject
  PublishSubject<GetAtmsUseCaseParams> _getAtmsRequest = PublishSubject();

  ///get atm response subject
  PublishSubject<Resource<GetATMResponse>> _getAtmsResponse = PublishSubject();

  ///get atm response stream
  Stream<Resource<GetATMResponse>> get getAtmsStream => _getAtmsResponse.stream;

  LatLng currentLocation = LatLng(25.2013361, 55.2721801);

  ///markers subject
  BehaviorSubject<Set<Marker>> _markersResponse =
      BehaviorSubject.seeded(Set<Marker>());

  ///marker stream
  Stream<Set<Marker>> get markerStream => _markersResponse.stream;

  Set<Marker> markers = Set<Marker>();

  generateMarkers(GetATMResponse response) {
    markers.clear();
    if (response.atmContentData!.isNotEmpty) {
      var i = 0;
      // markers.add(Marker(
      //   markerId: MarkerId('MarkerId1'),
      //   icon: BitmapDescriptor.fromBytes(pinPointMarker),
      //   position: LatLng(double.parse(26.189068395115072.toString()),
      //       double.parse(50.55864931553785.toString())),
      // ));
      response.atmContentData!.forEach((e) {
        markers.add(Marker(
          markerId: MarkerId('MarkerId${e.longitude}$i'),
          icon: BitmapDescriptor.fromBytes(pinPointMarker),
          position:
              LatLng(double.parse(e.latitude!), double.parse(e.longitude!)),
        ));
        i++;
      });
      _markersResponse.safeAdd(markers);
    }
  }

  ///listen to panel open response subject
  PublishSubject<bool> _panelOpenSubject = PublishSubject();

  /// listen to panel open response stream holder
  Stream<bool> get panelOpenStream => _panelOpenSubject.stream;

  ///set current location request handler
  final PublishSubject<Position> _currentLocationRequest =
      PublishSubject();

  ///set current location response stream
  Stream<Position> get currentLocationResponseStream =>
      _currentLocationRequest.stream;

  LocateATMPageViewModel(this._getAtmsUseCase) {
    _getAtmsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getAtmsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAtmsResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          generateMarkers(event.data!);
        }
      });
    });
    //generateMarkers();
    determineCurrentPosition();
    setPinPointMarker();
    getAtms();
  }

  void panelOpen(bool value) {
    _panelOpenSubject.safeAdd(value);
  }

  void setPinPointMarker() async {
    final Uint8List markerIcon =
        await MapMarkerUtils.getCustomMarker(AssetUtils.blinkMarkerPng, 80);
    pinPointMarker = markerIcon;
    //notifyListeners();
  }

  /// get current location
  determineCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        showToastWithError(AppError(
            type: ErrorType.LOCATION_SERVICE_NOT_ENABLED,
            error: ErrorInfo(
              message: '',
            ),
            cause: Exception()));
      }
    } else {
      await setCurrentUserLocation();
    }
  }

  Future setCurrentUserLocation() async {
    var userCurrentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print('location---->${userCurrentPosition.longitude}');
    _currentLocationRequest.add(userCurrentPosition);
  }

  void getAtms() {
    _getAtmsRequest.safeAdd(GetAtmsUseCaseParams());
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ATMLocationModel {
  final String? name;
  final String? address;
  final String? distance;
  final LatLng? latLng;

  ATMLocationModel({this.name, this.address, this.distance, this.latLng});
}
