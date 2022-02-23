import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../variables/house.dart';

class AddHouseInformation extends StatefulWidget {
  static const routeName = '/add-house-information';

  @override
  _AddHouseInformationState createState() => _AddHouseInformationState();
}

class _AddHouseInformationState extends State<AddHouseInformation> {
  final _kitchenFocusNode = FocusNode();
  final _bathroomFocusNode = FocusNode();
  final _postFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _villageFocusNode = FocusNode();
  final _districtFocusNode = FocusNode();
  final _housetypeFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  String location = 'Null, Press Button';
  String Address = 'search';

  var _houseInformation = House(
    bedroomNo: null,
    mobile: null,
    village: null,
    district: null,
    houseType: null,
    latitude: null,
    longitude: null,
    street: null,
    gmail: null,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    // remove memory leak
    _kitchenFocusNode.dispose();
    _bathroomFocusNode.dispose();
    _postFocusNode.dispose();
    _mobileFocusNode.dispose();
    _villageFocusNode.dispose();
    _districtFocusNode.dispose();
    _housetypeFocusNode.dispose();
    super.dispose();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<HouseData>(context, listen: false)
        .addHouseInformation(_houseInformation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff38ada9),
        title: const Text('House Information'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    labelText: 'Bedroom No'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_kitchenFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Provide Number";
                  } else if (int.tryParse(value) == null) {
                    return "Please Provide Number";
                  }
                  return null;
                },
                onSaved: (value) {
                  _houseInformation = House(
                    bedroomNo: value,
                    village: _houseInformation.village,
                    district: _houseInformation.district,
                    houseType: _houseInformation.houseType,
                    latitude: _houseInformation.latitude,
                    longitude: _houseInformation.longitude,
                    gmail: email,
                    street: _houseInformation.street,
                  );
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    labelText: 'Mobile'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _mobileFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_villageFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Provide Number";
                  } else if (int.tryParse(value) == null) {
                    return "Please provide number";
                  }
                  return null;
                },
                onSaved: (value) {
                  _houseInformation = House(
                    bedroomNo: _houseInformation.bedroomNo,
                    mobile: value,
                    village: _houseInformation.village,
                    district: _houseInformation.district,
                    houseType: _houseInformation.houseType,
                    latitude: _houseInformation.latitude,
                    longitude: _houseInformation.longitude,
                    gmail: email,
                    street: _houseInformation.street,
                  );
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    labelText: 'Village'),
                textInputAction: TextInputAction.next,
                focusNode: _villageFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_districtFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Provide Village Name";
                  }
                  return null;
                },
                onSaved: (value) {
                  _houseInformation = House(
                    bedroomNo: _houseInformation.bedroomNo,
                    mobile: _houseInformation.mobile,
                    village: value,
                    district: _houseInformation.district,
                    houseType: _houseInformation.houseType,
                    latitude: _houseInformation.latitude,
                    longitude: _houseInformation.longitude,
                    gmail: email,
                    street: _houseInformation.street,
                  );
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    labelText: 'District'),
                textInputAction: TextInputAction.next,
                focusNode: _districtFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_housetypeFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Provide District Name";
                  }
                  return null;
                },
                onSaved: (value) {
                  _houseInformation = House(
                    bedroomNo: _houseInformation.bedroomNo,
                    mobile: _houseInformation.mobile,
                    village: _houseInformation.village,
                    district: value,
                    houseType: _houseInformation.houseType,
                    latitude: _houseInformation.latitude,
                    longitude: _houseInformation.longitude,
                    gmail: email,
                    street: _houseInformation.street,
                  );
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff38ada9), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    labelText: 'House type : (family/bachelor/both)'),
                textInputAction: TextInputAction.next,
                focusNode: _housetypeFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Provide House Type";
                  }
                  return null;
                },
                onSaved: (value) {
                  _houseInformation = House(
                    bedroomNo: _houseInformation.bedroomNo,
                    mobile: _houseInformation.mobile,
                    village: _houseInformation.village,
                    district: _houseInformation.district,
                    houseType: value,
                    latitude: _houseInformation.latitude,
                    longitude: _houseInformation.longitude,
                    gmail: email,
                    street: _houseInformation.street,
                  );
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff38ada9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xff38ada9))),

                  // padding:  EdgeInsets.all(30.0),
                  primary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () async {
                  Position position = await _getGeoLocationPosition();
                  _houseInformation.longitude = position.longitude;
                  _houseInformation.latitude = position.latitude;
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      position.latitude, position.longitude);
                  Placemark place = placemarks[0];
                  _houseInformation.street = place.street;
                  Widget okButton = TextButton(
                    child: const Text("Okay"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("Location Detected"),
                    actions: [
                      okButton,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: Text('Get Location'),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff38ada9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xff38ada9))),

                  // padding:  EdgeInsets.all(30.0),
                  primary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Satisfy',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                onPressed: _saveForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
