import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocationScreen extends StatefulWidget {
  static const routeName = "UserCurrentLocationScreen";

  @override
  _UserCurrentLocationScreenState createState() =>
      _UserCurrentLocationScreenState();
}

class _UserCurrentLocationScreenState extends State<UserCurrentLocationScreen> {
  var initialPosition =
      const CameraPosition(target: LatLng(21.430072, -268.024922), zoom: 12);
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Current Location Screen"),
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },

        ///code doesn't work
        // onTap: (LatLng position) {
        //   setState(() {
        //     markers.add(Marker(
        //         markerId: MarkerId('${position}'),
        //         position: position,
        //         icon: BitmapDescriptor.defaultMarker,
        //         alpha: BitmapDescriptor.hueGreen,
        //         infoWindow: const InfoWindow(title: "You added this marker!!")));
        //   });
        // },
        zoomControlsEnabled: false,
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position _position = await _determinePosition();

          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(_position.latitude, _position.longitude),
                tilt: 14,
                zoom: 14,
              ),
            ),
          );

          markers.clear();

          markers.add(Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(_position.latitude, _position.longitude),
              icon: BitmapDescriptor.defaultMarker,
              alpha: BitmapDescriptor.hueRed,
              infoWindow: const InfoWindow(
                  title: "This is your Location", snippet: "Change location")));
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Don't have Permission");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Permission for location checking denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission denied Forever");
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
