import 'package:copapp/Controller/Controllers/General/GoogleMapController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class googleMapComponent extends StatelessWidget {
  MapController googleMapController = Get.put(MapController());
  GoogleMapController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GetBuilder<MapController>(
              id: "text",
              builder: (_) {
                return GoogleMap(
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    new Factory<OneSequenceGestureRecognizer>(
                      () => new EagerGestureRecognizer(),
                    ),
                  ].toSet(),
                  onMapCreated: googleMapController.onMapCreated,
                  compassEnabled: false,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: true,
                  // onMapCreated: googleMapController.onMapCreated(GoogleMapController controller1),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(35.6892, 51.3890),
                    zoom: 11.0,
                  ),
                  minMaxZoomPreference: MinMaxZoomPreference(1, 1000),
                  rotateGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  markers: googleMapController.markers,
                  onCameraMove: googleMapController.onCameraMove,
                );
              }),
          /////////////////////MARKER
          Padding(
            padding: EdgeInsets.only(bottom: 55.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  googleMapController.onAddMarkerButtonPressed();
                },
                child: googleMapController.locationOn(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  IconButton(
                    onPressed: () {
                      googleMapController.getCurrentLocation();
                    },
                    icon: Icon(
                      Icons.location_searching_outlined,
                      color: Colors.black,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
