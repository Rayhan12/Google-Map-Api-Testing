import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleGoogleMap extends StatefulWidget {
  static const routeName = "SimpleGoogleMap";

  @override
  _SimpleGoogleMapState createState() => _SimpleGoogleMapState();
}

class _SimpleGoogleMapState extends State<SimpleGoogleMap> {
  ///Google map Controller
  final Completer<GoogleMapController> _controller = Completer();

  var initialPosition =
      const CameraPosition(target: LatLng(21.430072, -268.024922), zoom: 12);

  var targetPosition = const CameraPosition(
      target: LatLng(21.424727, -268.026729), zoom: 16, tilt: 64, bearing: 192);

  LatLng data = const LatLng(21.430072, -268.024922);
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${data.latitude.toString()} || ${data.longitude.toString()} ",
            style: const TextStyle(fontSize: 13)),
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (LatLng value) {
          setState(() {
            data = value;
            state = true;
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Go to Location"),
        icon: const Icon(Icons.location_on_outlined),
        onPressed: goToLocation,
        elevation: 3,
      ),
    );
  }

  void goToLocation() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(state == false
        ? targetPosition
        : CameraPosition(target: data, zoom: 16, tilt: 64, bearing: 192)));
  }
}
