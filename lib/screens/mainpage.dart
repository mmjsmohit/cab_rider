import 'dart:async';

import 'package:cab_rider/dataproviders/appdata.dart';
import 'package:cab_rider/helpers/helpermethods.dart';
import 'package:cab_rider/screens/searchpage.dart';
import 'package:cab_rider/styles/styles.dart';
import 'package:cab_rider/widgets/BrandDivider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../brand_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String id = 'mainpage';
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              Container(
                child: DrawerHeader(
                  child: Row(
                    children: [
                      Image.asset(
                        'images/user_icon.png',
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mohit Tiwari',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Brand-Bold'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('View Profile')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              DrawerTileItem(icon: Icons.card_giftcard, title: 'Free Rides'),
              DrawerTileItem(icon: Icons.credit_card, title: 'Payments'),
              DrawerTileItem(icon: Icons.history, title: 'Ride History'),
              DrawerTileItem(icon: Icons.support, title: 'Support'),
              DrawerTileItem(icon: Icons.info, title: 'About')
            ],
          ),
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          padding: const EdgeInsets.only(bottom: 255, top: 30),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(20.5937, 78.9629),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) async {
            Position position = await getUserCurrentLocation();
            _controller.complete(controller);
            mapController = controller;
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 15.25)));
          },
        ),
        Positioned(
          top: 44,
          left: 20,
          child: GestureDetector(
            onTap: (() {
              scaffoldKey.currentState?.openDrawer();
            }),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        ))
                  ]),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(
                  Icons.menu,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ))
                ]),
            // height: 240,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Nice to see you!',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Where do you want to go?',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Brand-Bold'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                0.7,
                                0.7,
                              ))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text('Search Destination')
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(children: [
                    Icon(
                      Icons.home_outlined,
                      color: BrandColors.colorDimText,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (Provider.of<AppData>(context).pickupAddress != null)
                              ? Provider.of<AppData>(context)
                                  .pickupAddress
                                  .placeName
                              : 'Add Home',
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          (Provider.of<AppData>(context).pickupAddress != null)
                              ? Provider.of<AppData>(context)
                                  .pickupAddress
                                  .placeFormattedAddress
                              : 'Your residential address',
                          style: TextStyle(
                              fontSize: 11, color: BrandColors.colorDimText),
                        )
                      ],
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  BrandDivider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Icon(
                      Icons.work_outline,
                      color: BrandColors.colorDimText,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Work',
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Your workplace address',
                          style: TextStyle(
                              fontSize: 11, color: BrandColors.colorDimText),
                        )
                      ],
                    )
                  ])
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    Position currPosition = await Geolocator.getCurrentPosition();
    HelperMethods.findCoordinateAddress(currPosition, context);
    return currPosition;
  }
}

CameraPosition moveToCurrentPosition(Position position) {
  return CameraPosition(
    target: LatLng(position.latitude, position.longitude),
    zoom: 14.4746,
  );
}

class DrawerTileItem extends StatelessWidget {
  IconData? icon;
  String title;

  DrawerTileItem({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: kDrawerItemStyle,
      ),
    );
  }
}
