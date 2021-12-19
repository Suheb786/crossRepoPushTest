import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/map_marker_utils.dart';
import 'package:rxdart/rxdart.dart';

class LocateATMPageViewModel extends BasePageViewModel {
  GoogleMapController? mapController;

  var pinPointMarker;

  LatLng currentLocation = LatLng(25.2013361, 55.2721801);

  Iterable markers = [];

  Iterable generateMarkers() {
    Iterable _markers = Iterable.generate(locationList.length, (index) {
      return Marker(
          markerId: MarkerId(LatLng(locationList[index].latLng!.latitude,
              locationList[index].latLng!.longitude)
              .toString()),
          icon: BitmapDescriptor.fromBytes(pinPointMarker),
          position: LatLng(locationList[index].latLng!.latitude,
              locationList[index].latLng!.longitude),
          infoWindow: InfoWindow(title: locationList[index].name));
    });

    markers = _markers;

    return _markers;
  }

  ///listen to panel open response subject
  PublishSubject<bool> _panelOpenSubject = PublishSubject();

  /// listen to panel open response stream holder
  Stream<bool> get panelOpenStream => _panelOpenSubject.stream;

  List<ATMLocationModel> locationList = [
    ATMLocationModel(
        name: 'Capital Bank Of Jordan PLC. CO. Rainbow St Jabal,',
        address: 'Amman,  Jordan',
        distance: '0.8 km',
        latLng: LatLng(25.2013361, 55.2721801)),
    ATMLocationModel(
        name: 'Capital Bank Of Jordan PLC. CO. Madaba St,',
        address: 'Amman,  Jordan',
        distance: '0.8 km',
        latLng: LatLng(25.2012371, 55.2621801)),
    ATMLocationModel(
        name: 'Capital Bank Of Jordan PLC. CO. Jamal Al Din Al Afghani St, ',
        address: 'Amman,  Jordan',
        distance: '0.8 km',
        latLng: LatLng(25.2013673, 55.277801)),
    ATMLocationModel(
        name: 'Capital Bank Of Jordan PLC. CO. Al Abdali Amman,',
        address: 'Amman,  Jordan',
        distance: '0.8 km',
        latLng: LatLng(25.2013371, 55.2721901)),
    ATMLocationModel(
        name: 'Capital Bank Of Jordan PLC. CO. Amman Boulevard, ',
        address: 'Amman,  Jordan',
        distance: '0.8 km',
        latLng: LatLng(25.2013373, 55.2721802))
  ];

  LocateATMPageViewModel() {
    //generateMarkers();
    setPinPointMarker();
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
