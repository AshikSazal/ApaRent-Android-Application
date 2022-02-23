import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

import '../variables/auth.dart';

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: const Text(
          'Log out',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          Provider.of<Auth>(context, listen: false).logout();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/main', (route) => false);
        },
      ),
    );
  }
}
