import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  String? name;
  String? url;
  LatLng? place;
  String? description;

  MarkerModel({this.name, this.url, this.place, this.description});
}
