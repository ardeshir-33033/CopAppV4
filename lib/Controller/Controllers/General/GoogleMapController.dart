import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/Map/MapService.dart';
import 'package:copapp/Model/Neshan/NeshanModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../AddAddressController.dart';

class MapController extends GetxController {
  LatLng? origin;

  LatLng? target;
  LatLng? mapPosition;

  Set<Marker> markers = {};
  GoogleMapController? controller;

  Location locationTracker = Location();

  LatLng lastMapPosition = LatLng(35.6892, 51.3890);
  NeshanAddress mapAddress = NeshanAddress();

  AddAddressController addressController = Get.find();

  void onAddMarkerButtonPressed() {
    if (origin == null) {
      origin = lastMapPosition;
      onPositionChange(origin!);
    } else {
      target = lastMapPosition;
      onPositionChange(target!);
    }

    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(lastMapPosition.toString()),
      position: lastMapPosition,
      icon: BitmapDescriptor.defaultMarker,
    ));
    update([1]);
  }

  void onCameraMove(CameraPosition position) {
    lastMapPosition = position.target;
  }

  void onMapCreated(GoogleMapController controller1) {
    controller = controller1;
  }

  // void deleteMarker() {
  //   markers.clear();
  //   update();
  // }

  Widget locationOn() {
    if (origin == null) {
      return Icon(
        Icons.location_on,
        color: Colors.red,
        size: 55.0,
      );
    } else
      return Icon(
        Icons.location_on,
        color: Colors.blue,
        size: 55.0,
      );
  }

  void getCurrentLocation() async {
    try {
      var location = await locationTracker.getLocation();

      if (controller != null) {
        controller!.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(location.latitude ?? 0, location.longitude ?? 0),
                tilt: 0,
                zoom: 18.00)));
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  Future<void> gotoLocation(double lat, double long) async {
    controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  onPositionChange(LatLng res) async {
    mapPosition = res;
    ResponseModel result =
        await MapService().getMapAddress(res.latitude, res.longitude);
    if (result.isSuccess == false) {
      // result.ShowMessage(_scaffoldKey);
    } else {
      mapAddress = result.data as NeshanAddress;
      addressController.setNeshanAddress(mapAddress);
      update();
      // mapUpdate = true;
      // setState(() {
      //   // mapUpdate = false;
      // });
    }
  }
}
