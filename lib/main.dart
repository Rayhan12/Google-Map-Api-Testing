import 'package:flutter/material.dart';
import 'package:map_location_place/Screens/Home.dart';
import 'package:map_location_place/Screens/Simple_Google%20Map.dart';
import 'package:map_location_place/Screens/User%20Current%20Location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        SimpleGoogleMap.routeName : (context) => SimpleGoogleMap(),
        UserCurrentLocationScreen.routeName : (context) => UserCurrentLocationScreen(),
      },
    );
  }
}
