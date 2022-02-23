import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OwnerShowWidget extends StatelessWidget {
  final String name;
  final String mobile;
  final String email;

  OwnerShowWidget(this.name, this.mobile, this.email);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Center(
            child: Container(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                mobile,
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                email,
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
