import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './auth.dart';

class House {
  String bedroomNo;
  String mobile;
  String village;
  String district;
  String houseType;
  double latitude;
  double longitude;
  String street;
  String gmail;
  String id;

  House({
    this.bedroomNo,
    this.mobile,
    this.village,
    this.district,
    this.houseType,
    this.latitude,
    this.longitude,
    this.street,
    this.gmail,
    this.id,
  });
}

class HouseData with ChangeNotifier {
  List<House> _allHouse = [];
  String _email;

  List<House> get housegetter {
    return [..._allHouse];
  }

  static const api = 'https://bashavara-f7ebd-default-rtdb.firebaseio.com';

  Future<void> addHouseInformation(House information) async {
    const url = '$api/house_information.json';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
        {
          'bedroom': information.bedroomNo,
          'mobile': information.mobile,
          'village': information.village.toLowerCase(),
          'district': information.district.toLowerCase(),
          'housetype': information.houseType.toLowerCase(),
          'latitude': information.latitude,
          'longitude': information.longitude,
          'street': information.street,
          'gmail': information.gmail,
        },
      ),
    );
    _email = information.gmail;
    final newHouse = House(
      bedroomNo: information.bedroomNo,
      mobile: information.mobile,
      village: information.village.toLowerCase(),
      district: information.district.toLowerCase(),
      houseType: information.houseType.toLowerCase(),
      latitude: information.latitude,
      longitude: information.longitude,
      gmail: information.gmail,
      street: information.street,
      id: json.decode(response.body)['name'],
    );
    _allHouse.add(information);
    notifyListeners();
  }

  Future<void> showHouse(String email) async {
    const url = '$api/house_information.json';
    try {
      final response = await http.get(Uri.parse(url));
      // print(response);
      final List<House> loadedHouse = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        if (email == value['gmail']) {
          loadedHouse.add(House(
            id: key,
            bedroomNo: value['bedroom'],
            mobile: value['mobile'],
            village: value['village'],
            district: value['district'],
            houseType: value['housetype'],
            latitude: value['latitude'],
            longitude: value['longitude'],
            street: value['street'],
            gmail: value['gmail'],
          ));
        }
      });
      _allHouse = loadedHouse;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteHouse(String id) async {
    final url = '$api/house_information/$id.json';
    print(id);
    final existingHouseIndex =
        _allHouse.indexWhere((element) => element.id == id);
    House existingHouse = _allHouse[existingHouseIndex];
    _allHouse.removeAt(existingHouseIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _allHouse.insert(existingHouseIndex, existingHouse);
      notifyListeners();
      throw const HttpException('Could not delete product');
    }
    existingHouse = null;
  }
}
