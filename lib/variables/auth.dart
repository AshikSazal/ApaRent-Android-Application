import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../exception/http_exception.dart';

class Owner {
  String name;
  String gmail;
  String mobile;
  String password;

  Owner({
    this.name,
    this.mobile,
    this.gmail,
    this.password,
  });
}

class Auth with ChangeNotifier {
  String _email;
  String _password;

  String get token {
    if (_email != null) {
      return _email;
    }
    return null;
  }

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
    _email = information.gmail;
    notifyListeners();
  }

  Future<void> _authenticate(Owner information, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDTC2c787des5SUmEYy0qcYmqYhDoP2wvY';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': information.gmail,
            'password': information.password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      // add owner information
      if (urlSegment == 'signUp' && responseData['error'] == null) {
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
        notifyListeners();
      }

      _email = information.gmail;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(Owner information) async {
    return _authenticate(information, 'signUp');
  }

  Future<void> login(Owner information) async {
    return _authenticate(information, 'signInWithPassword');
  }

  Future<void> logout() async {
    _email = null;
    notifyListeners();
  }
}
