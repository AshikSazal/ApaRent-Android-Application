import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Owner {
  String name;
  String gmail;
  String mobile;
  String password;

  static const api = 'https://bashavara-f7ebd-default-rtdb.firebaseio.com';

  Owner({
    this.name,
    this.gmail,
    this.mobile,
    this.password,
  });
}

class OwnerData with ChangeNotifier {
  List<Owner> _ownerInformation = [];

  List<Owner> get ownergetter {
    return [..._ownerInformation];
  }

  static const api = 'https://bashavara-f7ebd-default-rtdb.firebaseio.com';

  Future<void> addOwnerInformation(Owner information) async {
    const url =
        'https://bashavara-f7ebd-default-rtdb.firebaseio.com/Owner_information.json';
    http.post(
      Uri.parse(url),
      body: json.encode({
        'name': information.name.toLowerCase(),
        'gmail': information.gmail.toLowerCase(),
        'mobile': information.mobile,
      }),
    );
    _ownerInformation.add(information);
    notifyListeners();
  }

  Future<void> showOwner(String email) async {
    const url =
        'https://bashavara-f7ebd-default-rtdb.firebaseio.com/Owner_information.json';
    try {
      final response = await http.get(Uri.parse(url));
      final List<Owner> loadedOwner = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        if (email == value['gmail']) {
          loadedOwner.add(Owner(
            name: value['name'],
            mobile: value['mobile'],
            gmail: email,
          ));
        }
      });
      _ownerInformation = loadedOwner;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
