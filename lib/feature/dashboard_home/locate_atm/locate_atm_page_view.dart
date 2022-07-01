import 'package:domain/model/dashboard/get_atms/get_atms_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dashboard/locate_atm_list_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocateATMPageView extends BasePageViewWidget<LocateATMPageViewModel> {
  LocateATMPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<GetATMResponse>>(
      stream: model.getAtmsStream,
      initialData: Resource.none(),
      dataBuilder: (context, atmResponse) {
        return Container(
            child: SlidingUpPanel(
          onPanelOpened: () {
            model.panelOpen(true);
          },
          onPanelClosed: () {
            model.panelOpen(false);
          },
          borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          panel: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                height: 4,
                width: 64,
                decoration: BoxDecoration(color: AppColor.white_gray, borderRadius: BorderRadius.circular(4)),
              ),
              AppStreamBuilder<bool>(
                stream: model.panelOpenStream,
                initialData: false,
                dataBuilder: (context, isOpen) {
                  return Text(
                    !isOpen! ? S.of(context).swipeToViewList : S.of(context).swipeToViewMap,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.white_gray,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColorDark.withOpacity(0.08),
                            blurRadius: 20.0,
                          )
                        ],
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                    child: atmResponse!.data!.atmContentData!.length > 0
                        ? ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            itemBuilder: (context, index) {
                              return LocateATMListWidget(
                                atmContentData: atmResponse.data!.atmContentData![index],
                                onTap: () {},
                              );
                            },
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: atmResponse.data!.atmContentData!.length,
                          )
                        : Center(
                            child: Text('There are no atms to display'),
                          )),
              )
            ],
          ),
          body: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Stack(
              children: [
                AppStreamBuilder<Set<Marker>>(
                  stream: model.markerStream,
                  initialData: Set<Marker>(),
                  dataBuilder: (context, markerResponse) {
                    print('marker response:${markerResponse!.length}');
                    return GoogleMap(
                        mapType: MapType.terrain,
                        scrollGesturesEnabled: true,
                        mapToolbarEnabled: false,
                        trafficEnabled: false,
                        compassEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomGesturesEnabled: true,
                        initialCameraPosition: CameraPosition(target: LatLng(32.010532, 35.867756), zoom: 15),
                        onMapCreated: (GoogleMapController controller) {
                          model.mapController = controller;
                          model.setPinPointMarker();
                        },
                        onTap: (latLng) {},
                        markers: markerResponse);
                  },
                ),
                PositionedDirectional(
                  bottom: 120,
                  start: 32,
                  end: 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 51,
                        width: 51,
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentTextTheme.bodyText1!.color),
                        child: AppSvg.asset(AssetUtils.pinMarker),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColor.light_grayish_violet.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            S.of(context).dragMap,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
