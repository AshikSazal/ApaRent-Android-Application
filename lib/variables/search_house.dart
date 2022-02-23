import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserSearch {
  String name;
  double latitude;
  double longitude;
  String street;
  String mobile;

  UserSearch({
    this.name,
    this.latitude,
    this.longitude,
    this.street,
    this.mobile,
  });
}

class UserSearchHouse with ChangeNotifier {
  List<UserSearch> _location = [];

  List<UserSearch> get searchgetter {
    return [..._location];
  }

  Future<void> userSearchHouse(String village) async {
    const url =
        'https://bashavara-f7ebd-default-rtdb.firebaseio.com/house_information.json';
    try {
      final response = await http.get(Uri.parse(url));
      final List<UserSearch> loadHouse = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        if (village == value['village']) {
          loadHouse.add(UserSearch(
              name: value['name'],
              latitude: value['latitude'],
              longitude: value['longitude'],
              street: value['street'],
              mobile: value['mobile']));
        }
      });
      _location = loadHouse;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
