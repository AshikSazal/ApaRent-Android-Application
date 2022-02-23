import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../variables/search_house.dart';

class SearchHouse extends StatefulWidget {
  static String routeName = '/search-house';

  @override
  _SearchHouseState createState() => _SearchHouseState();
}

class _SearchHouseState extends State<SearchHouse> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Marker> _markers2 = {};
  String _searchValue;

  void _onMapCreated() {
    _searchValue = ModalRoute.of(context).settings.arguments as String;
    Provider.of<UserSearchHouse>(context, listen: false)
        .userSearchHouse(_searchValue);
    final value = Provider.of<UserSearchHouse>(context);
    final location_length = value.searchgetter.length;
    if (location_length != 0) {
      for (int i = 0; i < location_length; i++) {
        Marker markerValue = Marker(
          markerId: MarkerId("id-$i"),
          position: LatLng(
              value.searchgetter[i].latitude, value.searchgetter[i].longitude),
          infoWindow: InfoWindow(
            title: value.searchgetter[i].street,
            snippet: value.searchgetter[i].mobile.toString(),
          ),
        );
        _markers.add(markerValue);
      }
    }

    _markers2.addAll(_markers);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _onMapCreated();
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(25.7829533, 88.898265),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers2,
      ),
    );
  }
}
