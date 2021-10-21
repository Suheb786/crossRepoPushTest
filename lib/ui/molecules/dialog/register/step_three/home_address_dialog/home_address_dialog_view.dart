import 'package:domain/model/enter_address/home_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/home_address_dialog/home_address_dialog_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class HomeAddressDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const HomeAddressDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return homeAddressDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeAddressDialogViewModel>(
      providerBase: providerBase(),
      builder: (context, model, child) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          insetPadding:
              EdgeInsets.only(left: 24, right: 24, bottom: 56, top: 204),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  child: Container(
                      height: 344,
                      child: AppStreamBuilder<LatLng>(
                        stream: model!.currentUserLocationValidatorStream,
                        initialData: LatLng(25.2013361, 55.2721801),
                        dataBuilder: (context, currentLocation) {
                          return GoogleMap(
                            mapType: MapType.normal,
                            scrollGesturesEnabled: true,
                            mapToolbarEnabled: false,
                            trafficEnabled: false,
                            compassEnabled: false,
                            myLocationButtonEnabled: false,
                            zoomGesturesEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(currentLocation!.latitude,
                                    currentLocation.longitude),
                                zoom: 12),
                            onMapCreated: (GoogleMapController controller) {
                              model.mapController = controller;
                              print(currentLocation.longitude);
                              model.setPinPointMarker();
                            },
                            onTap: (latLng) {
                              model.setUseCurrentLocation(latLng);
                            },
                            markers: {
                              Marker(
                                markerId: MarkerId(LatLng(
                                        currentLocation.latitude,
                                        currentLocation.longitude)
                                    .toString()),
                                draggable: true,
                                position: LatLng(currentLocation.latitude,
                                    currentLocation.longitude),
                                icon: model.pinPointMarker != null
                                    ? BitmapDescriptor.fromBytes(
                                        model.pinPointMarker)
                                    : BitmapDescriptor.defaultMarker,
                                //icon: BitmapDescriptor.defaultMarker
                              )
                            },
                          );
                        },
                      )),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: AppStreamBuilder<Resource<HomeAddress>>(
                      stream: model.currentAddressValidatorStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        model.addressController.text =
                            data.data!.dropOffAreaText!;
                      },
                      dataBuilder: (context, currentLocation) {
                        return AppTextField(
                          controller: model.addressController,
                          labelText: "Home Address",
                          hintText: "",
                          labelFontSize: 12,
                          labelColor: AppColor.black,
                          textColor: AppColor.black,
                          suffixIcon: (isValid, value) => Image.asset(
                            AssetUtils.locationBlack,
                            color: AppColor.black,
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 21,
                ),
                InkWell(
                  onTap: () {
                    onSelected!.call(model.addressController.text);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: 57,
                    width: 57,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.dark_violet_4),
                    child: AppSvg.asset(AssetUtils.tick),
                  ),
                ),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
