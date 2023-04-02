import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sdgp/screens/cost_estimation.dart';
import 'package:sdgp/screens/home_screen.dart';
import 'package:sdgp/screens/home_screen_new.dart';
import 'package:sdgp/utils/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdgp/utils/config.dart';
import 'package:sdgp/utils/next_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sdgp/src/locations.dart' as locations;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';


class Shops extends StatefulWidget {
  const Shops({super.key});

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  late GoogleMapController _mapController;
  List<Marker> _markers =[];

  //final Map<String, Marker> _markers ={};
  /*Future<void> _onMapCreated(GoogleMapController controller) async{
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }*/

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

 /* void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.center,
              scale: 0.5,
              opacity: 0.1,
              image: AssetImage(Config.app_logo),
              fit: BoxFit.cover),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 240, 223, 189),
              Color.fromARGB(255, 217, 202, 106),
              Color.fromARGB(255, 215, 187, 94)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //Back button
                        GestureDetector(
                          onTap: () {
                            nextScreen(context, CostEstimation());
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: kIconColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Shops near me",
                          style: kPageTitleStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 550,
                child: GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(6.895521, 79.855751),
                      zoom:12.0,
                    ),
                    markers: Set<Marker>.of(_markers),

                    /*onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(0, 0),
                      zoom: 2,
                    ),
                    markers: _markers.values.toSet(),*/
                ),

              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Cancle button
                  TextButton(
                    onPressed: () {
                      nextScreen(context, HomeScreenNew());
                    },
                    child: Text(
                      "       Cancel       ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 160, 130, 13)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 239, 232, 205)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Color.fromARGB(255, 239, 232, 205),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  //Search for shop button
                  TextButton(
                    onPressed: () {
                      nextScreen(context, HomeScreen());
                    },
                    child: Text(
                      "Search for shops",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 255, 255)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 160, 130, 13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 160, 130, 13))))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchRepairShops,
        child: Icon(Icons.search),
      ),
    );
  }

  Future<void> _searchRepairShops() async {

    final apiKey = Platform.isAndroid ? 'AIzaSyDoHvRTcf2tl0KaF762KP18wdh9DEf8MJ8': 'AIzaSyBbi5GtCDnEFgHbOFvytMgTv6YC4qDeTig';
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: apiKey);

    PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(lat: 6.895521, lng: 79.855751),
        5000,
        type: "car_repair",
    );

    setState(() {
      _markers = response.results
          .map((result) => Marker(
        markerId: MarkerId(result.placeId),
        position: LatLng(
          result.geometry!.location.lat,
          result.geometry!.location.lng,
        ),
        infoWindow: InfoWindow(title: result.name),
      ))
          .toList();
    });

  }
}
