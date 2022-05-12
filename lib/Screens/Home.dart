import 'package:flutter/material.dart';
import 'package:map_location_place/Screens/Simple_Google%20Map.dart';
import 'package:map_location_place/Screens/User%20Current%20Location.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Map Related Testings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SimpleGoogleMap.routeName);
                },
                child: const Text("Simple Google Map")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(UserCurrentLocationScreen.routeName);
                },
                child: const Text("Google Map With user Current Location")),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Google Search Places")),
            ElevatedButton(
                onPressed: () {},
                child: const Text("Nearby Places"))
          ],
        ),
      ),
    );
  }
}
